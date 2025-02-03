import 'dart:convert';

CreateUserAccountModel createUserAccountModelFromJson(String str) => CreateUserAccountModel.fromJson(json.decode(str));

String createUserAccountModelToJson(CreateUserAccountModel data) => json.encode(data.toJson());

class CreateUserAccountModel {
  String? message;
  User? user;

  CreateUserAccountModel({
    this.message,
    this.user,
  });

  factory CreateUserAccountModel.fromJson(Map<String, dynamic> json) => CreateUserAccountModel(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
  };
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? password;
  String? gender;
  String? id;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.password,
    this.gender,
    this.id,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    password: json["password"],
    gender: json["gender"],
    id: json["_id"],
    token: json["token"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobileNumber": mobileNumber,
    "password": password,
    "gender": gender,
    "_id": id,
    "token": token,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
