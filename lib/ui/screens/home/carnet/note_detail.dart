import 'package:fireapp/models/note.dart';
import 'package:flutter/material.dart';

class NoteDetail extends StatelessWidget {
  const NoteDetail({super.key, required this.note});

  final Note note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('${note.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("${note.content}"),
          ],
        ),
      ),
    );
  }
}
