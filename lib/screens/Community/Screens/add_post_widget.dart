// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddPostDialog extends StatefulWidget {
//   const AddPostDialog({super.key});

//   @override
//   _AddPostDialogState createState() => _AddPostDialogState();
// }

// class _AddPostDialogState extends State<AddPostDialog> {
//   final TextEditingController contentController = TextEditingController();
//   String? imageUrl;
//   bool addPostLoading = false;

//   Future<void> _pickImage() async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 15,
//       );

//       if (pickedFile != null) {
//         setState(() => imageUrl = pickedFile.path);
//       }
//     } catch (e) {
//       debugPrint('Error picking image: $e');
//     }
//   }

//   Future<String?> _uploadImage() async {
//     try {
//       if (imageUrl != null) {
//         final Reference storageReference = FirebaseStorage.instance
//             .ref('images/${DateTime.now().millisecondsSinceEpoch}');
//         final TaskSnapshot taskSnapshot =
//             await storageReference.putFile(File(imageUrl!));
//         return await taskSnapshot.ref.getDownloadURL();
//       }
//     } catch (e) {
//       debugPrint('Error uploading image: $e');
//     }
//     return null;
//   }

//   Future<bool> _addPostToFirestore() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;

//       if (user != null && contentController.text.isNotEmpty) {
//         final imageUrl = await _uploadImage() ?? '';
//         final postRef =
//             await FirebaseFirestore.instance.collection('posts').add({
//           'profileImageUrl': user.photoURL,
//           'uId': user.uid,
//           'userName': user.displayName?.trim(),
//           'content': contentController.text.trim(),
//           'imageUrl': imageUrl,
//           'likes': 0,
//           'timestamp': DateTime.now().toString(),
//         });

//         await postRef.update({'postId': postRef.id});
//         debugPrint('*****************Post added with ID: ${postRef.id}');
//         return true;
//       }
//       return false;
//     } catch (e) {
//       debugPrint('Error adding post to Firestore: $e');
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add a new post'),
//       content: addPostLoading == true
//           ? const Center(child: LinearProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (imageUrl != null) ...[
//                     Image.file(File(imageUrl!)),
//                     const SizedBox(height: 8),
//                   ],
//                   TextButton(
//                     onPressed: _pickImage,
//                     child: const Text('Pick an image'),
//                   ),
//                   const SizedBox(height: 8),
//                   TextField(
//                     controller: contentController,
//                     decoration: const InputDecoration(
//                       hintText: 'What\'s on your mind?',
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: null,
//                   ),
//                 ],
//               ),
//             ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               addPostLoading = true;
//             });
//             _addPostToFirestore().then((value) {
//               if (value == true) {
//                 setState(() {
//                   addPostLoading = false;
//                   Navigator.of(context).pop();
//                 });
//               }
//             });
//           },
//           child: const Text('Post'),
//         )
//       ],
//     );
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({super.key});

  @override
  _AddPostDialogState createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  final TextEditingController contentController = TextEditingController();
  String? imageUrl;
  bool addPostLoading = false;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 15,
      );

      if (pickedFile != null) {
        setState(() => imageUrl = pickedFile.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<String?> _uploadImage() async {
    try {
      if (imageUrl != null) {
        final storageReference = FirebaseStorage.instance
            .ref('images/${DateTime.now().millisecondsSinceEpoch}');
        final taskSnapshot = await storageReference.putFile(File(imageUrl!));
        return await taskSnapshot.ref.getDownloadURL();
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
    }
    return null;
  }

  Future<bool> _addPostToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && contentController.text.isNotEmpty) {
      try {
        final uploadedImageUrl = await _uploadImage() ?? '';
        final postRef =
            await FirebaseFirestore.instance.collection('posts').add({
          'profileImageUrl': user.photoURL,
          'uId': user.uid,
          'userName': user.displayName?.trim(),
          'content': contentController.text.trim(),
          'imageUrl': uploadedImageUrl,
          'likes': 0,
          'timestamp': DateTime.now().toString(),
        });

        await postRef.update({'postId': postRef.id});
        debugPrint('Post added with ID: ${postRef.id}');
        return true;
      } catch (e) {
        debugPrint('Error adding post to Firestore: $e');
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new post'),
      content: addPostLoading
          ? const Center(child: LinearProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null) ...[
                    Image.file(File(imageUrl!)),
                    const SizedBox(height: 8),
                  ],
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text('Pick an image'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _handlePost,
          child: const Text('Post'),
        )
      ],
    );
  }

  Future<void> _handlePost() async {
    setState(() {
      addPostLoading = true;
    });
    final success = await _addPostToFirestore();
    if (success) {
      setState(() {
        addPostLoading = false;
        Navigator.of(context).pop();
      });
    }
  }
}
