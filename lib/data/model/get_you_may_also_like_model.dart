class YouMayAlsoLikeModel {
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

  YouMayAlsoLikeModel({
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
  });

  YouMayAlsoLikeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        gender = json['gender'],
        gift = json['gift'],
        price14KT = (json['price14KT'] as num?)?.toDouble(),
        price18KT = (json['price18KT'] as num?)?.toDouble(),
        image01 = json['image01'],
        image02 = json['image02'],
        image03 = json['image03'],
        image04 = json['image04'],
        image05 = json['image05'],
        video = json['video'],
        category = json['category'],
        subCategory = json['subCategory'],
        material = json['material'],
        diamondPrice = (json['diamondprice'] as num?)?.toDouble(),
        makingCharge14KT = (json['makingCharge14KT'] as num?)?.toDouble(),
        makingCharge18KT = (json['makingCharge18KT'] as num?)?.toDouble(),
        grossWt = (json['grossWt'] as num?)?.toDouble(),
        netWeight14KT = (json['netWeight14KT'] as num?)?.toDouble(),
        netWeight18KT = (json['netWeight18KT'] as num?)?.toDouble(),
        gst14KT = (json['gst14KT'] as num?)?.toDouble(),
        gst18KT = (json['gst18KT'] as num?)?.toDouble(),
        total14KT = (json['total14KT'] as num?)?.toDouble(),
        total18KT = (json['total18KT'] as num?)?.toDouble(),
        isFavourite = json['isFavourite'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        v = json['__v'],
        applicablePrice = (json['applicablePrice'] as List?)
            ?.map((e) => e.toString())
            .toList(),
        clarity = (json['clarity'] as List?)?.map((e) => e.toString()).toList(),
        diamondQt =
            (json['diamondQt'] as List?)?.map((e) => e.toString()).toList(),
        diamondShape =
            (json['diamondShape'] as List?)?.map((e) => e.toString()).toList(),
        diamondWt =
            (json['diamondWt'] as List?)?.map((e) => e.toString()).toList(),
        price = (json['price'] as List?)?.map((e) => e.toString()).toList(),
        unitWt = (json['unitWt'] as List?)?.map((e) => e.toString()).toList();

  Map<String, dynamic> toJson() => {
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
        'diamondprice': diamondPrice,
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
      };
}
