import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../widgets/result_widgets.dart';

class ResultScreen extends StatefulWidget {
  final bool isWin;
  final int targetNumber;

  ResultScreen({required this.isWin, required this.targetNumber});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));

    if (widget.isWin) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.isWin
              ? [Colors.green[800]!, Colors.green[300]!]
              : [Colors.red[900]!, Colors.red[400]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildResultHeader(widget.isWin),
                  SizedBox(height: 30),
                  buildTargetNumberDisplay(widget.targetNumber),
                  SizedBox(height: 30),
                  buildPlayAgainButton(
                    context,
                    widget.isWin,
                    () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            if (widget.isWin)
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: [
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.purple
                  ],
                  gravity: 0.5,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
