import 'package:flutter/material.dart';

Widget buildResultHeader(bool isWin) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        isWin ? 'Congratulations!' : 'Game Over!',
        style: TextStyle(
          fontSize: isWin ? 19 : 24,
          color: Colors.white,
        ),
      ),
      Text(
        isWin ? '🎉' : '😞',
        style: TextStyle(fontSize: 30),
      ),
    ],
  );
}

Widget buildTargetNumberDisplay(int targetNumber) {
  return Column(
    children: [
      Text(
        'The Number Was',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 30),
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(
          child: Text(
            '$targetNumber',
            style: TextStyle(
              fontSize: 36,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}

Widget buildPlayAgainButton(
    BuildContext context, bool isWin, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: isWin ? Colors.green[900] : Colors.red[900],
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide(color: Colors.white, width: 2),
    ),
    child: Text(
      'Play Again',
      style: TextStyle(
        fontSize: 18,
        color: isWin ? Colors.green[800] : Colors.red[800],
      ),
    ),
  );
}
