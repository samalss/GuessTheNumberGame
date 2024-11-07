abstract class GameEvent {}

class StartGame extends GameEvent {
  final int maxNumber;
  final int attempts;

  StartGame(this.maxNumber, this.attempts);
}

class MakeGuess extends GameEvent {
  final int guess;

  MakeGuess(this.guess);
}

class ResetGame extends GameEvent {}
