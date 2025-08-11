class InspirationalModel {
  final int? id;
  final String title;
  final String? quote;
  final String? author;
  final String? imageUrl;
  final String? videoUrl;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPublished;

  InspirationalModel({
    this.id,
    required this.title,
    this.quote,
    this.author,
    this.imageUrl,
    this.videoUrl,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.isPublished = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'quote': quote,
    'author': author,
    'image_url': imageUrl,
    'video_url': videoUrl,
    'category': category,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'is_published': isPublished,
  };

  factory InspirationalModel.fromJson(Map<String, dynamic> json) {
    return InspirationalModel(
      id: json['id'] as int?,
      title: json['title'] ?? '',
      quote: json['quote'] as String?,
      author: json['author'] as String?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      category: json['category'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      isPublished: json['is_published'] as bool? ?? true,
    );
  }
}
