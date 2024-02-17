import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('images/$fileName').putFile(file);
      print('File uploaded successfully.');
    } catch (e) {
      print('An error occurred while uploading the file: $e');
    }
  }

  Future<firebase_storage.FullMetadata?> getMetadata(String fileName) async {
    try {
      final firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('images/$fileName');
      return await ref.getMetadata();
    } catch (e) {
      print('An error occurred while getting metadata: $e');
      return null;
    }
  }

  Future<List<firebase_storage.Reference>> listFiles() async {
    try {
      firebase_storage.ListResult result =
          await storage.ref('images').listAll();
      List<firebase_storage.Reference> files = result.items;
      files.forEach((firebase_storage.Reference ref) {
        print('Found file: $ref');
      });
      return files;
    } catch (e) {
      print('An error occurred while listing files: $e');
      return [];
    }
  }

  Future<String> downloadURL(String imageName) async {
    try {
      String downloadURL =
          await storage.ref('images/$imageName').getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('An error occurred while getting download URL: $e');
      return '';
    }
  }

  Future<List<String>> listAllFiles() async {
    try {
      firebase_storage.ListResult result =
          await storage.ref('images').listAll();
      List<String> fileNames = result.items
          .map((firebase_storage.Reference ref) => ref.name)
          .toList();
      return fileNames;
    } catch (e) {
      print('An error occurred while listing files: $e');
      return [];
    }
  }

  Future<String> getDownloadURL(String fileName) async {
    try {
      String downloadURL =
          await storage.ref('images/$fileName').getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('An error occurred while getting download URL: $e');
      return '';
    }
  }
}
