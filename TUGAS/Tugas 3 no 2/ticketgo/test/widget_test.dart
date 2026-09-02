import 'package:flutter_test/flutter_test.dart';
import 'package:ticketgo/main.dart';

void main() {
  testWidgets('TicketGo berhasil dijalankan', (WidgetTester tester) async {
    await tester.pumpWidget(const TicketGo());

    expect(find.text('TicketGo'), findsOneWidget);
  });
}
