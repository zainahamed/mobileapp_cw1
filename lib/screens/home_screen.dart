// home_screen.dart
import 'package:flutter/material.dart';
import '../db_helper/database_handler.dart';
import '../model/contact.dart';
import '../form/contact_form.dart';
import 'delete_confirmation_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseHandler handler;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
    handler.initializeDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Contacts App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: handler.retrieveContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final contacts = snapshot.data!
                .map((contact) => Contact.fromMap(contact))
                .toList();

            // Filter contacts based on the search query
            final filteredContacts = contacts.where((contact) {
              final query = searchController.text.toLowerCase();
              return contact.name.toLowerCase().contains(query) ||
                  contact.phone.toLowerCase().contains(query) ||
                  contact.email.toLowerCase().contains(query);
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {}); // Rebuild the widget on search input changes
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Contacts',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredContacts[index].name),
                        subtitle: Text(filteredContacts[index].phone),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmation(context, filteredContacts[index]);
                          },
                        ),
                        onTap: () {
                          _showUpdateBottomSheet(context, filteredContacts[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ContactForm(
              onSubmit: (contact) async {
                await handler.insertContact(contact.toMap());
                setState(() {});
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          ),
        );
      },
    );
  }

  void _showUpdateBottomSheet(BuildContext context, Contact contact) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ContactForm(
          onSubmit: (updatedContact) async {
            await handler.updateContact(updatedContact.toMap());
            setState(() {});
            Navigator.pop(context); // Close the bottom sheet
          },
          initialContact: contact,
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Contact contact) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DeleteConfirmationBottomSheet(
          onDelete: () async {
            await handler.deleteContact(contact.id!);
            setState(() {});
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
  }
}

