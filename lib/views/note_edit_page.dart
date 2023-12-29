import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_list_view_model.dart';
import '../models/note.dart';

class NoteEditPage extends StatelessWidget {
  final Note? note;

  NoteEditPage({this.note});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: note?.title);
    TextEditingController descriptionController = TextEditingController(text: note?.description);

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Добавить заметку' : 'Редактировать заметку'),
        actions: [
          IconButton(
            onPressed: () => _saveNote(context, titleController.text, descriptionController.text),
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Заголовок',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Текст',
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote(BuildContext context, String title, String description) {
    Note note = Note(
      title: title,
      description: description,
    );
    Provider.of<NoteListViewModel>(context, listen: false).addNote(note);
    Navigator.pop(context);
  }
}