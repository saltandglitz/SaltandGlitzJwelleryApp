class GetAddCartViewModel {
  final dynamic status;
  final dynamic message;
  final Cart? cart;
  final dynamic totalQuantity;
   dynamic totalPrice;

  GetAddCartViewModel({
    this.status,
    this.message,
    this.cart,
    this.totalQuantity,
    this.totalPrice,
  });

  GetAddCartViewModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        cart = (json['cart'] as Map<String, dynamic>?) != null ? Cart.fromJson(json['cart'] as Map<String, dynamic>) : null,
        totalQuantity = json['totalQuantity'],
        totalPrice = json['totalPrice'];

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'cart': cart?.toJson(),
    'totalQuantity': totalQuantity,
    'totalPrice': totalPrice,
  };
}

class Cart {
  final dynamic cartId;
  final dynamic userId;
  final List<Quantity>? quantity;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic v;

  Cart({
    this.cartId,
    this.userId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : cartId = json['cart_id'],
        userId = json['userId'],
        quantity = (json['quantity'] as List?)?.map((dynamic e) => Quantity.fromJson(e as Map<String, dynamic>)).toList(),
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        v = json['__v'];

  Map<String, dynamic> toJson() => {
    'cart_id': cartId,
    'userId': userId,
    'quantity': quantity?.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class Quantity {
  final ProductId? productId;
   dynamic quantity;
  final dynamic size;
  final dynamic caratBy;
  final dynamic colorBy;
  final dynamic totalPriceOfProduct;

  Quantity({
    this.productId,
    this.quantity,
    this.size,
    this.caratBy,
    this.colorBy,
    this.totalPriceOfProduct,
  });

  Quantity.fromJson(Map<String, dynamic> json)
      : productId = (json['productId'] as Map<String, dynamic>?) != null ? ProductId.fromJson(json['productId'] as Map<String, dynamic>) : null,
        quantity = json['quantity'],
        size = json['size'],
        caratBy = json['caratBy'],
        colorBy = json['colorBy'],
        totalPriceOfProduct = json['totalPriceOfProduct'];

  Map<String, dynamic> toJson() => {
    'productId': productId?.toJson(),
    'quantity': quantity,
    'size': size,
    'caratBy': caratBy,
    'colorBy': colorBy,
    'totalPriceOfProduct': totalPriceOfProduct,
  };
}

class ProductId {
  final dynamic productId;
  final dynamic id;
  final dynamic title;
  final dynamic gender;
  final dynamic price14KT;
  final dynamic price18KT;
  final dynamic image01;
  final dynamic image02;
  final dynamic image03;
  final dynamic image04;
  final dynamic image05;
  final dynamic video;
  final dynamic category;
  final dynamic subCategory;
  final dynamic material;
  final dynamic gift;
  final dynamic diamondprice;
  final dynamic makingCharge14KT;
  final dynamic makingCharge18KT;
  final dynamic grossWt;
  final dynamic netWeight14KT;
  final dynamic netWeight18KT;
  final dynamic gst14KT;
  final dynamic gst18KT;
  final dynamic total14KT;
  final dynamic total18KT;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic v;
  final dynamic featured;

  ProductId({
    this.productId,
    this.id,
    this.title,
    this.gender,
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
    this.gift,
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.featured,
  });

  ProductId.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        id = json['id'],
        title = json['title'],
        gender = json['gender'],
        price14KT = json['price14KT'],
        price18KT = json['price18KT'],
        image01 = json['image01'],
        image02 = json['image02'],
        image03 = json['image03'],
        image04 = json['image04'],
        image05 = json['image05'],
        video = json['video'],
        category = json['category'],
        subCategory = json['subCategory'],
        material = json['material'],
        gift = json['gift'],
        diamondprice = json['diamondprice'],
        makingCharge14KT = json['makingCharge14KT'],
        makingCharge18KT = json['makingCharge18KT'],
        grossWt = json['grossWt'],
        netWeight14KT = json['netWeight14KT'],
        netWeight18KT = json['netWeight18KT'],
        gst14KT = json['gst14KT'],
        gst18KT = json['gst18KT'],
        total14KT = json['total14KT'],
        total18KT = json['total18KT'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        v = json['__v'],
        featured = json['featured'];

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'id': id,
    'title': title,
    'gender': gender,
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
    'gift': gift,
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
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'featured': featured,
  };
}
