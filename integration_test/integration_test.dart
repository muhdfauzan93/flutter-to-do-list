import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todolist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Add to do list', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    Finder addTodo = find.byKey(const Key('add_todo_button'));
    await tester.tap(addTodo);
    await tester.pumpAndSettle();

    Finder title = find.byKey(const Key('title_field'));
    await tester.enterText(title, 'Integration Test');
    await tester.pumpAndSettle();

    Finder startDate = find.byKey(const Key('start_date_field'));
    await tester.tap(startDate);
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    Finder endDate = find.byKey(const Key('end_date_field'));
    await tester.tap(endDate);
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    Finder createButton = find.byKey(const Key('create_button'));
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    Finder todoTitle = find.text("Integration Test");
    expect(todoTitle, findsOneWidget);
  });

  testWidgets('Edit to do list', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    Finder todoTitle = find.text("Integration Test");
    expect(todoTitle, findsOneWidget);

    await tester.tap(todoTitle);
    await tester.pumpAndSettle();

    Finder title = find.byKey(const Key('title_field'));
    await tester.tap(title);
    await tester.pumpAndSettle();

    await tester.enterText(title, 'Update Integration Test');
    await tester.pumpAndSettle();

    Finder saveButton = find.byKey(const Key('create_button'));
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text("Update Integration Test"), findsOneWidget);
  });

  testWidgets('Tick task as completed', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    Finder todoTitle = find.text("Update Integration Test");
    expect(todoTitle, findsOneWidget);

    Finder checkbox = find.byKey(const Key('checkbox'));
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(find.text("Completed"), findsOneWidget);
  });

  testWidgets('Delete task', (widgetTester) async {
    app.main();
    await widgetTester.pumpAndSettle();

    await widgetTester.drag(find.byType(Dismissible), const Offset(-500, 0));
    await widgetTester.pumpAndSettle();

    expect(find.text("Update Integration Test"), findsNothing);
  });
}
