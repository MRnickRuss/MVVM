import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NoteListViewModel with ChangeNotifier {
  List<Note> notes = [];

  Future loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notes = (prefs.getStringList('notes') ?? []).map((note) {
      List<String> noteData = note.split(',');
      return Note(
        title: noteData[0],
        description: noteData[1],
      );
    }).toList();
    notifyListeners();
  }

  Future saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedNotes = notes.map((note) {
      return '${note.title},${note.description}';
    }).toList();
    await prefs.setStringList('notes', savedNotes);
  }

  void addNote(Note note) {
    notes.add(note);
    saveNotes();
    notifyListeners();
  }

  void editNote(int index, Note note) {
    notes[index] = note;
    saveNotes();
    notifyListeners();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    saveNotes();
    notifyListeners();
  }
}