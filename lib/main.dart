import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/note_list_page.dart';
import 'viewmodels/note_list_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteListViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заметки',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteListPage(),
    );
  }
}