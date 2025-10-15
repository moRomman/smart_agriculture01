
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture/Shared/consts.dart';
import 'package:smart_agriculture/screens/Community/Repository/community_repo.dart';
import 'package:smart_agriculture/screens/Community/Repository/post_model.dart';
import 'package:smart_agriculture/screens/Community/Screens/add_post_widget.dart';
import 'package:smart_agriculture/screens/Community/Screens/posts_widget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with CommunityRepo {
  void _showAddPostDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddPostDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.mainColor,
              Colors.blueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 50.0, top: 20),
              child: PostsStreamBuilder(),
            ),
            Positioned(
              bottom: kToolbarHeight + 20,
              right: 16,
              child: FloatingActionButton(
                onPressed: _showAddPostDialog,
                backgroundColor: MyColors.mainColor,
                child: const Icon(Icons.post_add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostsStreamBuilder extends StatelessWidget {
  const PostsStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.size == 0) {
          return const Center(
            child: Text('No posts available'),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 5),
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            return _buildPostItem(context, snapshot.data!.docs[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            );
          },
        );
      },
    );
  }

  Widget _buildPostItem(
      BuildContext context, DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return PostWidget(
      post: Post.fromJson(data),
    );
  }
}
