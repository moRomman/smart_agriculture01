// class Post {
//   String userName;
//   String postTime;
//   String postContent;
//   int likesCount;
//   int commentsCount;
//   String postImage;
//   String profileImageUrl;
//   String postId;
//   String postUId;

//   Post({
//     required this.userName,
//     required this.postTime,
//     required this.postContent,
//     required this.likesCount,
//     required this.commentsCount,
//     required this.postImage,
//     required this.profileImageUrl,
//     required this.postId,
//     required this.postUId,
//   });

//   // Factory method to create a Post instance from a map
//   factory Post.fromJson(Map<String, dynamic> data) {
//     return Post(
//       userName: data['userName'] ?? 'Anonymous',
//       postTime: data['timestamp']!.toString(),
//       postContent: data['content'] ?? '',
//       likesCount: data['likes'] ?? 0,
//       commentsCount: data['commentsCount'] ?? 0,
//       postImage: data['imageUrl'] ?? '',
//       profileImageUrl: data['profileImageUrl'] ?? '',
//       postId: data['postId'].toString(),
//       postUId: data['uId'].toString(),
//     );
//   }

//   // Method to convert a Post instance to a map
//   Map<String, dynamic> toJson() {
//     return {
//       'userName': userName,
//       'timestamp': postTime,
//       'content': postContent,
//       'likes': likesCount,
//       'commentsCount': commentsCount,
//       'imageUrl': postImage,
//       'profileImageUrl': profileImageUrl,
//       'postId': postId,
//       'uId': postUId,
//     };
//   }
// }
class Post {
  final String userName;
  final String postTime;
  final String postContent;
  final int likesCount;
  final int commentsCount;
  final String postImage;
  final String profileImageUrl;
  final String postId;
  final String postUId;

  Post({
    required this.userName,
    required this.postTime,
    required this.postContent,
    required this.likesCount,
    required this.commentsCount,
    required this.postImage,
    required this.profileImageUrl,
    required this.postId,
    required this.postUId,
  });

  // Factory method to create a Post instance from a map
  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
      userName: data['userName'] ?? 'Anonymous',
      postTime: data['timestamp']?.toString() ?? '',
      postContent: data['content'] ?? '',
      likesCount: data['likes'] ?? 0,
      commentsCount: data['commentsCount'] ?? 0,
      postImage: data['imageUrl'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      postId: data['postId']?.toString() ?? '',
      postUId: data['uId']?.toString() ?? '',
    );
  }

  // Method to convert a Post instance to a map
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'timestamp': postTime,
      'content': postContent,
      'likes': likesCount,
      'commentsCount': commentsCount,
      'imageUrl': postImage,
      'profileImageUrl': profileImageUrl,
      'postId': postId,
      'uId': postUId,
    };
  }
}
