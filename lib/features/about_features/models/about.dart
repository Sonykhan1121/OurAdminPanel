import 'award.dart';
import 'education.dart';
import 'experience.dart';

class About {
  final String? fullName;
  final String? title; // e.g. "Flutter Developer", "Software Engineer"
  final String? bio; // Short biography or description
  final String? profileImageUrl;
  final DateTime? birthDate;
  final String? nationality;
  final List<String>? skills; // e.g. ["Flutter", "Dart", "Firebase"]
  final List<String>? interests; // e.g. ["Mobile Development", "Open Source"]
  final String? websiteUrl;
  final String? linkedInUrl;
  final String? githubUrl;
  final String? twitterUrl;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? educationSummary;
  final List<Education>? educationDetails;
  final List<Experience>? workExperiences;
  final List<Award>? awards;
  final Map<String, String>? additionalInfo; // Any other key-value details

  About({
    this.fullName,
    this.title,
    this.bio,
    this.profileImageUrl,
    this.birthDate,
    this.nationality,
    this.skills,
    this.interests,
    this.websiteUrl,
    this.linkedInUrl,
    this.githubUrl,
    this.twitterUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.educationSummary,
    this.educationDetails,
    this.workExperiences,
    this.awards,
    this.additionalInfo,
  });
}






