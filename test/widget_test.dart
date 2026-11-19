import 'package:flutter_test/flutter_test.dart';
import 'package:tsports_nomansho/main.dart';

void main() {
  testWidgets('Jomnittaku showcase smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JomnittakuApp());
    expect(find.textContaining('JOMNITTAKU'), findsWidgets);
  });
}
