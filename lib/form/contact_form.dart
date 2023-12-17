// contact_form.dart
import 'package:flutter/material.dart';
import '../model/contact.dart';

class ContactForm extends StatefulWidget {
  final Function(Contact) onSubmit;
  final Contact? initialContact;

  const ContactForm({Key? key, required this.onSubmit, this.initialContact})
      : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.initialContact?.name ?? ''); // Set initial values if editing
    _phoneController = TextEditingController(
        text: widget.initialContact?.phone ?? '');
    _emailController = TextEditingController(
        text: widget.initialContact?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final contact = Contact(
                id: widget.initialContact?.id,
                name: _nameController.text,
                phone: _phoneController.text,
                email: _emailController.text,
              );
              widget.onSubmit(contact);
              // Navigator.pop(context); // Close the bottom sheet
            },
            child: Text(widget.initialContact != null ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }
}
