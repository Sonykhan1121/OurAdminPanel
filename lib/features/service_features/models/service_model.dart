

class ServiceModel {
  final int? id;
  final String? title;
  final int count;
  final String? description;


  ServiceModel({
    this.id,
    this.title,
    this.count = 0,
    this.description,
  });

  // Convert to Map for Supabase insert/update
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'count': count,
    'description': description,
  };

  // Factory constructor for Supabase response
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      count: json['count'] as int? ?? 0,
      description: json['description'] as String?,
    );
  }
}