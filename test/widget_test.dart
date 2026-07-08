import 'package:drip_society/drip_society_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Coffee storefront renders offline products', (WidgetTester tester) async {
    await tester.pumpWidget(const DripSocietyApp());

    expect(find.text('Drip Coffee'), findsOneWidget);
    expect(find.text('Search coffee'), findsOneWidget);
    expect(find.text('Espresso'), findsOneWidget);
    expect(find.text('Latte'), findsOneWidget);
    expect(find.text('Add'), findsWidgets);
  });
}
