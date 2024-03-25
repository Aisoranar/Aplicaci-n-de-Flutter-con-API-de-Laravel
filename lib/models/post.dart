class Post {
  final int id;
  final String content;

  Post({
    required this.id,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
    );
  }
}
