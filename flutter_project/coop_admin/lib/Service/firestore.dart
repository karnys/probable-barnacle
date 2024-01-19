import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // CRATE: add a new note
  Future<void> addNote(String email, String pass) async {
    try {
      await notes.add({
        'Email': email,
        'pasword': pass,
        'timestamp': Timestamp.now(),
      });
      print('Note added successfully.');
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  // READ: get notes from database

  // UPDATE: update notes given a doc id

  // DELETE: delete notes given a doc id
}
