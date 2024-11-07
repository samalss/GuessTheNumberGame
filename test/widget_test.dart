import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guess_number_game/bloc/game_bloc.dart';
import 'package:guess_number_game/bloc/game_event.dart';
import 'package:guess_number_game/screens/game_screen.dart';

void main() {
  testWidgets('GameScreen displays correctly', (WidgetTester tester) async {
    final gameBloc = GameBloc();

    await tester.pumpWidget(
      BlocProvider<GameBloc>.value(
        value: gameBloc,
        child: MaterialApp(home: GameScreen()),
      ),
    );

    gameBloc.add(StartGame(100, 5));
    await tester.pumpAndSettle();

    expect(find.text('Guess The Number'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '50');
    await tester.tap(find.text('Guess'));
    await tester.pump();

    expect(find.textContaining('Attempts Left'), findsOneWidget);

    gameBloc.close();
  });

  testWidgets('Settings dialog opens and updates the game',
      (WidgetTester tester) async {
    final gameBloc = GameBloc();

    await tester.pumpWidget(
      BlocProvider<GameBloc>.value(
        value: gameBloc,
        child: MaterialApp(home: GameScreen()),
      ),
    );

    gameBloc.add(StartGame(100, 5));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Max Number'), '50');
    await tester.enterText(find.widgetWithText(TextField, 'Attempts'), '3');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    gameBloc.add(StartGame(50, 3));
    await tester.pumpAndSettle();

    expect(
        find.textContaining('Find number between\n1 and 50'), findsOneWidget);

    gameBloc.close();
  });

  testWidgets('Win screen displays when the correct number is guessed',
      (WidgetTester tester) async {
    final gameBloc = GameBloc();

    await tester.pumpWidget(
      BlocProvider<GameBloc>.value(
        value: gameBloc,
        child: MaterialApp(home: GameScreen()),
      ),
    );

    gameBloc.add(StartGame(1, 5));
    await tester.pumpAndSettle();
    gameBloc.add(MakeGuess(1));
    await tester.pumpAndSettle();

    expect(find.text('Congratulations!'), findsOneWidget);
    expect(find.textContaining('The Number Was'), findsOneWidget);

    gameBloc.close();
  });

  testWidgets('Lose screen displays when attempts are exhausted',
      (WidgetTester tester) async {
    final gameBloc = GameBloc();

    await tester.pumpWidget(
      BlocProvider<GameBloc>.value(
        value: gameBloc,
        child: MaterialApp(home: GameScreen()),
      ),
    );

    gameBloc.add(StartGame(100, 1));
    await tester.pumpAndSettle();

    gameBloc.add(MakeGuess(1));
    await tester.pumpAndSettle();

    expect(find.text('Game Over!'), findsOneWidget);
    expect(find.textContaining('The Number Was'), findsOneWidget);

    gameBloc.close();
  });

  testWidgets('Hint is displayed after an incorrect guess',
      (WidgetTester tester) async {
    final gameBloc = GameBloc();

    await tester.pumpWidget(
      BlocProvider<GameBloc>.value(
        value: gameBloc,
        child: MaterialApp(home: GameScreen()),
      ),
    );

    gameBloc.add(StartGame(100, 5));
    await tester.pumpAndSettle();

    gameBloc.add(MakeGuess(1));
    await tester.pumpAndSettle();

    expect(find.text('Hint: Higher'), findsOneWidget);

    gameBloc.close();
  });
}
