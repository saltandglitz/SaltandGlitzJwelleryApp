/// Coupon API response models

/// Response from POST /v1/coupon/applyCoupon/:userId
class ApplyCouponResponse {
  bool? status;
  String? message;
  double? originalTotal;
  double? discountAmount;
  double? diamondDiscount;
  double? makingDiscount;
  double? referrerDiscount;
  double? finalTotal;

  ApplyCouponResponse({
    this.status,
    this.message,
    this.originalTotal,
    this.discountAmount,
    this.diamondDiscount,
    this.makingDiscount,
    this.referrerDiscount,
    this.finalTotal,
  });

  factory ApplyCouponResponse.fromJson(Map<String, dynamic> json) =>
      ApplyCouponResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        originalTotal: (json['originalTotal'] as num?)?.toDouble(),
        discountAmount: (json['discountAmount'] as num?)?.toDouble(),
        diamondDiscount: (json['diamondDiscount'] as num?)?.toDouble(),
        makingDiscount: (json['makingDiscount'] as num?)?.toDouble(),
        referrerDiscount: (json['referrerDiscount'] as num?)?.toDouble(),
        finalTotal: (json['finalTotal'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'originalTotal': originalTotal,
        'discountAmount': discountAmount,
        'diamondDiscount': diamondDiscount,
        'makingDiscount': makingDiscount,
        'referrerDiscount': referrerDiscount,
        'finalTotal': finalTotal,
      };
}

/// Response from DELETE /v1/coupon/removeCoupon/:userId
class RemoveCouponResponse {
  bool? status;
  String? message;
  double? cartTotal;

  RemoveCouponResponse({
    this.status,
    this.message,
    this.cartTotal,
  });

  factory RemoveCouponResponse.fromJson(Map<String, dynamic> json) =>
      RemoveCouponResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        cartTotal: (json['cartTotal'] as num?)?.toDouble(),
      );
}
