class RecruiterModel {
  String? id;
  String? company;
  String? role;
  String? email;
  String? number;
  String? password;

  RecruiterModel({
    this.id,
    this.company,
    this.number,
    this.email,
    this.password,
    this.role,
  });

  factory RecruiterModel.fromJson(Map<String, dynamic> json) {
    return RecruiterModel(
      id: json['id'],
      company: json['company'],
      number: json['number'],
      role: json['role'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "company": company ?? "",
        "number": number ?? "",
        "role": role ?? "recruiter",
        "email": email ?? "",
        "password": password ?? "",
      };
}
