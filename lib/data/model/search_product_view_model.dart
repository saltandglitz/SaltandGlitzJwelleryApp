class SearchProductsViewModel {
  final String? productId;
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
  final String? gender;
  final double? total18KT;
  final String? subCategory;
  final double? discount;
  final String? image02;
  final String? image03;
  final String? updatedAt;
  final String? video;
  final String? image01;
  final String? gift;
  final double? rating;

  SearchProductsViewModel({
    this.productId,
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
    this.gender,
    this.total18KT,
    this.subCategory,
    this.discount,
    this.image02,
    this.image03,
    this.updatedAt,
    this.video,
    this.image01,
    this.gift,
    this.rating,
  });

  SearchProductsViewModel.fromJson(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
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
        gender = json['gender'] as String?,
        total18KT = (json['total18KT'] as num?)?.toDouble(),
        subCategory = json['subCategory'] as String?,
        discount = (json['discount'] as num?)?.toDouble(),
        image02 = json['image02'] as String?,
        image03 = json['image03'] as String?,
        updatedAt = json['updatedAt'] as String?,
        video = json['video'] as String?,
        image01 = json['image01'] as String?,
        gift = json['gift'] as String?,
        rating = (json['rating'] as num?)?.toDouble();

  // Getter to handle both camelCase and lowercase field names
  double? get diamondPrice => diamondprice;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'id': id,
        'title': title,
        'price14KT': price14KT,
        'price18KT': price18KT,
        'category': category,
        'diamondprice': diamondprice,
        'diamondPrice': diamondprice, // Add camelCase variant for compatibility
        'makingCharge14KT': makingCharge14KT,
        'makingCharge18KT': makingCharge18KT,
        'grossWt': grossWt,
        'netWeight14KT': netWeight14KT,
        'netWeight18KT': netWeight18KT,
        'gst14KT': gst14KT,
        'gst18KT': gst18KT,
        'total14KT': total14KT,
        '__v': v,
        'gender': gender,
        'total18KT': total18KT,
        'subCategory': subCategory,
        'discount': discount,
        'image02': image02,
        'image03': image03,
        'updatedAt': updatedAt,
        'video': video,
        'image01': image01,
        'gift': gift,
        'rating': rating
      };
}
