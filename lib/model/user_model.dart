import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? role;
  String? stream;
  List<String>? skills;
  String? address;

  UserModel({
    this.uid,
    this.name,
    this.role = 'student',
    this.email,
    this.password,
    this.phone,
    this.stream,
    this.skills,
    this.address,
  });

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data()!;
    return UserModel(
      uid: doc.id,
      name: json["name"],
      email: json["email"],
      role: json["role"],
      password: json["password"],
      phone: json["phone"],
      stream: json["stream"],
      skills: json["skills"] == null
          ? []
          : List<String>.from(json["skills"]!.map((x) => x)),
      address: json["address"],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      stream: json["stream"],
      skills: json["skills"] == null
          ? []
          : List<String>.from(json["skills"]!.map((x) => x)),
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid ?? "",
        "name": name ?? "",
        "email": email ?? "",
        "password": password ?? "",
        "phone": phone ?? "",
        "stream": stream ?? "",
        "role": role ?? "student",
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "address": address ?? "",
      };
}
