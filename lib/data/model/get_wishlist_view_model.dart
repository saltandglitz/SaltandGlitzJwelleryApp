class GetWishlistViewModel {
  final bool? status;
  final String? message;
  final Wishlist? wishlist;

  GetWishlistViewModel({
    this.status,
    this.message,
    this.wishlist,
  });

  GetWishlistViewModel.fromJson(Map<String, dynamic> json)
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
  final String? wishlistId;
  final String? userId;
  final List<WishlistProducts>? products;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Wishlist({
    this.wishlistId,
    this.userId,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Wishlist.fromJson(Map<String, dynamic> json)
      : wishlistId = json['wishlist_id'] as String?,
        userId = json['userId'] as String?,
        products = (json['products'] as List?)?.map((dynamic e) => WishlistProducts.fromJson(e as Map<String,dynamic>)).toList(),
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    'wishlist_id' : wishlistId,
    'userId' : userId,
    'products' : products?.map((e) => e.toJson()).toList(),
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v
  };
}

class WishlistProducts {
  final bool? isAlready;
  final ProductId? productId;

  WishlistProducts({
    this.isAlready,
    this.productId,
  });

  WishlistProducts.fromJson(Map<String, dynamic> json)
      : isAlready = json['isAlready'] as bool?,
        productId = (json['productId'] as Map<String,dynamic>?) != null ? ProductId.fromJson(json['productId'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'isAlready' : isAlready,
    'productId' : productId?.toJson()
  };
}

class ProductId {
  final String? productId;
  final String? id;
  final String? title;
  final double? price14KT;
  final double? price18KT;
  final String? image01;
  final String? category;
  final double? diamondprice;
  final double? makingCharge14KT;
  final double? makingCharge18KT;
  final double? grossWt;
  final double? netWeight14KT;
  final double? netWeight18KT;
  final double? gst14KT;
  final double? gst18KT;
  final double? total14KT;
  final int? v;
  final double? total18KT;
  final double? discount;
  final String? subCategory;
  final String? image02;
  final String? image03;
  final String? updatedAt;
  final String? video;
  final String? gift;
  final double? rating;
  final String? gender;

  ProductId({
    this.productId,
    this.id,
    this.title,
    this.price14KT,
    this.price18KT,
    this.image01,
    this.category,
    this.diamondprice,
    this.makingCharge14KT,
    this.makingCharge18KT,
    this.grossWt,
    this.netWeight14KT,
    this.netWeight18KT,
    this.gst14KT,
    this.gst18KT,
    this.total14KT,
    this.v,
    this.total18KT,
    this.discount,
    this.subCategory,
    this.image02,
    this.image03,
    this.updatedAt,
    this.video,
    this.gift,
    this.rating,
    this.gender,
  });

  ProductId.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        id = json['id'] as String?,
        title = json['title'] as String?,
        price14KT = (json['price14KT'] as num?)?.toDouble(),
        price18KT = (json['price18KT'] as num?)?.toDouble(),
        image01 = json['image01'] as String?,
        category = json['category'] as String?,
        diamondprice = (json['diamondprice'] as num?)?.toDouble(),
        makingCharge14KT = (json['makingCharge14KT'] as num?)?.toDouble(),
        makingCharge18KT = (json['makingCharge18KT'] as num?)?.toDouble(),
        grossWt = json['grossWt'] as double?,
        netWeight14KT = (json['netWeight14KT'] as num?)?.toDouble(),
        netWeight18KT = (json['netWeight18KT'] as num?)?.toDouble(),
        gst14KT = (json['gst14KT'] as num?)?.toDouble(),
        gst18KT = (json['gst18KT'] as num?)?.toDouble(),
        total14KT = (json['total14KT'] as num?)?.toDouble(),
        v = json['__v'] as int?,
        total18KT = (json['total18KT'] as num?)?.toDouble(),
        discount = (json['discount'] as num?)?.toDouble(),
        subCategory = json['subCategory'] as String?,
        image02 = json['image02'] as String?,
        image03 = json['image03'] as String?,
        updatedAt = json['updatedAt'] as String?,
        video = json['video'] as String?,
        gift = json['gift'] as String?,
        rating = (json['rating'] as num?)?.toDouble(),
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {
    'product_id' : productId,
    'id' : id,
    'title' : title,
    'price14KT' : price14KT,
    'price18KT' : price18KT,
    'image01' : image01,
    'category' : category,
    'diamondprice' : diamondprice,
    'makingCharge14KT' : makingCharge14KT,
    'makingCharge18KT' : makingCharge18KT,
    'grossWt' : grossWt,
    'netWeight14KT' : netWeight14KT,
    'netWeight18KT' : netWeight18KT,
    'gst14KT' : gst14KT,
    'gst18KT' : gst18KT,
    'total14KT' : total14KT,
    '__v' : v,
    'total18KT' : total18KT,
    'discount' : discount,
    'subCategory' : subCategory,
    'image02' : image02,
    'image03' : image03,
    'updatedAt' : updatedAt,
    'video' : video,
    'gift' : gift,
    'rating' : rating,
    'gender' : gender
  };
}