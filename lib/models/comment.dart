class Comment {
  final int id;
  final String content;
  final int postId;
  final String userId;
  final String userName;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.content,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      content: json['content'] as String,
      postId: json['post_id'] as int,
      userId: json['user_id'] as String,
      userName: (json['users'] != null && json['users']['name'] != null)
          ? json['users']['name'] as String
          : 'Unknown',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'post_id': postId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
