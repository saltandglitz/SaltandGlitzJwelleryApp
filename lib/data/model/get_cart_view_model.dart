class GetCartApiViewModel {
  final bool? status;
  final String? message;
  final Cart? cart;
  final double? totalQuantity;
  final double? totalPrice;
  final List<Coupons>? coupons;

  GetCartApiViewModel({
    this.status,
    this.message,
    this.cart,
    this.totalQuantity,
    this.totalPrice,
    this.coupons,
  });

  GetCartApiViewModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'] as String?,
        cart = (json['cart'] as Map<String, dynamic>?) != null
            ? Cart.fromJson(json['cart'] as Map<String, dynamic>)
            : null,
        totalQuantity = (json['totalQuantity'] as num?)?.toDouble(),
        totalPrice = json['totalPrice'] as double?,
        coupons = (json['coupons'] as List?)
            ?.map((dynamic e) => Coupons.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'cart': cart?.toJson(),
        'totalQuantity': totalQuantity,
        'totalPrice': totalPrice,
        'coupons': coupons?.map((e) => e.toJson()).toList()
      };
}

class Cart {
  final String? cartId;
  final String? userId;
  final List<Quantity>? quantity;
  final double? cartTotal;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Cart({
    this.cartId,
    this.userId,
    this.quantity,
    this.cartTotal,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : cartId = json['cart_id'] as String?,
        userId = json['userId'] as String?,
        quantity = (json['quantity'] as List?)
            ?.map((dynamic e) => Quantity.fromJson(e as Map<String, dynamic>))
            .toList(),
        cartTotal = json['cartTotal'] as double?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'cart_id': cartId,
        'userId': userId,
        'quantity': quantity?.map((e) => e.toJson()).toList(),
        'cartTotal': cartTotal,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v
      };
}

class Quantity {
  final ProductId? productId;
  final double? quantity;
  final double? size;
  final String? caratBy;
  final String? colorBy;
  final double? totalPriceOfProduct;

  Quantity({
    this.productId,
    this.quantity,
    this.size,
    this.caratBy,
    this.colorBy,
    this.totalPriceOfProduct,
  });

  Quantity.fromJson(Map<String, dynamic> json)
      : productId = (json['productId'] as Map<String, dynamic>?) != null
            ? ProductId.fromJson(json['productId'] as Map<String, dynamic>)
            : null,
        quantity = (json['quantity'] as num?)?.toDouble(),
        size = (json['size'] as num?)?.toDouble(),
        caratBy = json['caratBy'] as String?,
        colorBy = json['colorBy'] as String?,
        totalPriceOfProduct = json['totalPriceOfProduct'] as double?;

  Map<String, dynamic> toJson() => {
        'productId': productId?.toJson(),
        'quantity': quantity,
        'size': size,
        'caratBy': caratBy,
        'colorBy': colorBy,
        'totalPriceOfProduct': totalPriceOfProduct
      };
}

class ProductId {
  final String? productId;
  final String? id;
  final String? title;
  final String? gender;
  final String? gift;
  final double? price14KT;
  final double? price18KT;
  final String? image01;
  final String? image02;
  final String? image03;
  final String? image04;
  final String? image05;
  final String? video;
  final String? category;
  final String? subCategory;
  final String? material;
  final double? diamondprice;
  final double? makingCharge14KT;
  final double? makingCharge18KT;
  final double? grossWt;
  final double? netWeight14KT;
  final double? netWeight18KT;
  final double? gst14KT;
  final double? gst18KT;
  final double? total14KT;
  final double? total18KT;
  final bool? isFavourite;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  ProductId({
    this.productId,
    this.id,
    this.title,
    this.gender,
    this.gift,
    this.price14KT,
    this.price18KT,
    this.image01,
    this.image02,
    this.image03,
    this.image04,
    this.image05,
    this.video,
    this.category,
    this.subCategory,
    this.material,
    this.diamondprice,
    this.makingCharge14KT,
    this.makingCharge18KT,
    this.grossWt,
    this.netWeight14KT,
    this.netWeight18KT,
    this.gst14KT,
    this.gst18KT,
    this.total14KT,
    this.total18KT,
    this.isFavourite,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ProductId.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        id = json['id'] as String?,
        title = json['title'] as String?,
        gender = json['gender'] as String?,
        gift = json['gift'] as String?,
        price14KT = (json['price14KT'] as num?)?.toDouble(),
        price18KT = (json['price18KT'] as num?)?.toDouble(),
        image01 = json['image01'] as String?,
        image02 = json['image02'] as String?,
        image03 = json['image03'] as String?,
        image04 = json['image04'] as String?,
        image05 = json['image05'] as String?,
        video = json['video'] as String?,
        category = json['category'] as String?,
        subCategory = json['subCategory'] as String?,
        material = json['material'] as String?,
        diamondprice = (json['diamondprice'] as num?)?.toDouble(),
        makingCharge14KT = (json['makingCharge14KT'] as num?)?.toDouble(),
        makingCharge18KT = (json['makingCharge18KT'] as num?)?.toDouble(),
        grossWt = (json['grossWt'] as num?)?.toDouble(),
        netWeight14KT = (json['netWeight14KT'] as num?)?.toDouble(),
        netWeight18KT = (json['netWeight18KT'] as num?)?.toDouble(),
        gst14KT = (json['gst14KT'] as num?)?.toDouble(),
        gst18KT = (json['gst18KT'] as num?)?.toDouble(),
        total14KT = (json['total14KT'] as num?)?.toDouble(),
        total18KT = (json['total18KT'] as num?)?.toDouble(),
        isFavourite = json['isFavourite'] as bool?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'id': id,
        'title': title,
        'gender': gender,
        'gift': gift,
        'price14KT': price14KT,
        'price18KT': price18KT,
        'image01': image01,
        'image02': image02,
        'image03': image03,
        'image04': image04,
        'image05': image05,
        'video': video,
        'category': category,
        'subCategory': subCategory,
        'material': material,
        'diamondprice': diamondprice,
        'makingCharge14KT': makingCharge14KT,
        'makingCharge18KT': makingCharge18KT,
        'grossWt': grossWt,
        'netWeight14KT': netWeight14KT,
        'netWeight18KT': netWeight18KT,
        'gst14KT': gst14KT,
        'gst18KT': gst18KT,
        'total14KT': total14KT,
        'total18KT': total18KT,
        'isFavourite': isFavourite,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v
      };
}

class Coupons {
  final String? id;
  final String? couponCode;
  final String? couponContent;
  final String? couponOffer;
  final int? v;

  Coupons({
    this.id,
    this.couponCode,
    this.couponContent,
    this.couponOffer,
    this.v,
  });

  Coupons.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        couponCode = json['couponCode'] as String?,
        couponContent = json['couponContent'] as String?,
        couponOffer = json['couponOffer'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'couponCode': couponCode,
        'couponContent': couponContent,
        'couponOffer': couponOffer,
        '__v': v
      };
}
