abstract class GameState {}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final int maxNumber;
  final int attemptsLeft;
  final String hint;

  GameInProgress(this.maxNumber, this.attemptsLeft, {this.hint = ''});
}

class GameWin extends GameState {
  final int targetNumber;

  GameWin(this.targetNumber);
}

class GameLose extends GameState {
  final int targetNumber;

  GameLose(this.targetNumber);
}
