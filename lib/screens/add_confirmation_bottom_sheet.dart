// add_confirmation_bottom_sheet.dart
import 'package:flutter/material.dart';

class AddConfirmationBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Contact Added Successfully!',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
