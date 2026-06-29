import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trash_tornado/main.dart';

void main() {
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
