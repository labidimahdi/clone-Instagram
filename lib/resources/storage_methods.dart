import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
// import 'dart:typed_data';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:uuid/uuid.dart';

// class StorageMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   // Uploads an image to Firebase Storage
//   Future<String> uploadImageToStorage(
//       String childName, Uint8List file, bool isPost) async {
//     try {
//       // Check if the user is authenticated
//       User? user = _auth.currentUser;
//       if (user == null) {
//         throw Exception("User not authenticated");
//       }

//       // Create a reference to the storage location
//       Reference ref = _storage.ref().child(childName).child(user.uid);

//       // If it's a post, generate a unique ID
//       if (isPost) {
//         String id = const Uuid().v1();
//         ref = ref.child(id);
//       }

//       // Upload the file
//       UploadTask uploadTask = ref.putData(file);

//       // Wait for the upload to complete
//       TaskSnapshot snapshot = await uploadTask;

//       // Get the download URL
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print("Error uploading image: $e");
//       throw e; // Rethrow the exception for the caller to handle
//     }
//   }
// }
