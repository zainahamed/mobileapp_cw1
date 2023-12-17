// delete_confirmation_bottom_sheet.dart
import 'package:flutter/material.dart';

import 'home_screen.dart';

class DeleteConfirmationBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteConfirmationBottomSheet({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to delete this contact?',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Delete'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
