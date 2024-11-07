import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_number_game/screens/result_screen.dart';
import '../screens/settings_dialog.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';
import '../widgets/game_widgets.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _maxNumberController =
      TextEditingController(text: '100');
  final TextEditingController _attemptsController =
      TextEditingController(text: '10');

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    final maxNumber = int.tryParse(_maxNumberController.text) ?? 100;
    final attempts = int.tryParse(_attemptsController.text) ?? 10;
    context.read<GameBloc>().add(StartGame(maxNumber, attempts));
  }

  void _makeGuess() {
    final guess = int.tryParse(_controller.text);
    if (guess != null) {
      context.read<GameBloc>().add(MakeGuess(guess));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[900]!, Colors.blueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Guess The Number',
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: _showSettingsDialog,
            ),
          ],
        ),
        body: Center(
          child: BlocListener<GameBloc, GameState>(
            listener: (context, state) async {
              if (state is GameWin || state is GameLose) {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: context.read<GameBloc>(),
                      child: ResultScreen(
                        isWin: state is GameWin,
                        targetNumber: state is GameWin
                            ? state.targetNumber
                            : (state as GameLose).targetNumber,
                      ),
                    ),
                  ),
                );
                _startNewGame();
              }
            },
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                if (state is GameInProgress) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildNumberRangeText(state.maxNumber),
                      SizedBox(height: 20),
                      buildMysteryBox(),
                      SizedBox(height: 20),
                      buildGuessInput(_controller, _makeGuess),
                      SizedBox(height: 20),
                      buildAttemptsLeft(state.attemptsLeft),
                      if (state.hint.isNotEmpty) ...[
                        SizedBox(height: 5),
                        buildHintText(state.hint),
                      ],
                      SizedBox(height: 20),
                      buildGuessButton(_makeGuess),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => buildSettingsDialog(
        context: context,
        maxNumberController: _maxNumberController,
        attemptsController: _attemptsController,
        onSave: _startNewGame,
      ),
    );
  }
}
