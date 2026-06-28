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
}
