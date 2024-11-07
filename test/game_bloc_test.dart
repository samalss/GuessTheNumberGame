import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:guess_number_game/bloc/game_bloc.dart';
import 'package:guess_number_game/bloc/game_event.dart';
import 'package:guess_number_game/bloc/game_state.dart';

void main() {
  group('GameBloc Tests', () {
    late GameBloc gameBloc;

    setUp(() {
      gameBloc = GameBloc();
    });

    tearDown(() {
      gameBloc.close();
    });

    blocTest<GameBloc, GameState>(
      'emits [GameInProgress] when StartGame is added',
      build: () => gameBloc,
      act: (bloc) => bloc.add(StartGame(100, 5)),
      expect: () => [
        isA<GameInProgress>()
            .having((state) => state.maxNumber, 'maxNumber', 100)
            .having((state) => state.attemptsLeft, 'attemptsLeft', 5),
      ],
    );
  });
}
