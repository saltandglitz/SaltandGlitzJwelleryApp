class HomeViewModel {
  String message;
  List<Banner> banner;
  List<NewArrival> newArrivals;
  List<Solitire> solitire;
  List<Category> category;
  List<BottomBanner> bottomBanner;
  List<FilterCategory> filterCategory;
  List<GiftElement> gifts;

  HomeViewModel({
    required this.message,
    required this.banner,
    required this.newArrivals,
    required this.solitire,
    required this.category,
    required this.bottomBanner,
    required this.filterCategory,
    required this.gifts,
  });
}

class Banner {
  String bannerId;
  String bannerImage;
  DateTime createdAt;
  int v;

  Banner({
    this.bannerId = '',
    this.bannerImage = '',
    DateTime? createdAt,
    this.v = 0,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        bannerId: json["banner_id"] ?? '',
        bannerImage: json["bannerImage"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "bannerImage": bannerImage,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class Category {
  String categoryName;
  String images;

  Category({
    required this.categoryName,
    required this.images,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["categoryName"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "images": images,
      };
}

class FilterCategory {
  String filterCategoryId;
  String filterCategoryName;
  String filterCategoryImage;
  DateTime createdAt;
  int v;

  FilterCategory({
    required this.filterCategoryId,
    required this.filterCategoryName,
    required this.filterCategoryImage,
    required this.createdAt,
    required this.v,
  });
  factory FilterCategory.fromJson(Map<String, dynamic> json) => FilterCategory(
        filterCategoryId: json["filterCategoryId"] ?? '',
        filterCategoryName: json["filterCategoryName"] ?? '',
        filterCategoryImage: json["filterCategoryImage"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "filterCategoryId": filterCategoryId,
        "filterCategoryName": filterCategoryName,
        "filterCategoryImage": filterCategoryImage,
        "createdAt": createdAt,
        "__v": v,
      };
}

class GiftElement {
  String giftId;
  String giftName;
  String giftImage;
  DateTime createdAt;
  int v;

  GiftElement({
    required this.giftId,
    required this.giftName,
    required this.giftImage,
    required this.createdAt,
    required this.v,
  });

  factory GiftElement.fromJson(Map<String, dynamic> json) => GiftElement(
        giftId: json["giftId"] ?? '',
        giftName: json["giftName"] ?? '',
        giftImage: json["giftImage"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "giftId": giftId,
        "giftName": giftName,
        "giftImage": giftImage,
        "createdAt": createdAt,
        "__v": v,
      };
}

class NewArrival {
  String productId;
  String id;
  String title;
  int price14Kt;
  int price18Kt;
  String image01;
  String image02;
  String image03;
  String video;
  String category;
  int diamondprice;
  double makingCharge14Kt;
  double makingCharge18Kt;
  double grossWt;
  double netWeight14Kt;
  double netWeight18Kt;
  double gst14Kt;
  double gst18Kt;
  double total14Kt;
  double total18Kt;
  DateTime? createdAt;
  DateTime updatedAt;
  int v;
  String gender;
  String gift;
  double rating;

  NewArrival({
    required this.productId,
    required this.id,
    required this.title,
    required this.price14Kt,
    required this.price18Kt,
    required this.image01,
    required this.image02,
    required this.image03,
    required this.video,
    required this.category,
    required this.diamondprice,
    required this.makingCharge14Kt,
    required this.makingCharge18Kt,
    required this.grossWt,
    required this.netWeight14Kt,
    required this.netWeight18Kt,
    required this.gst14Kt,
    required this.gst18Kt,
    required this.total14Kt,
    required this.total18Kt,
    this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.gender,
    required this.gift,
    required this.rating,
  });

  factory NewArrival.fromJson(Map<String, dynamic> json) => NewArrival(
        productId: json["productId"] ?? '',
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        price14Kt: json["price14KT"] ?? 0,
        price18Kt: json["price18KT"] ?? 0,
        image01: json["image01"] ?? '',
        image02: json["image02"] ?? '',
        image03: json["image03"] ?? '',
        video: json["video"] ?? '',
        category: json["category"] ?? '',
        diamondprice: json["diamondprice"] ?? 0,
        makingCharge14Kt: (json["makingCharge14KT"] as num?)?.toDouble() ?? 0.0,
        makingCharge18Kt: (json["makingCharge18KT"] as num?)?.toDouble() ?? 0.0,
        grossWt: (json["grossWt"] as num?)?.toDouble() ?? 0.0,
        netWeight14Kt: (json["netWeight14KT"] as num?)?.toDouble() ?? 0.0,
        netWeight18Kt: (json["netWeight18KT"] as num?)?.toDouble() ?? 0.0,
        gst14Kt: (json["gst14KT"] as num?)?.toDouble() ?? 0.0,
        gst18Kt: (json["gst18KT"] as num?)?.toDouble() ?? 0.0,
        total14Kt: (json["total14KT"] as num?)?.toDouble() ?? 0.0,
        total18Kt: (json["total18KT"] as num?)?.toDouble() ?? 0.0,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
        gender: json["gender"] ?? '',
        gift: json["gift"] ?? '',
        rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "_id": id,
        "title": title,
        "price14KT": price14Kt,
        "price18KT": price18Kt,
        "image01": image01,
        "image02": image02,
        "image03": image03,
        "video": video,
        "category": category,
        "diamondprice": diamondprice,
        "makingCharge14KT": makingCharge14Kt,
        "makingCharge18KT": makingCharge18Kt,
        "grossWt": grossWt,
        "netWeight14KT": netWeight14Kt,
        "netWeight18KT": netWeight18Kt,
        "gst14KT": gst14Kt,
        "gst18KT": gst18Kt,
        "total14KT": total14Kt,
        "total18KT": total18Kt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "gender": gender,
        "gift": gift,
        "rating": rating,
      };
}

class Solitire {
  String productId;
  String id;
  String title;
  int price14KT;
  int price18KT;
  String category;
  int diamondprice;
  int makingCharge14KT;
  double makingCharge18KT;
  double grossWt;
  double netWeight14KT;
  double netWeight18KT;
  double gst14KT;
  int gst18KT;
  double total14KT;
  int v;
  String gender;
  double total18KT;
  String subCategory;
  int discount;
  String image02;
  String image03;
  String updatedAt;
  String video;
  String image01;
  String gift;
  double rating;

  Solitire({
    required this.productId,
    required this.id,
    required this.title,
    required this.price14KT,
    required this.price18KT,
    required this.category,
    required this.diamondprice,
    required this.makingCharge14KT,
    required this.makingCharge18KT,
    required this.grossWt,
    required this.netWeight14KT,
    required this.netWeight18KT,
    required this.gst14KT,
    required this.gst18KT,
    required this.total14KT,
    required this.v,
    required this.gender,
    required this.total18KT,
    required this.subCategory,
    required this.discount,
    required this.image02,
    required this.image03,
    required this.updatedAt,
    required this.video,
    required this.image01,
    required this.gift,
    required this.rating,
  });

  factory Solitire.fromJson(Map<String, dynamic> json) => Solitire(
        productId: json["productId"] ?? '',
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        price14KT: json["price14KT"] ?? 0,
        price18KT: json["price18KT"] ?? 0,
        category: json["category"] ?? '',
        diamondprice: json["diamondprice"] ?? 0,
        makingCharge14KT: (json["makingCharge14KT"] as num?)?.toInt() ?? 0,
        makingCharge18KT: (json["makingCharge18KT"] as num?)?.toDouble() ?? 0.0,
        grossWt: (json["grossWt"] as num?)?.toDouble() ?? 0.0,
        netWeight14KT: (json["netWeight14KT"] as num?)?.toDouble() ?? 0.0,
        netWeight18KT: (json["netWeight18KT"] as num?)?.toDouble() ?? 0.0,
        gst14KT: (json["gst14KT"] as num?)?.toDouble() ?? 0.0,
        gst18KT: json["gst18KT"] ?? 0,
        total14KT: (json["total14KT"] as num?)?.toDouble() ?? 0.0,
        v: json["__v"] ?? 0,
        gender: json["gender"] ?? '',
        total18KT: (json["total18KT"] as num?)?.toDouble() ?? 0.0,
        subCategory: json["subCategory"] ?? '',
        discount: json["discount"] ?? 0,
        image02: json["image02"] ?? '',
        image03: json["image03"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        video: json["video"] ?? '',
        image01: json["image01"] ?? '',
        gift: json["gift"] ?? '',
        rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "_id": id,
        "title": title,
        "price14KT": price14KT,
        "price18KT": price18KT,
        "category": category,
        "diamondprice": diamondprice,
        "makingCharge14KT": makingCharge14KT,
        "makingCharge18KT": makingCharge18KT,
        "grossWt": grossWt,
        "netWeight14KT": netWeight14KT,
        "netWeight18KT": netWeight18KT,
        "gst14KT": gst14KT,
        "gst18KT": gst18KT,
        "total14KT": total14KT,
        "__v": v,
        "gender": gender,
        "total18KT": total18KT,
        "subCategory": subCategory,
        "discount": discount,
        "image02": image02,
        "image03": image03,
        "updatedAt": updatedAt,
        "video": video,
        "image01": image01,
        "gift": gift,
        "rating": rating,
      };
}

class BottomBanner {
  String bottomBannerId;
  String bannerImage;
  String createdAt;
  int v;

  BottomBanner({
    required this.bottomBannerId,
    required this.bannerImage,
    required this.createdAt,
    required this.v,
  });

  factory BottomBanner.fromJson(Map<String, dynamic> json) => BottomBanner(
        bottomBannerId: json["bottomBannerId"] ?? '',
        bannerImage: json["bannerImage"] ?? '',
        createdAt: json["createdAt"] ?? '',
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "bottomBannerId": bottomBannerId,
        "bannerImage": bannerImage,
        "createdAt": createdAt,
        "__v": v,
      };
}
