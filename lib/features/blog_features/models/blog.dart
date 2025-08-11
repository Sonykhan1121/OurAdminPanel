class Blog {
  final String id; // Unique identifier (could be UUID)
  final String title; // Post title
  final String slug; // URL-friendly unique string (e.g. flutter-blog-model)
  final String content; // Main HTML or markdown content
  final String summary; // Short excerpt or summary of the post
  final String authorId; // Reference to author (could be a user ID)
  final String authorName; // Denormalized author name for convenience
  final DateTime publishedDate; // When published
  final DateTime? updatedDate; // Optional last updated timestamp
  final bool isPublished; // Draft or published status
  final String? imageUrl; // Cover image URL (nullable)
  final List<String> tags; // Tags or categories
  final int viewsCount; // Number of views
  final int likesCount; // Number of likes or reactions
  final List<String> categories; // Categories or topics
  final List<Comment> comments; // Comments attached (optional)
  final Map<String, dynamic>? metadata; // Any additional metadata

  Blog({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.summary,
    required this.authorId,
    required this.authorName,
    required this.publishedDate,
    this.updatedDate,
    this.isPublished = false,
    this.imageUrl,
    this.tags = const [],
    this.viewsCount = 0,
    this.likesCount = 0,
    this.categories = const [],
    this.comments = const [],
    this.metadata,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      content: json['content'] as String,
      summary: json['summary'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      publishedDate: DateTime.parse(json['publishedDate'] as String),
      updatedDate: json['updatedDate'] != null
          ? DateTime.parse(json['updatedDate'] as String)
          : null,
      isPublished: json['isPublished'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tag) => tag as String)
          .toList() ??
          [],
      viewsCount: json['viewsCount'] as int? ?? 0,
      likesCount: json['likesCount'] as int? ?? 0,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((cat) => cat as String)
          .toList() ??
          [],
      comments: (json['comments'] as List<dynamic>?)
          ?.map((c) => Comment.fromJson(c as Map<String, dynamic>))
          .toList() ??
          [],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'content': content,
      'summary': summary,
      'authorId': authorId,
      'authorName': authorName,
      'publishedDate': publishedDate.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
      'isPublished': isPublished,
      'imageUrl': imageUrl,
      'tags': tags,
      'viewsCount': viewsCount,
      'likesCount': likesCount,
      'categories': categories,
      'comments': comments.map((c) => c.toJson()).toList(),
      'metadata': metadata,
    };
  }
}

class Comment {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final DateTime postedAt;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.postedAt,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      content: json['content'] as String,
      postedAt: DateTime.parse(json['postedAt'] as String),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((r) => Comment.fromJson(r as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'content': content,
      'postedAt': postedAt.toIso8601String(),
      'replies': replies.map((r) => r.toJson()).toList(),
    };
  }
}
