import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_list_view_model.dart';
import '../models/note.dart';
import 'note_edit_page.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<NoteListViewModel>(context);
    viewModel.loadNotes();

    return Scaffold(
      appBar: AppBar(
        title: Text('Заметки'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: viewModel.notes.length,
        itemBuilder: (context, index) {
          String title = viewModel.notes[index].title;
          String description = viewModel.notes[index].description;
          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(description),
              onTap: () => _editNote(context, index, viewModel.notes[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => viewModel.deleteNote(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNote(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNote(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditPage()),
    );
  }

  void _editNote(BuildContext context, int index, Note note) async {
    Note? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditPage(note: note),
      ),
    );
    if (result != null) {
      Provider.of<NoteListViewModel>(context, listen: false).editNote(index, result);
    }
  }

  void _confirmDelete(BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удалить заметку?'),
          content: Text('Вы действительно хотите удалить эту заметку?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<NoteListViewModel>(context, listen: false).deleteNote(index);
                Navigator.pop(context, true);
              },
              child: Text('Удалить'),
            ),
          ],
        );
      },
    );
  }
}