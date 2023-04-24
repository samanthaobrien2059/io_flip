// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:top_dash_ui/top_dash_ui.dart';

void main() {
  group('IoFlipScaffold', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: IoFlipScaffold(
            body: Center(child: Text('Test')),
          ),
        ),
      );

      expect(
        find.byType(IoFlipScaffold),
        findsOneWidget,
      );
    });
  });
}