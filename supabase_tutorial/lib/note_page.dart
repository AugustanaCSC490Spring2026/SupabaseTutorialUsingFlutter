import 'package:flutter/material.dart';
import 'package:supabase_tutorial/note.dart';
import 'package:supabase_tutorial/note_database.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

// builds the UI
class _NotePageState extends State<NotePage> {

  // notes db
  final notesDatabase = NoteDatabase();

  // text controller
  // can read user input, save it, or clear it
  final noteController = TextEditingController();

  /* --------------------CRUD-------------------- */

  // CREATE
  // user wants to add new note
  void addNewNote() {
    showDialog(
      context: context,
      // creates a Note object, calls the db and puts the note in the db
      builder:(context) => AlertDialog(
        title: const Text("New Note"),
        content: TextField(
          controller: noteController,

        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text("Cancel"),
          ),


          // save button
          TextButton(
            onPressed: () {
              // create a new note
              final newNote = Note(content: noteController.text);

              // save in db
              notesDatabase.createNote(newNote);


              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // UPDATE
  // user wants to update note
  // takes an existing note and updates the content in it
  void updateNote(Note note) {
    // pre-fill text controller with existing note
    noteController.text = note.content;
    showDialog(
      context: context,
      // takes a Note object, calls the db and updates the note in the db
      builder:(context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(
          controller: noteController,
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text("Cancel"),
            ),
          // save button
          TextButton(
            onPressed: () {
              // save in db
              notesDatabase.updateNote(note, noteController.text);
              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // DELETE
  // user wants to delete note
  // removes the row
  void deleteNote(Note note) {
    showDialog(
      context: context,
      // takes a Note object, calls the db and deletes the note in the db
      builder:(context) => AlertDialog(
        title: const Text("Delete Note?"),
        actions: [
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text("Cancel"),
            ),
          // save button
          TextButton(
            onPressed: () {
              // save in db
              notesDatabase.deleteNote(note);
              Navigator.pop(context);
              noteController.clear();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  // READ
  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text("Notes"),
      ),
      // Button
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),

      // Body -> Stream Builder
      // StreamBuilder listens the the db stream and automatically rebuilds the UI when the db changes
      body: StreamBuilder(

        // listens to this stream..
        stream: notesDatabase.stream,

        // to build our UI..
        builder: (context, snapshot) {

          // loading..
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // loaded!
          // gives a list of Notes from Supabase and already converts from Map -> Note
          final notes = snapshot.data!;

          // list of notes UI
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {

              // get each note
              final note = notes[index];

              // list title UI
              return ListTile(
                title: Text(note.content),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [

                      //update button
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: const Icon(Icons.edit),
                      ),

                      // delete button
                      IconButton(
                        onPressed: () => deleteNote(note),
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  )
                )
              );
            },
          );
        },
      )
    );
  }
  }



