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
  final double? avgRating;
  final double? totalRatings;
  bool? isAlready;
  final bool? isCart;
  final List<Media>? media;
  final String? id;
  final String? title;
  final String? gender;
  final String? gift;
  final double? price14KT;
  final double? price18KT;
  final String? category;
  final List<String>? subCategory;
  final String? material;
  final double? diamondPrice;
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
  final List<String>? applicablePrice;
  final List<String>? clarity;
  final List<String>? diamondQt;
  final List<String>? diamondShape;
  final List<String>? diamondWt;
  final List<String>? price;
  final List<String>? unitWt;
  final double? grossWt14KT;
  final double? grossWt18KT;
  final String? description;
  final List<ProductRatings>? productRatings;

  UpdatedProducts({
    this.productId,
    this.avgRating,
    this.totalRatings,
    this.isAlready,
    this.isCart,
    this.media,
    this.id,
    this.title,
    this.gender,
    this.gift,
    this.price14KT,
    this.price18KT,
    this.category,
    this.subCategory,
    this.material,
    this.diamondPrice,
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
    this.applicablePrice,
    this.clarity,
    this.diamondQt,
    this.diamondShape,
    this.diamondWt,
    this.price,
    this.unitWt,
    this.grossWt14KT,
    this.grossWt18KT,
    this.description,
    this.productRatings,
  });

  UpdatedProducts.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        avgRating = (json['avgRating'] as num?)?.toDouble(),
        totalRatings = (json['totalRatings'] as num?)?.toDouble(),
        isAlready = json['isAlready'] ?? false,
        isCart = json['isCart'] as bool?,
        media = (json['media'] as List?)
            ?.map((dynamic e) => Media.fromJson(e as Map<String, dynamic>))
            .toList(),
        id = json['id'] as String?,
        title = json['title'] as String?,
        gender = json['gender'] as String?,
        gift = json['gift'] as String?,
        price14KT = (json['price14KT'] as num?)?.toDouble(),
        price18KT = (json['price18KT'] as num?)?.toDouble(),
        category = json['category'] as String?,
        subCategory = json['subCategory'] is List
            ? (json['subCategory'] as List).map((e) => e.toString()).toList()
            : json['subCategory'] is String
                ? (json['subCategory'] as String)
                    .split(',')
                    .map((e) => e.trim())
                    .toList()
                : [],
        material = json['material'] as String?,
        diamondPrice = (json['diamondPrice'] as num?)?.toDouble(),
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
        v = json['__v'] as int?,
        applicablePrice = (json['applicablePrice'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        clarity = (json['clarity'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        diamondQt = (json['diamondQt'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        diamondShape = (json['diamondShape'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        diamondWt = (json['diamondWt'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        price =
            (json['price'] as List?)?.map((dynamic e) => e as String).toList(),
        unitWt =
            (json['unitWt'] as List?)?.map((dynamic e) => e as String).toList(),
        grossWt14KT = (json['grossWt14KT'] as num?)?.toDouble(),
        grossWt18KT = (json['grossWt18KT'] as num?)?.toDouble(),
        description = json['description'] as String?,
        productRatings = (json['productRatings'] as List?)
            ?.map((dynamic e) =>
                ProductRatings.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'avgRating': avgRating,
        'totalRatings': totalRatings,
        'isAlready': isAlready,
        'isCart': isCart,
        'media': media?.map((e) => e.toJson()).toList(),
        'id': id,
        'title': title,
        'gender': gender,
        'gift': gift,
        'price14KT': price14KT,
        'price18KT': price18KT,
        'category': category,
        'subCategory': subCategory,
        'material': material,
        'diamondPrice': diamondPrice,
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
        '__v': v,
        'applicablePrice': applicablePrice,
        'clarity': clarity,
        'diamondQt': diamondQt,
        'diamondShape': diamondShape,
        'diamondWt': diamondWt,
        'price': price,
        'unitWt': unitWt,
        'grossWt14KT': grossWt14KT,
        'grossWt18KT': grossWt18KT,
        'description': description,
        'productRatings': productRatings?.map((e) => e.toJson()).toList()
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

class ProductRatings {
  final String? id;
  final String? productId;
  final List<dynamic>? ratings;
  final int? v;
  final double? rating;

  ProductRatings({
    this.id,
    this.productId,
    this.ratings,
    this.v,
    this.rating,
  });

  ProductRatings.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        productId = json['productId'] as String?,
        ratings = json['ratings'] as List?,
        v = json['__v'] as int?,
        rating = (json['rating'] as num?)?.toDouble();

  Map<String, dynamic> toJson() => {
        '_id': id,
        'productId': productId,
        'ratings': ratings,
        '__v': v,
        'rating': rating
      };
}
