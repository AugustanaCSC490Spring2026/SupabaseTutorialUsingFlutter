import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tutorial/note.dart';

class NoteDatabase {
  // Database -> notes
  // conntects to the 'notes' table in supabase which allows to perform queries
  final database = Supabase.instance.client.from('notes');

  // Create
  // to write to the db and takes a Note object is input
  Future createNote(Note newNote) async {
    // converts the Note object into a map and puts it into a new row
    await database.insert(newNote.toMap());
  }

  // Read
  // creates a real-time stream of notes from the db
  // automatically updates the UI when something in the db changes
  final stream = Supabase.instance.client.from('notes').stream(
    primaryKey: ['id'],
    // list of maps -> list of Note objects
  ).map((data) => data.map((noteMap) => Note.fromMap(noteMap)).toList());

  // Update
  // updates the content of an existing note
  Future updateNote(Note oldNote, String newContent) async {
    await database.update
      ({'content': newContent})
      // id has to match in order to update
      .eq('id', oldNote.id!);
  }

  // Delete
  // deletes a note from the db
  Future deleteNote(Note note) async {
    // id has to match in order to delete
    await database.delete().eq('id', note.id!);
  }
}