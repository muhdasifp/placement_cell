import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placement_hub/model/recruiter_model.dart';

class JobModel {
  String? id;
  String? title;
  String? description;
  String? salary;
  String? location;
  String? category;
  String? jobType;
  RecruiterModel? recruiter;
  int? applicants;
  List<String>? skillRequired;
  String? postDate;

  JobModel({
    this.id,
    this.title,
    this.description,
    this.salary,
    this.location,
    this.applicants,
    this.category,
    this.jobType,
    this.recruiter,
    this.skillRequired,
    this.postDate,
  });

  factory JobModel.fromJson(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return JobModel(
      id: doc.id,
      title: json["title"],
      description: json["description"],
      category: json['category'],
      location: json["location"],
      jobType: json["job_type"],
      salary: json["salary"],
      recruiter: json['recruiter'] != null
          ? RecruiterModel.fromJson(doc['recruiter'])
          : null,
      skillRequired: json["skill_required"] == null
          ? []
          : List<String>.from(json["skill_required"]!.map((x) => x)),
      postDate: json["post_date"],
      applicants: json["applicants"],
    );
  }

  factory JobModel.fromMap(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json["title"],
      description: json["description"],
      location: json["location"],
      category: json['category'],
      jobType: json["job_type"],
      salary: json["salary"],
      recruiter: json['recruiter'] != null
          ? RecruiterModel.fromJson(json['recruiter'])
          : null,
      skillRequired: json["skill_required"] == null
          ? []
          : List<String>.from(json["skill_required"]!.map((x) => x)),
      postDate: json["post_date"],
      applicants: json["applicants"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "title": title ?? "",
        "description": description ?? "",
        "salary": salary ?? "",
        "location": location ?? "",
        "job_type": jobType ?? "",
        "category": category,
        "recruiter": recruiter?.toJson() ?? {},
        "skill_required": skillRequired == null
            ? []
            : List<dynamic>.from(skillRequired!.map((x) => x)),
        "post_date": postDate ?? DateTime.now(),
        "applicants": applicants ?? 0,
      };
}
