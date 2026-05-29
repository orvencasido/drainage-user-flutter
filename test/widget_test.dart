import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:toda_go/main.dart';

void main() {
  testWidgets('Dashboard smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title 'Drainage Monitor' is present.
    expect(find.text('Drainage Monitor'), findsOneWidget);
    
    // Verify that the status text starting as 'Normal' is present.
    expect(find.text('Normal'), findsOneWidget);
    
    // Verify that the refresh button icon is present.
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);
  });
}
