// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_agriculture/screens/Community/Repository/post_model.dart';
// import 'package:smart_agriculture/screens/Community/Screens/comments_bottom_sheet.dart';

// import '../Repository/post_repository.dart';

// class PostWidget extends StatefulWidget {
//   final Post post;

//   const PostWidget({super.key, required this.post});

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   List<Map<String, dynamic>> comments = [];

//   Future<void> fetchCommentsData() async {
//     try {
//       List<Map<String, dynamic>> fetchedComments =
//           await PostUtils.getPostComments(widget.post.postId);
//       setState(() {
//         comments = fetchedComments;
//       });
//     } catch (e) {
//       debugPrint('Error fetching comments: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Card(
//         color: Colors.white.withOpacity(0.8),
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildUserInfo(),
//               const SizedBox(height: 8.0),
//               _buildPostContent(),
//               if (widget.post.postImage.isNotEmpty) ...[
//                 const SizedBox(height: 8.0),
//                 _buildPostImage(),
//               ],
//               const SizedBox(height: 12.0),
//               _buildPostMetrics(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserInfo() {
//     return Row(
//       children: [
//         CircleAvatar(
//           backgroundColor: Colors.blue,
//           radius: 20.0,
//           backgroundImage: NetworkImage(widget.post.profileImageUrl),
//           onBackgroundImageError: (_, __) =>
//               const AssetImage('images/splash.jpg'),
//         ),
//         const SizedBox(width: 10.0),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.post.userName,
//                 style: const TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 widget.post.postTime,
//                 style: const TextStyle(
//                   fontSize: 14.0,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (widget.post.postUId == FirebaseAuth.instance.currentUser!.uid) ...{
//           IconButton.filledTonal(
//             onPressed: () async {
//               await FirebaseFirestore.instance
//                   .collection('posts')
//                   .doc(widget.post.postId)
//                   .delete();
//             },
//             icon: const Icon(Icons.delete),
//           )
//         }
//       ],
//     );
//   }

//   Widget _buildPostContent() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         widget.post.postContent,
//         textScaler: widget.post.postImage.isEmpty
//             ? const TextScaler.linear(1.8)
//             : const TextScaler.linear(1.4),
//         style: const TextStyle(
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildPostImage() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Image.network(
//         widget.post.postImage,
//         fit: BoxFit.cover,
//         errorBuilder: (_, __, ___) => const Image(
//           image: AssetImage('images/splash.jpg'),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildPostMetrics(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _buildLikeButton(),
//         _buildCommentButton(context),
//       ],
//     );
//   }

//   Widget _buildLikeButton() {
//     return ElevatedButton.icon(
//       onPressed: () {
//         PostUtils.toggleLikeOnPost(widget.post.postId);
//       },
//       style: ElevatedButton.styleFrom(
//         foregroundColor: widget.post.likesCount > 0 ? Colors.red : Colors.grey,
//         backgroundColor: Colors.white,
//         side: const BorderSide(color: Colors.grey),
//       ),
//       icon: Icon(
//         Icons.thumb_up,
//         color: widget.post.likesCount > 0 ? Colors.red : Colors.grey,
//       ),
//       label: Text(
//         '${widget.post.likesCount} like${widget.post.likesCount != 1 ? 's' : ''}',
//         style: const TextStyle(color: Colors.black),
//       ),
//     );
//   }

//   Widget _buildCommentButton(context) {
//     return ElevatedButton.icon(
//       onPressed: () async {
//         await fetchCommentsData();
//         showModalBottomSheet(
//           context: context,
//           builder: (context) => CommentsBottomSheet(postId: widget.post.postId),
//         );
//       },
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         side: const BorderSide(color: Colors.grey),
//       ),
//       icon: const Icon(
//         Icons.comment_outlined,
//         color: Colors.black,
//       ),
//       label: Text(
//         '${widget.post.commentsCount} comment${widget.post.commentsCount != 1 ? 's' : ''}',
//         style: const TextStyle(color: Colors.black),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture/screens/Community/Repository/post_model.dart';
import 'package:smart_agriculture/screens/Community/Screens/comments_bottom_sheet.dart';
import '../Repository/post_repository.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  List<Map<String, dynamic>> comments = [];

  Future<void> fetchCommentsData() async {
    try {
      List<Map<String, dynamic>> fetchedComments =
      await PostUtils.getPostComments(widget.post.postId);
      setState(() {
        comments = fetchedComments;
      });
    } catch (e) {
      debugPrint('Error fetching comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Colors.white.withOpacity(0.8),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildUserInfo(),
              const SizedBox(height: 8.0),
              _buildPostContent(),
              if (widget.post.postImage.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                _buildPostImage(),
              ],
              const SizedBox(height: 12.0),
              _buildPostMetrics(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 20.0,
          backgroundImage: NetworkImage(widget.post.profileImageUrl),
          onBackgroundImageError: (_, __) =>
          const AssetImage('images/splash.jpg'),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.userName,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.post.postTime,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        if (widget.post.postUId == FirebaseAuth.instance.currentUser?.uid)
          IconButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.post.postId)
                  .delete();
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
      ],
    );
  }

  Widget _buildPostContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        widget.post.postContent,
        style: TextStyle(
          fontSize: widget.post.postImage.isEmpty ? 18 : 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        widget.post.postImage,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Image(
          image: AssetImage('images/splash.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPostMetrics(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLikeButton(),
        _buildCommentButton(context),
      ],
    );
  }

  Widget _buildLikeButton() {
    return ElevatedButton.icon(
      onPressed: () => PostUtils.toggleLikeOnPost(widget.post.postId),
      style: ElevatedButton.styleFrom(
        foregroundColor: widget.post.likesCount > 0 ? Colors.red : Colors.grey,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.grey),
      ),
      icon: Icon(
        Icons.thumb_up,
        color: widget.post.likesCount > 0 ? Colors.red : Colors.grey,
      ),
      label: Text(
        '${widget.post.likesCount} like${widget.post.likesCount != 1 ? 's' : ''}',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildCommentButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await fetchCommentsData();
        showModalBottomSheet(
          context: context,
          builder: (context) => CommentsBottomSheet(postId: widget.post.postId),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.grey),
      ),
      icon: const Icon(
        Icons.comment_outlined,
        color: Colors.black,
      ),
      label: Text(
        '${widget.post.commentsCount} comment${widget.post.commentsCount != 1 ? 's' : ''}',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
