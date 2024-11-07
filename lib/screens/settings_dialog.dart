import 'package:flutter/material.dart';

Widget buildSettingsDialog({
  required BuildContext context,
  required TextEditingController maxNumberController,
  required TextEditingController attemptsController,
  required VoidCallback onSave,
}) {
  return AlertDialog(
    backgroundColor: Colors.blue[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Colors.white, width: 2),
    ),
    title: Center(
      child: Text(
        'Settings',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: maxNumberController,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 12, color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Max Number',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
            filled: true,
            fillColor: Colors.blue[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: attemptsController,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 12, color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Attempts',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
            filled: true,
            fillColor: Colors.blue[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Close',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          onSave();
        },
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
