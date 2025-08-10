

class IntroModel {
  final int? id;
  final String? name;
  final String? designation;
  final String? description;
  final String? pictureFontTitle;
  final String? pictureBackTitle;
  final String? imagePath;
  final String? pdfPath;
  final Map<String, String>? socialLinks;

  IntroModel({
    this.id,
    this.name,
    this.designation,
    this.description,
    this.pictureFontTitle,
    this.pictureBackTitle,
    this.imagePath,
    this.pdfPath,
    this.socialLinks,
  });

  // Convert to Map for Supabase insert/update
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'designation': designation,
    'description': description,
    'pictureFontTitle': pictureFontTitle,
    'pictureBackTitle': pictureBackTitle,
    'imagePath': imagePath,
    'pdfPath': pdfPath,
    'socialLinks': socialLinks,
  };

  // Factory constructor for Supabase response
  factory IntroModel.fromJson(Map<String, dynamic> json) {
    return IntroModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      description: json['description'] as String?,
      pictureFontTitle: json['pictureFontTitle'] as String?,
      pictureBackTitle: json['pictureBackTitle'] as String?,
      imagePath: json['imagePath'] as String?,
      pdfPath: json['pdfPath'] as String?,
      socialLinks: (json['socialLinks'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, v.toString()),
      ),
    );
  }
}