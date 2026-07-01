import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trash_tornado/main.dart';

void main() {
  test('campaign includes at least thirty cleanup levels', () {
    expect(totalCleanupLevels, greaterThanOrEqualTo(30));
  });

  test('each game mode has a unique gameplay background', () {
    expect(gameModeBackgroundAssets, hasLength(4));
    expect(gameModeBackgroundAssets.toSet(), hasLength(4));
    expect(
      gameModeBackgroundAssets,
      everyElement(contains('assets/images/mode_bg_')),
    );
  });

  test('clean sorting target earns three stars even with modest score', () {
    expect(
      calculateStarsForRun(
        score: 1100,
        hearts: 5,
        sortedCount: 12,
        missedCleanCount: 0,
        toxicHits: 0,
        modeIndex: 0,
      ),
      3,
    );
    expect(
      calculateStarsForRun(
        score: 1100,
        hearts: 5,
        sortedCount: 12,
        missedCleanCount: 2,
        toxicHits: 1,
        modeIndex: 0,
      ),
      lessThan(3),
    );
  });

  test(
    'hazard bin receives sortable hazard waste while barrels stay avoid-only',
    () {
      final WasteItem hazardWaste = WasteItem(
        id: 1,
        type: WasteType.toxic,
        asset: GameArt.trashToxicBarrel,
        position: Offset.zero,
        velocity: Offset.zero,
        size: 64,
        spin: 0,
      );
      final WasteItem toxicBarrel = WasteItem(
        id: 2,
        type: WasteType.toxic,
        kind: DropKind.toxicBarrel,
        asset: GameArt.trashToxicBarrel,
        position: Offset.zero,
        velocity: Offset.zero,
        size: 72,
        spin: 0,
      );

      expect(sortableWasteTypesForTesting, contains(WasteType.toxic));
      expect(hazardWaste.type.bin, BinType.hazard);
      expect(isSortableWasteForTesting(hazardWaste), isTrue);
      expect(isToxicObstacleForTesting(hazardWaste), isFalse);
      expect(isSortableWasteForTesting(toxicBarrel), isFalse);
      expect(isToxicObstacleForTesting(toxicBarrel), isTrue);
    },
  );

  test('release path can sort after crossing the correct bin', () {
    const Size playSize = Size(400, 800);
    final List<Offset> path = <Offset>[
      const Offset(250, 610),
      const Offset(250, 715),
      const Offset(250, 620),
    ];

    expect(
      binHitByReleasePathForTesting(
        size: playSize,
        path: path,
        preferredBin: BinType.paper,
      ),
      BinType.paper,
    );
  });

  testWidgets('Trash Tornado opens menu and navigates core screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TrashTornadoApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('TRASH'), findsOneWidget);
    expect(find.text('TORNADO'), findsOneWidget);
    expect(find.text('PLAY'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.cyclone_rounded).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.text('SKINS'), findsOneWidget);
    expect(find.text('Ocean'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.map_rounded).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.text('WORLD MAP'), findsOneWidget);
    expect(find.textContaining('Green Park'), findsOneWidget);
  });

  testWidgets('new player play flow opens tutorial first', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TrashTornadoApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    await tester.tap(find.text('PLAY'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.textContaining('Tutorial 1/3'), findsOneWidget);
    expect(find.text('Drag to recycle'), findsOneWidget);
    expect(find.textContaining('Move the blue bottle'), findsOneWidget);
  });

  testWidgets('mode cards start the selected ruleset', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const TrashTornadoApp(initialView: GameView.modes, screenshotMode: true),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('GAME MODES'), findsOneWidget);
    expect(find.text('Time Attack'), findsOneWidget);
    expect(find.text('30S'), findsOneWidget);

    await tester.tap(find.text('START').at(1));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('38'), findsOneWidget);
    expect(find.byIcon(Icons.pause_rounded), findsOneWidget);
  });

  testWidgets('back button asks before quitting an active run', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TrashTornadoApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    await tester.tap(find.text('PLAY'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.textContaining('Tutorial 1/3'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('Quit Game?'), findsOneWidget);
    expect(find.text('Do you want to quit the game?'), findsOneWidget);

    await tester.tap(find.text('KEEP PLAYING'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.textContaining('Tutorial 1/3'), findsOneWidget);
  });

  testWidgets('shop exposes Eco Blast and result screen keeps earned stars', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const TrashTornadoApp(initialView: GameView.shop, screenshotMode: true),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    await tester.scrollUntilVisible(
      find.text('Eco Blast'),
      180,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Eco Blast'), findsOneWidget);
    expect(find.textContaining('Clears every falling trash'), findsOneWidget);

    await tester.pumpWidget(
      const TrashTornadoApp(
        key: ValueKey<String>('complete-screen'),
        initialView: GameView.complete,
        screenshotMode: true,
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.text('CLEAN CITY!'), findsOneWidget);
    expect(find.byIcon(Icons.star_rounded), findsWidgets);
  });
}
