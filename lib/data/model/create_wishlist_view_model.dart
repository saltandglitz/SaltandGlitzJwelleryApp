class CreateWishlistViewModel {
  final bool? status;
  final String? message;
  final Wishlist? wishlist;

  CreateWishlistViewModel({
    this.status,
    this.message,
    this.wishlist,
  });

  CreateWishlistViewModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'] as String?,
        wishlist = (json['wishlist'] as Map<String,dynamic>?) != null ? Wishlist.fromJson(json['wishlist'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'wishlist' : wishlist?.toJson()
  };
}

class Wishlist {
  final String? userId;
  final List<Products>? products;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Wishlist({
    this.userId,
    this.products,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Wishlist.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as String?,
        products = (json['products'] as List?)?.map((dynamic e) => Products.fromJson(e as Map<String,dynamic>)).toList(),
        id = json['_id'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'products' : products?.map((e) => e.toJson()).toList(),
    '_id' : id,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v
  };
}

class Products {
  final String? productId;
  final bool? isAlready;
  final String? userId;

  Products({
    this.productId,
    this.isAlready,
    this.userId,
  });

  Products.fromJson(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
        isAlready = json['isAlready'] as bool?,
        userId = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
    'productId' : productId,
    'isAlready' : isAlready,
    '_id' : userId
  };
}