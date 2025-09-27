import 'dart:convert';

/// Top level helpers
UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str) as Map<String, dynamic>);

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

/// Root model
class UserProfileModel {
  String? message;
  UserProfile? user;

  UserProfileModel({
    this.message,
    this.user,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        message: json['message'] as String?,
        user: json['user'] != null
            ? UserProfile.fromJson(json['user'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
      };
}

/// User profile
class UserProfile {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? gender;
  String? token;
  DateTime? dateOfBirth;
  DateTime? aniversaryDate;
  String? occupation;
  String? pincode;
  ShippingAddress? shippingAddress;
  String? memberShipTier;
  bool? profileCompleted;
  int? userSaltCash;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.gender,
    this.token,
    this.dateOfBirth,
    this.aniversaryDate,
    this.occupation,
    this.pincode,
    this.shippingAddress,
    this.memberShipTier,
    this.profileCompleted,
    this.userSaltCash,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['_id'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        mobileNumber: json['mobileNumber'] as String?,
        gender: json['gender'] as String?,
        token: json['token'] as String?,
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.tryParse(json['dateOfBirth'] as String)
            : null,
        aniversaryDate: json['aniversaryDate'] != null
            ? DateTime.tryParse(json['aniversaryDate'] as String)
            : null,
        occupation: json['occupation'] as String?,
        pincode: json['pincode'] as String?,
        shippingAddress: json['shippingAddress'] != null
            ? ShippingAddress.fromJson(
                json['shippingAddress'] as Map<String, dynamic>)
            : null,
        memberShipTier: json['memberShipTier'] as String?,
        profileCompleted: json['profileCompleted'] as bool? ?? false,
        userSaltCash: json['userSaltCash'] as int? ?? 0,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'] as String)
            : null,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'mobileNumber': mobileNumber,
        'gender': gender,
        'token': token,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'aniversaryDate': aniversaryDate?.toIso8601String(),
        'occupation': occupation,
        'pincode': pincode,
        'shippingAddress': shippingAddress?.toJson(),
        'memberShipTier': memberShipTier,
        'profileCompleted': profileCompleted,
        'userSaltCash': userSaltCash,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  /// Helper to check if essential profile fields are complete
  bool isProfileComplete() {
    return firstName != null &&
        firstName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty &&
        mobileNumber != null &&
        mobileNumber!.isNotEmpty &&
        gender != null &&
        gender!.isNotEmpty &&
        pincode != null &&
        pincode!.isNotEmpty &&
        dateOfBirth != null;
  }

  /// Calculate profile completion percentage (0.0 – 1.0)
  double getProfileCompletionPercentage() {
    int completedFields = 0;
    int totalFields = 10;

    if (firstName?.isNotEmpty ?? false) completedFields++;
    if (lastName?.isNotEmpty ?? false) completedFields++;
    if (email?.isNotEmpty ?? false) completedFields++;
    if (mobileNumber?.isNotEmpty ?? false) completedFields++;
    if (gender?.isNotEmpty ?? false) completedFields++;
    if (pincode?.isNotEmpty ?? false) completedFields++;
    if (dateOfBirth != null) completedFields++;
    if (aniversaryDate != null) completedFields++;
    if (occupation?.isNotEmpty ?? false) completedFields++;
    if (shippingAddress?.isComplete() ?? false) completedFields++;

    return completedFields / totalFields;
  }
}

/// Shipping address
class ShippingAddress {
  String? streetAndHouseNumber;
  String? additionalInfo;
  String? city;
  String? state;

  ShippingAddress({
    this.streetAndHouseNumber,
    this.additionalInfo,
    this.city,
    this.state,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        streetAndHouseNumber: json['streetAndHouseNumber'] as String?,
        additionalInfo: json['additionalInfo'] ?? " ",
        city: json['city'] as String?,
        state: json['state'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'streetAndHouseNumber': streetAndHouseNumber,
        'additionalInfo': additionalInfo,
        'city': city,
        'state': state,
      };

  bool isComplete() {
    return (streetAndHouseNumber?.isNotEmpty ?? false) &&
        (city?.isNotEmpty ?? false) &&
        (state?.isNotEmpty ?? false);
  }
}
