class ExperienceModel {
  final int? id; // DB primary key
  final int yearsOfExperience;
  final int projectsCompleted;
  final int awardsAndRecognitions;
  final int technologiesMastered;
  final int teamMembers;
  final int countriesServed;


  ExperienceModel({
    this.id,
    this.yearsOfExperience = 0,
    this.projectsCompleted = 0,
    this.awardsAndRecognitions = 0,
    this.technologiesMastered = 0,
    this.teamMembers = 0,
    this.countriesServed = 0,

  });

  // Convert to Map for Supabase insert/update
  Map<String, dynamic> toJson() => {
    'id': id,
    'years_of_experience': yearsOfExperience,
    'projects_completed': projectsCompleted,
    'awards_and_recognitions': awardsAndRecognitions,
    'technologies_mastered': technologiesMastered,
    'team_members': teamMembers,
    'countries_served': countriesServed,

  };

  // Factory constructor for Supabase/JSON
  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as int?,
      yearsOfExperience: json['years_of_experience'] as int? ?? 0,
      projectsCompleted: json['projects_completed'] as int? ?? 0,
      awardsAndRecognitions: json['awards_and_recognitions'] as int? ?? 0,
      technologiesMastered: json['technologies_mastered'] as int? ?? 0,
      teamMembers: json['team_members'] as int? ?? 0,
      countriesServed: json['countries_served'] as int? ?? 0,

    );
  }
}
