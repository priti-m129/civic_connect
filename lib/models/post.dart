// Create this file: lib/models/post.dart

class Post {
  final String id;
  final String userId;
  final String username;
  final String imageUrl;
  final String caption;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final bool isLiked;
  final String? location;
  final String? issueType;

  Post({
    required this.id,
    required this.userId,
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.isLiked,
    this.location,
    this.issueType,
  });

  // Create a copy with modified values
  Post copyWith({
    String? id,
    String? userId,
    String? username,
    String? imageUrl,
    String? caption,
    DateTime? timestamp,
    int? likes,
    int? comments,
    bool? isLiked,
    String? location,
    String? issueType,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      location: location ?? this.location,
      issueType: issueType ?? this.issueType,
    );
  }
}