import 'dart:convert';

/// Top level helpers
ReferrerStatusResponse referrerStatusFromJson(String str) =>
    ReferrerStatusResponse.fromJson(json.decode(str) as Map<String, dynamic>);

ReferrerStatsResponse referrerStatsFromJson(String str) =>
    ReferrerStatsResponse.fromJson(json.decode(str) as Map<String, dynamic>);

/// Referrer Status Response
class ReferrerStatusResponse {
  String? message;
  bool? isReferrer;
  String? couponCode;
  ReferrerRequest? latestRequest;

  ReferrerStatusResponse({
    this.message,
    this.isReferrer,
    this.couponCode,
    this.latestRequest,
  });

  factory ReferrerStatusResponse.fromJson(Map<String, dynamic> json) =>
      ReferrerStatusResponse(
        message: json['message'] as String?,
        isReferrer: json['isReferrer'] as bool? ?? false,
        couponCode: json['couponCode'] as String?,
        latestRequest: json['latestRequest'] != null
            ? ReferrerRequest.fromJson(
                json['latestRequest'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'isReferrer': isReferrer,
        'couponCode': couponCode,
        'latestRequest': latestRequest?.toJson(),
      };
}

/// Referrer Request Model
class ReferrerRequest {
  String? id;
  String? userId;
  String? status; // "pending" | "approved" | "rejected"
  String? reason;
  String? adminNotes;
  DateTime? reviewedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  ReferrerRequest({
    this.id,
    this.userId,
    this.status,
    this.reason,
    this.adminNotes,
    this.reviewedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ReferrerRequest.fromJson(Map<String, dynamic> json) =>
      ReferrerRequest(
        id: json['_id'] as String?,
        userId: json['userId'] is String
            ? json['userId'] as String?
            : (json['userId'] as Map<String, dynamic>?)?['_id'] as String?,
        status: json['status'] as String?,
        reason: json['reason'] as String?,
        adminNotes: json['adminNotes'] as String?,
        reviewedAt: json['reviewedAt'] != null
            ? DateTime.tryParse(json['reviewedAt'] as String)
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'status': status,
        'reason': reason,
        'adminNotes': adminNotes,
        'reviewedAt': reviewedAt?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

/// Referrer Stats Response
class ReferrerStatsResponse {
  String? message;
  ReferrerStats? stats;

  ReferrerStatsResponse({
    this.message,
    this.stats,
  });

  factory ReferrerStatsResponse.fromJson(Map<String, dynamic> json) =>
      ReferrerStatsResponse(
        message: json['message'] as String?,
        stats: json['stats'] != null
            ? ReferrerStats.fromJson(json['stats'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'stats': stats?.toJson(),
      };
}

/// Referrer Stats
class ReferrerStats {
  String? couponCode;
  int? totalUses;
  int? totalOrders;
  List<ReferrerOrder>? orders;

  ReferrerStats({
    this.couponCode,
    this.totalUses,
    this.totalOrders,
    this.orders,
  });

  factory ReferrerStats.fromJson(Map<String, dynamic> json) => ReferrerStats(
        couponCode: json['couponCode'] as String?,
        totalUses: json['totalUses'] as int? ?? 0,
        totalOrders: json['totalOrders'] as int? ?? 0,
        orders: json['orders'] != null
            ? (json['orders'] as List)
                .map((e) => ReferrerOrder.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'couponCode': couponCode,
        'totalUses': totalUses,
        'totalOrders': totalOrders,
        'orders': orders?.map((e) => e.toJson()).toList(),
      };
}

/// Referrer Order (orders made using the referrer's code)
class ReferrerOrder {
  String? id;
  String? status;
  String? couponCodeUsed;
  double? cartTotal;
  DateTime? orderDate;

  ReferrerOrder({
    this.id,
    this.status,
    this.couponCodeUsed,
    this.cartTotal,
    this.orderDate,
  });

  factory ReferrerOrder.fromJson(Map<String, dynamic> json) => ReferrerOrder(
        id: json['_id'] as String?,
        status: json['status'] as String?,
        couponCodeUsed: json['couponCodeUsed'] as String?,
        cartTotal: (json['cartId']?['cartTotal'] as num?)?.toDouble(),
        orderDate: json['orderDate'] != null
            ? DateTime.tryParse(json['orderDate'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'status': status,
        'couponCodeUsed': couponCodeUsed,
        'cartTotal': cartTotal,
        'orderDate': orderDate?.toIso8601String(),
      };
}

/// Submit Request Response
class ReferrerSubmitResponse {
  String? message;
  ReferrerRequest? request;

  ReferrerSubmitResponse({
    this.message,
    this.request,
  });

  factory ReferrerSubmitResponse.fromJson(Map<String, dynamic> json) =>
      ReferrerSubmitResponse(
        message: json['message'] as String?,
        request: json['request'] != null
            ? ReferrerRequest.fromJson(json['request'] as Map<String, dynamic>)
            : null,
      );
}
