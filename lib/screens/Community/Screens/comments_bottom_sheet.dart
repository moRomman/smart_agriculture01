
import 'package:flutter/material.dart';
import 'package:smart_agriculture/Shared/consts.dart';
import '../Repository/post_repository.dart';

class CommentsBottomSheet extends StatefulWidget {
  final String postId;

  const CommentsBottomSheet({super.key, required this.postId});

  @override
  _CommentsBottomSheetState createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  List<Map<String, dynamic>> comments = [];
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCommentsData();
  }

  Future<void> _fetchCommentsData() async {
    try {
      final fetchedComments = await PostUtils.getPostComments(widget.postId);
      setState(() {
        comments = fetchedComments;
      });
    } catch (e) {
      debugPrint('Error fetching comments: $e');
    }
  }

  Future<void> _addComment(BuildContext context) async {
    if (contentController.text.isEmpty) {
      return;
    }
    try {
      await PostUtils.addCommentToFirestorePost(
          widget.postId, contentController.text);
      _fetchCommentsData();
      contentController.clear();
      FocusScope.of(context).unfocus();
    } catch (e) {
      debugPrint('Error adding comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildCommentInput(),
              const SizedBox(height: 16),
              Expanded(child: _buildCommentsList()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentInput() {
    return TextField(
      controller: contentController,
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () => _addComment(context),
          icon: const Icon(Icons.send, color: MyColors.mainColor),
        ),
        labelText: 'Leave a comment...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: MyColors.mainColor, width: 1),
        ),
      ),
    );
  }

  Widget _buildCommentsList() {
    if (comments.isEmpty) {
      return const Center(child: Text('No comments yet. Be the first!'));
    }
    return ListView.separated(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return _buildCommentTile(comment);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget _buildCommentTile(Map<String, dynamic> comment) {

    return ListTile(
      title: Text(
        comment['userName'] ?? 'Anonymous',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment['timestamp'] ?? '',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(comment['comment'] ?? ''),
        ],
      ),
      leading: const Icon(Icons.person),
    );
  }
}
