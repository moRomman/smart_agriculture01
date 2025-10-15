import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostUtils {
  // Save a value (e.g., UID)
  static Future<void> saveUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  // Retrieve the saved UID
  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  // Add a comment to a Firestore post
  static Future<void> addCommentToFirestorePost(
      String postId, String comment) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final now = DateTime.now();
        final formattedTimestamp =
            '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}';

        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .add({
          'userId': user.uid,
          'userName': user.displayName,
          'comment': comment,
          'timestamp': formattedTimestamp,
        });

        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'commentsCount': FieldValue.increment(1),
        });
      }
    } catch (e) {
      debugPrint('Error adding comment to post: $e');
    }
  }

  // Get comments for a Firestore post
  static Future<List<Map<String, dynamic>>> getPostComments(
      String postId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint('Error getting comments for post: $e');
      return [];
    }
  }

  // Add or remove a like from a Firestore post
  static Future<void> toggleLikeOnPost(String postId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final hasLiked = await hasUserLikedPost(postId, user.uid);

        final updateData = {
          'likes': FieldValue.increment(hasLiked ? -1 : 1),
          'likedBy': hasLiked
              ? FieldValue.arrayRemove([user.uid])
              : FieldValue.arrayUnion([user.uid]),
        };

        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update(updateData);
      }
    } catch (e) {
      debugPrint('Error toggling like on post: $e');
    }
  }

  // Add or remove a favorite product
  static Future<void> toggleFavoriteProduct(String productId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final isFav = await isFavoriteProduct(productId);

        final updateData = {
          'likedBy': isFav
              ? FieldValue.arrayRemove([user.uid])
              : FieldValue.arrayUnion([user.uid]),
        };

        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update(updateData);
      }
    } catch (e) {
      debugPrint('Error toggling favorite product: $e');
    }
  }

  // Check if a product is a favorite
  static Future<bool> isFavoriteProduct(String productId) async {
    try {
      final postSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      final likedBy = postSnapshot['likedBy'] as List<dynamic>?;

      return likedBy != null &&
          likedBy.contains(FirebaseAuth.instance.currentUser?.uid);
    } catch (e) {
      debugPrint('Error checking if product is favorite: $e');
      return false;
    }
  }

  // Check if a user has liked a post
  static Future<bool> hasUserLikedPost(String postId, String userId) async {
    try {
      final postSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .get();
      final likedBy = postSnapshot['likedBy'] as List<dynamic>?;

      return likedBy != null && likedBy.contains(userId);
    } catch (e) {
      debugPrint('Error checking if user liked post: $e');
      return false;
    }
  }
}
