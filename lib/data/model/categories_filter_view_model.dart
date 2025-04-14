class CategoriesFilterViewModel {
  final String? message;
  final List<UpdatedProducts>? updatedProducts;

  CategoriesFilterViewModel({
    this.message,
    this.updatedProducts,
  });

  CategoriesFilterViewModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        updatedProducts = (json['updatedProducts'] as List?)
            ?.map((dynamic e) =>
                UpdatedProducts.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'message': message,
        'updatedProducts': updatedProducts?.map((e) => e.toJson()).toList()
      };
}

class UpdatedProducts {
  final String? productId;
  final List<Media>? media;
  bool? isAlready;
  bool? isCart;
  final String? id;
  final String? title;
  final double? price14KT;
  final double? price18KT;
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
  final String? updatedAt;
  final String? gift;
  final double? rating;
  final String? gender;

  UpdatedProducts({
    this.productId,
    this.media,
    this.isAlready,
    this.isCart,
    this.id,
    this.title,
    this.price14KT,
    this.price18KT,
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
    this.updatedAt,
    this.gift,
    this.rating,
    this.gender,
  });

  UpdatedProducts.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        media = (json['media'] as List?)
            ?.map((dynamic e) => Media.fromJson(e as Map<String, dynamic>))
            .toList(),
        isAlready = json['isAlready'] ?? false,
        isCart = json['isCart'] ?? false,
        id = json['id'] as String?,
        title = json['title'] as String?,
        price14KT = (json['price14KT'] as num?)?.toDouble(),
        price18KT = (json['price18KT'] as num?)?.toDouble(),
        category = json['category'] as String?,
        diamondprice = (json['diamondprice'] as num?)?.toDouble(),
        makingCharge14KT = (json['makingCharge14KT'] as num?)?.toDouble(),
        makingCharge18KT = (json['makingCharge18KT'] as num?)?.toDouble(),
        grossWt = (json['grossWt'] as num?)?.toDouble(),
        netWeight14KT = (json['netWeight14KT'] as num?)?.toDouble(),
        netWeight18KT = (json['netWeight18KT'] as num?)?.toDouble(),
        gst14KT = (json['gst14KT'] as num?)?.toDouble(),
        gst18KT = (json['gst18KT'] as num?)?.toDouble(),
        total14KT = (json['total14KT'] as num?)?.toDouble(),
        v = json['__v'] as int?,
        total18KT = (json['total18KT'] as num?)?.toDouble(),
        discount = (json['discount'] as num?)?.toDouble(),
        subCategory = json['subCategory'] as String?,
        updatedAt = json['updatedAt'] as String?,
        gift = json['gift'] as String?,
        rating = (json['rating'] as num?)?.toDouble(),
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'media': media?.map((e) => e.toJson()).toList(),
        'isAlready': isAlready,
        'isCart': isCart,
        'id': id,
        'title': title,
        'price14KT': price14KT,
        'price18KT': price18KT,
        'category': category,
        'diamondprice': diamondprice,
        'makingCharge14KT': makingCharge14KT,
        'makingCharge18KT': makingCharge18KT,
        'grossWt': grossWt,
        'netWeight14KT': netWeight14KT,
        'netWeight18KT': netWeight18KT,
        'gst14KT': gst14KT,
        'gst18KT': gst18KT,
        'total14KT': total14KT,
        '__v': v,
        'total18KT': total18KT,
        'discount': discount,
        'subCategory': subCategory,
        'updatedAt': updatedAt,
        'gift': gift,
        'rating': rating,
        'gender': gender
      };
}

class Media {
  final String? type;
  final String? productAsset;

  Media({
    this.type,
    this.productAsset,
  });

  Media.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        productAsset = json['productAsset'] as String?;

  Map<String, dynamic> toJson() => {'type': type, 'productAsset': productAsset};
}
