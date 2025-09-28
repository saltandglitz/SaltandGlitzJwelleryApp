class OrderResponse {
  final String message;
  final String userId;
  final String cartId;
  final int totalOrders;
  final List<Order> orders;

  OrderResponse({
    required this.message,
    required this.userId,
    required this.cartId,
    required this.totalOrders,
    required this.orders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      message: json['message'] ?? '',
      userId: json['userId'] ?? '',
      cartId: json['cartId'] ?? '',
      totalOrders: json['totalOrders'] ?? 0,
      orders: (json['orders'] as List<dynamic>?)
              ?.map((order) => Order.fromJson(order))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'cartId': cartId,
      'totalOrders': totalOrders,
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}

class Order {
  final Address shippingAddress;
  final Address billingAddress;
  final String id;
  final Cart cartId;
  final String status;
  final DateTime orderDate;
  final double totalPrice;

  Order({
    required this.shippingAddress,
    required this.billingAddress,
    required this.id,
    required this.cartId,
    required this.status,
    required this.orderDate,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      shippingAddress: Address.fromJson(json['shippingAddress'] ?? {}),
      billingAddress: Address.fromJson(json['billingAddress'] ?? {}),
      id: json['_id'] ?? '',
      cartId: Cart.fromJson(json['cartId'] ?? {}),
      status: json['status'] ?? '',
      orderDate: DateTime.tryParse(json['orderDate'] ?? '') ?? DateTime.now(),
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shippingAddress': shippingAddress.toJson(),
      'billingAddress': billingAddress.toJson(),
      '_id': id,
      'cartId': cartId.toJson(),
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'totalPrice': totalPrice,
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }

  String get fullAddress {
    return [street, city, state, postalCode, country]
        .where((element) => element.isNotEmpty)
        .join(', ');
  }
}

class Cart {
  final String? appliedCoupon;
  final String id;
  final User userId;
  final List<CartQuantity> quantity;
  final double cartTotal;
  final double total;
  final double saltCashUsed;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cart({
    this.appliedCoupon,
    required this.id,
    required this.userId,
    required this.quantity,
    required this.cartTotal,
    required this.total,
    required this.saltCashUsed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      appliedCoupon: json['appliedCoupon'],
      id: json['_id'] ?? '',
      userId: User.fromJson(json['userId'] ?? {}),
      quantity: (json['quantity'] as List<dynamic>?)
              ?.map((item) => CartQuantity.fromJson(item))
              .toList() ??
          [],
      cartTotal: (json['cartTotal'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      saltCashUsed: (json['saltCashUsed'] ?? 0.0).toDouble(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appliedCoupon': appliedCoupon,
      '_id': id,
      'userId': userId.toJson(),
      'quantity': quantity.map((item) => item.toJson()).toList(),
      'cartTotal': cartTotal,
      'total': total,
      'saltCashUsed': saltCashUsed,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
    };
  }

  String get fullName => '$firstName $lastName'.trim();
}

class CartQuantity {
  final Product productId;
  final int quantity;
  final double totalPrice;
  final int size;
  final String caratBy;
  final String colorBy;
  final String id;

  CartQuantity({
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.size,
    required this.caratBy,
    required this.colorBy,
    required this.id,
  });

  factory CartQuantity.fromJson(Map<String, dynamic> json) {
    return CartQuantity(
      productId: Product.fromJson(json['productId'] ?? {}),
      quantity: json['quantity'] ?? 0,
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
      size: json['size'] ?? 0,
      caratBy: json['caratBy'] ?? '',
      colorBy: json['colorBy'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId.toJson(),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'size': size,
      'caratBy': caratBy,
      'colorBy': colorBy,
      '_id': id,
    };
  }
}

class Product {
  final String id;
  final String title;
  final List<String> price;

  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as List<dynamic>?)
              ?.map((price) => price.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'price': price,
    };
  }

  String get displayPrice {
    if (price.isEmpty) return '₹0';
    return '₹${price.first}';
  }
}
