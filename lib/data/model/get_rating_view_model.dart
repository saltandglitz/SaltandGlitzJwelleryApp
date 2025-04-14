class GetRatingViewModel {
  final String? message;
  final List<ApprovedRating>? approvedRating;
  final String? averageRating;

  GetRatingViewModel({
    this.message,
    this.approvedRating,
    this.averageRating,
  });

  GetRatingViewModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        approvedRating = (json['approvedRating'] as List?)?.map((dynamic e) => ApprovedRating.fromJson(e as Map<String,dynamic>)).toList(),
        averageRating = json['averageRating'] as String?;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'approvedRating' : approvedRating?.map((e) => e.toJson()).toList(),
    'averageRating' : averageRating
  };
}

class ApprovedRating {
  final UserId? userId;
  final String? userRating;
  final String? userReview;
  final String? productImage;
  final bool? isApprove;
  final String? id;

  ApprovedRating({
    this.userId,
    this.userRating,
    this.userReview,
    this.productImage,
    this.isApprove,
    this.id,
  });

  ApprovedRating.fromJson(Map<String, dynamic> json)
      : userId = (json['userId'] as Map<String,dynamic>?) != null ? UserId.fromJson(json['userId'] as Map<String,dynamic>) : null,
        userRating = json['userRating'] as String?,
        userReview = json['userReview'] as String?,
        productImage = json['productImage'] as String?,
        isApprove = json['isApprove'] as bool?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId?.toJson(),
    'userRating' : userRating,
    'userReview' : userReview,
    'isApprove' : isApprove,
    '_id' : id
  };
}

class UserId {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final String? password;
  final String? gender;
  final String? token;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.password,
    this.gender,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  UserId.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        email = json['email'] as String?,
        mobileNumber = json['mobileNumber'] as String?,
        password = json['password'] as String?,
        gender = json['gender'] as String?,
        token = json['token'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'firstName' : firstName,
    'lastName' : lastName,
    'email' : email,
    'mobileNumber' : mobileNumber,
    'password' : password,
    'gender' : gender,
    'token' : token,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v
  };
}