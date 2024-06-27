// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddProductDialog extends StatefulWidget {
//   const AddProductDialog({super.key});

//   @override
//   AddProductDialogState createState() => AddProductDialogState();
// }

// class AddProductDialogState extends State<AddProductDialog> {
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   String? imageUrl;
//   bool addProductLoading = false;

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
//       print('Error picking image: $e');
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
//       print('Error uploading image: $e');
//     }
//     return null;
//   }

//   Future<bool> _addProductToFirebaseStorage() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;

//       if (user != null &&
//           descriptionController.text.isNotEmpty &&
//           imageUrl!.isNotEmpty) {
//         final imageUrl = await _uploadImage() ?? '';
//         final productRef =
//             await FirebaseFirestore.instance.collection('products').add({
//           'profileImageUrl': user.photoURL,
//           'uId': user.uid,
//           'userName': user.displayName?.trim(),
//           'content': descriptionController.text.trim(),
//           'productImage': imageUrl,
//           'amount': amountController.text.trim(),
//           'price': priceController.text.trim(),
//           'phone': phoneController.text.trim(),
//           'timestamp': DateTime.now().toString(),
//           'likedBy': [],
//         });

//         await productRef.update({'productId': productRef.id});
//         print('*****************product added with ID: ${productRef.id}');
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print('Error adding product to Firestore: $e');
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add your product'),
//       content: SingleChildScrollView(
//         child: addProductLoading == true
//             ? const Center(child: LinearProgressIndicator())
//             : Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (imageUrl != null) ...[
//                     Image.file(File(imageUrl!)),
//                     const SizedBox(height: 8),
//                   ],
//                   TextButton(
//                     onPressed: _pickImage,
//                     child: const Text('Product image'),
//                   ),
//                   const SizedBox(height: 8),
//                   TextField(
//                     controller: descriptionController,
//                     decoration: const InputDecoration(
//                       hintText: 'description',
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: null,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: amountController,
//                     decoration: const InputDecoration(
//                       hintText: 'Amount',
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: null,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: priceController,
//                     decoration: const InputDecoration(
//                       hintText: 'Price',
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: null,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: phoneController,
//                     decoration: const InputDecoration(
//                       hintText: 'phone Number',
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: null,
//                   ),
//                 ],
//               ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               addProductLoading = true;
//             });
//             _addProductToFirebaseStorage().then((value) {
//               if (value == true) {
//                 addProductLoading = false;
//                 Navigator.of(context).pop();
//               }
//             });
//           },
//           child: const Text('Add'),
//         ),
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

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key});

  @override
  AddProductDialogState createState() => AddProductDialogState();
}

class AddProductDialogState extends State<AddProductDialog> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? imageUrl;
  bool addProductLoading = false;

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
      print('Error picking image: $e');
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
      print('Error uploading image: $e');
    }
    return null;
  }

  Future<bool> _addProductToFirebaseStorage() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('User not authenticated');
      return false;
    }

    if (descriptionController.text.isEmpty || imageUrl == null) {
      print('Description or image not provided');
      return false;
    }

    setState(() {
      addProductLoading = true;
    });

    try {
      final uploadedImageUrl = await _uploadImage() ?? '';
      final productRef =
          await FirebaseFirestore.instance.collection('products').add({
        'profileImageUrl': user.photoURL,
        'uId': user.uid,
        'userName': user.displayName?.trim(),
        'content': descriptionController.text.trim(),
        'productImage': uploadedImageUrl,
        'amount': amountController.text.trim(),
        'price': priceController.text.trim(),
        'phone': phoneController.text.trim(),
        'timestamp': DateTime.now().toString(),
        'likedBy': [],
      });

      await productRef.update({'productId': productRef.id});
      print('Product added with ID: ${productRef.id}');
      return true;
    } catch (e) {
      print('Error adding product to Firestore: $e');
      return false;
    } finally {
      setState(() {
        addProductLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add your product'),
      content: SingleChildScrollView(
        child: addProductLoading
            ? const Center(child: LinearProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null) ...[
                    Image.file(File(imageUrl!)),
                    const SizedBox(height: 8),
                  ],
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text('Product image'),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: amountController,
                    hintText: 'Amount',
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: priceController,
                    hintText: 'Price',
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: phoneController,
                    hintText: 'Phone Number',
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
          onPressed: () async {
            final success = await _addProductToFirebaseStorage();
            if (success) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      maxLines: null,
    );
  }
}
