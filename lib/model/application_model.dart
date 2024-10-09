import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/model/user_model.dart';

class ApplicationModel {
  String? id;
  UserModel? seeker;
  JobModel? job;
  String? date;
  String? status;
  String? interview;
  String? interviewPlace;
  String? interviewTime;

  ApplicationModel({
    this.id,
    this.seeker,
    this.job,
    this.date,
    this.status,
    this.interview,
    this.interviewPlace,
    this.interviewTime,
  });

  factory ApplicationModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return ApplicationModel(
      id: doc.id,
      seeker: json['seeker'] != null ? UserModel.fromMap(json['seeker']) : null,
      job: json['job'] != null ? JobModel.fromMap(json['job']) : null,
      date: json['date'],
      status: json['status'],
      interview: json['interview'],
      interviewPlace: json['interview_location'],
      interviewTime: json['interview_time'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "seeker": seeker?.toJson() ?? {},
        "job": job?.toJson() ?? {},
        "date": date ?? "",
        "status": status ?? "applied",
        "interview": interview ?? "",
        "interview_location": interviewPlace ?? "",
        "interview_time": interviewTime ?? "",
      };
}
