import 'dart:developer' as developer;
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late int _targetNumber;
  late int _attemptsLeft;
  int _maxNumber;

  GameBloc()
      : _maxNumber = 100,
        super(GameInitial()) {
    on<StartGame>(_mapStartGameToState);
    on<MakeGuess>(_mapMakeGuessToState);
    on<ResetGame>(_mapResetGameToState);
  }

  void _mapStartGameToState(StartGame event, Emitter<GameState> emit) {
    _maxNumber = event.maxNumber;
    _attemptsLeft = event.attempts;
    _targetNumber = Random().nextInt(_maxNumber) + 1;

    developer.log(
        'Game started: target=$_targetNumber, maxNumber=$_maxNumber, attempts=$_attemptsLeft');
    emit(GameInProgress(_maxNumber, _attemptsLeft));
  }

  void _mapMakeGuessToState(MakeGuess event, Emitter<GameState> emit) {
    if (event.guess == _targetNumber) {
      developer.log('Correct guess: ${event.guess}');
      emit(GameWin(_targetNumber));
    } else {
      _attemptsLeft--;
      final hint = event.guess < _targetNumber ? 'Higher' : 'Lower';
      developer.log(
          'Incorrect guess: ${event.guess}, hint: $hint, attempts left: $_attemptsLeft');

      if (_attemptsLeft <= 0) {
        emit(GameLose(_targetNumber));
      } else {
        emit(GameInProgress(_maxNumber, _attemptsLeft, hint: hint));
      }
    }
  }

  void _mapResetGameToState(ResetGame event, Emitter<GameState> emit) {
    developer.log('Game reset');
    emit(GameInitial());
  }
}
