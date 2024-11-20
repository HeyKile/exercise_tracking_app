import 'package:flutter/material.dart';

class AddNotesPopup extends StatefulWidget {
  final String? existingNote;
  final ValueChanged<String> onSave;

  const AddNotesPopup({super.key, this.existingNote, required this.onSave});

  @override
  // ignore: library_private_types_in_public_api
  _AddNotesPopupState createState() => _AddNotesPopupState();
}

class _AddNotesPopupState extends State<AddNotesPopup> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.existingNote); // the controller is populated with the existing note which is saved. that part is done in exercise tile
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog( // made it a popup
      title: const Text('Add Notes'), // to add notes
      content: TextField(
        controller: _notesController, // text field controller
        maxLines: 5,
        decoration: const InputDecoration( 
          border: OutlineInputBorder(),
          hintText: 'Enter your notes here...',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () { // if cancelled, it'll just leave
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () { // if saved, it'll put it with controller
            widget.onSave(_notesController.text);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}