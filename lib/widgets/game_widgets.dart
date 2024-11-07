import 'package:flutter/material.dart';

Widget buildTitle() {
  return Text(
    'Guess The Number',
    style: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
  );
}

Widget buildNumberRangeText(int maxNumber) {
  return Text(
    'Find number between\n1 and $maxNumber',
    style: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    textAlign: TextAlign.center,
  );
}

Widget buildMysteryBox() {
  return Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: Center(
      child: Text(
        '?',
        style: TextStyle(
          fontSize: 50,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget buildGuessInput(
    TextEditingController controller, VoidCallback onSubmitted) {
  return Container(
    width: 140,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.blue[800],
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        hintText: 'Enter...',
        hintStyle: TextStyle(fontSize: 14, color: Colors.blue[800]),
        contentPadding: EdgeInsets.all(0),
      ),
      onSubmitted: (_) => onSubmitted(),
    ),
  );
}

Widget buildAttemptsLeft(int attemptsLeft) {
  return Text(
    'Attempts Left: $attemptsLeft',
    style: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
  );
}

Widget buildHintText(String hint) {
  return Text(
    'Hint: $hint',
    style: TextStyle(
      fontSize: 14,
      color: Colors.yellow[500],
    ),
  );
}

Widget buildGuessButton(VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide(color: Colors.white, width: 2),
    ),
    child: Text(
      'Guess',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}
