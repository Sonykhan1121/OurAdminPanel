import 'package:flutter/foundation.dart';

@immutable
class FooterModel {
  /// The URL or asset path for the company logo.
  final String logoUrl;

  /// The main tagline or slogan, e.g., "Get Ready To Create Great".
  final String tagline;

  /// The contact phone number.
  final String phoneNumber;

  /// The contact email address.
  final String email;

  /// The full physical address.
  final String address;

  /// The copyright text, e.g., "© 2025 LocationIQ".
  final String copyrightText;

  /// The URL for the privacy policy page.
  final String privacyPolicyUrl;

  /// The URL for the terms and conditions page.
  final String termsAndConditionsUrl;

  // --- Optional Fields for Future Use ---

  /// A brief description or bio for the company.
  final String? companyDescription;

  /// A list of quick links, each with a title and a navigation route/URL.
  final List<Map<String, String>>? quickLinks;

  /// A list of social media links, each with a platform name and a profile URL.
  final List<Map<String, String>>? socialLinks;

  const FooterModel({
    required this.logoUrl,
    required this.tagline,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.copyrightText,
    required this.privacyPolicyUrl,
    required this.termsAndConditionsUrl,
    this.companyDescription,
    this.quickLinks,
    this.socialLinks,
  });

  /// Creates a FooterModel instance from a JSON map.
  factory FooterModel.fromJson(Map<String, dynamic> json) {
    return FooterModel(
      logoUrl: json['logoUrl'] as String,
      tagline: json['tagline'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      copyrightText: json['copyrightText'] as String,
      privacyPolicyUrl: json['privacyPolicyUrl'] as String,
      termsAndConditionsUrl: json['termsAndConditionsUrl'] as String,
      companyDescription: json['companyDescription'] as String?,
      quickLinks: (json['quickLinks'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      socialLinks: (json['socialLinks'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );
  }

  /// Converts this FooterModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'logoUrl': logoUrl,
      'tagline': tagline,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'copyrightText': copyrightText,
      'privacyPolicyUrl': privacyPolicyUrl,
      'termsAndConditionsUrl': termsAndConditionsUrl,
      'companyDescription': companyDescription,
      'quickLinks': quickLinks,
      'socialLinks': socialLinks,
    };
  }
}