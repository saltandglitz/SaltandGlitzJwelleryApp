import 'dart:convert';

GetCategoriesViewModel getCategoriesViewModelFromJson(String str) =>
    GetCategoriesViewModel.fromJson(json.decode(str));

String getCategoriesViewModelToJson(GetCategoriesViewModel data) =>
    json.encode(data.toJson());

class GetCategoriesViewModel {
  String message;
  List<Category> categories;
  List<String> genders;
  List<Banner> banners;
  List<MergedProduct> mergedProducts;

  GetCategoriesViewModel({
    this.message = '',
    this.categories = const [],
    this.genders = const [],
    this.banners = const [],
    this.mergedProducts = const [],
  });

  factory GetCategoriesViewModel.fromJson(Map<String, dynamic> json) =>
      GetCategoriesViewModel(
        message: json["message"] ?? '',
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        genders: json["genders"] == null
            ? []
            : List<String>.from(json["genders"].map((x) => x ?? '')),
        banners: json["banners"] == null
            ? []
            : List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        mergedProducts: json["mergedProducts"] == null
            ? []
            : List<MergedProduct>.from(
            json["mergedProducts"].map((x) => MergedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "categories": categories.map((x) => x.toJson()).toList(),
    "genders": genders.map((x) => x ?? '').toList(),
    "banners": banners.map((x) => x.toJson()).toList(),
    "mergedProducts": mergedProducts.map((x) => x.toJson()).toList(),
  };
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
  String category;
  String categoryImage;
  List<Abc> xyz;
  List<Abc> mbk;
  List<Abc> abc;
  List<Abc> undefined;

  Category({
    this.category = '',
    this.categoryImage = '',
    this.xyz = const [],
    this.mbk = const [],
    this.abc = const [],
    this.undefined = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    category: json["category"] ?? '',
    categoryImage: json["categoryImage"] ?? '',
    xyz: json["xyz"] == null
        ? []
        : List<Abc>.from(json["xyz"].map((x) => Abc.fromJson(x))),
    mbk: json["mbk"] == null
        ? []
        : List<Abc>.from(json["mbk"].map((x) => Abc.fromJson(x))),
    abc: json["abc"] == null
        ? []
        : List<Abc>.from(json["abc"].map((x) => Abc.fromJson(x))),
    undefined: json["undefined"] == null
        ? []
        : List<Abc>.from(json["undefined"].map((x) => Abc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "categoryImage": categoryImage,
    "xyz": xyz.map((x) => x.toJson()).toList(),
    "mbk": mbk.map((x) => x.toJson()).toList(),
    "abc": abc.map((x) => x.toJson()).toList(),
    "undefined": undefined.map((x) => x.toJson()).toList(),
  };
}

class Abc {
  String id;
  String abcId;
  String title;
  int price14Kt;
  int price18Kt;
  String image01;
  String category;
  int diamondprice;
  int makingCharge14Kt;
  double makingCharge18Kt;
  double grossWt;
  double netWeight14Kt;
  double netWeight18Kt;
  int gst14Kt;
  int gst18Kt;
  int total14Kt;
  int v;
  String gender;
  double total18Kt;
  int discount;
  String subCategory;
  String image02;
  String image03;
  DateTime updatedAt;
  String video;
  DateTime createdAt;

  Abc({
    this.id = '',
    this.abcId = '',
    this.title = '',
    this.price14Kt = 0,
    this.price18Kt = 0,
    this.image01 = '',
    this.category = '',
    this.diamondprice = 0,
    this.makingCharge14Kt = 0,
    this.makingCharge18Kt = 0.0,
    this.grossWt = 0.0,
    this.netWeight14Kt = 0.0,
    this.netWeight18Kt = 0.0,
    this.gst14Kt = 0,
    this.gst18Kt = 0,
    this.total14Kt = 0,
    this.v = 0,
    this.gender = '',
    this.total18Kt = 0.0,
    this.discount = 0,
    this.subCategory = '',
    this.image02 = '',
    this.image03 = '',
    required DateTime? updatedAt,
    this.video = '',
    required DateTime? createdAt,
  }) : updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  factory Abc.fromJson(Map<String, dynamic> json) => Abc(
    id: json["_id"] ?? '',
    abcId: json["id"] ?? '',
    title: json["title"] ?? '',
    price14Kt: json["price14KT"] ?? 0,
    price18Kt: json["price18KT"] ?? 0,
    image01: json["image01"] ?? '',
    category: json["category"] ?? '',
    diamondprice: json["diamondprice"] ?? 0,
    makingCharge14Kt: json["makingCharge14KT"] ?? 0,
    makingCharge18Kt: (json["makingCharge18KT"] ?? 0.0).toDouble(),
    grossWt: (json["grossWt"] ?? 0.0).toDouble(),
    netWeight14Kt: (json["netWeight14KT"] ?? 0.0).toDouble(),
    netWeight18Kt: (json["netWeight18KT"] ?? 0.0).toDouble(),
    gst14Kt: json["gst14KT"] ?? 0,
    gst18Kt: json["gst18KT"] ?? 0,
    total14Kt: json["total14KT"] ?? 0,
    v: json["__v"] ?? 0,
    gender: json["gender"] ?? '',
    total18Kt: (json["total18KT"] ?? 0.0).toDouble(),
    discount: json["discount"] ?? 0,
    subCategory: json["subCategory"] ?? '',
    image02: json["image02"] ?? '',
    image03: json["image03"] ?? '',
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
    video: json["video"] ?? '',
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id": abcId,
    "title": title,
    "price14KT": price14Kt,
    "price18KT": price18Kt,
    "image01": image01,
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
    "__v": v,
    "gender": gender,
    "total18KT": total18Kt,
    "discount": discount,
    "subCategory": subCategory,
    "image02": image02,
    "image03": image03,
    "updatedAt": updatedAt.toIso8601String(),
    "video": video,
    "createdAt": createdAt.toIso8601String(),
  };
}

class MergedProduct {
  String category;
  String categoryImage;
  Map<String, List<SubCategory>> subCategories;

  MergedProduct({
    this.category = '',
    this.categoryImage = '',
    this.subCategories = const {},
  });

  factory MergedProduct.fromJson(Map<String, dynamic> json) => MergedProduct(
    category: json["category"] ?? '',
    categoryImage: json["categoryImage"] ?? '',
    subCategories: Map.from(json["subCategories"] ?? {}).map(
          (k, v) => MapEntry<String, List<SubCategory>>(
          k,
          List<SubCategory>.from(v.map((x) => SubCategory.fromJson(x)))),
    ),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "categoryImage": categoryImage,
    "subCategories": Map.from(subCategories).map(
          (k, v) => MapEntry<String, dynamic>(
        k,
        List<dynamic>.from(v.map((x) => x.toJson())),
      ),
    ),
  };
}

class SubCategory {
  String productId;
  String title;
  int price14Kt;
  String image01;
  String category;
  String subCategory;

  SubCategory({
    this.productId = '',
    this.title = '',
    this.price14Kt = 0,
    this.image01 = '',
    this.category = '',
    this.subCategory = '',
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    productId: json["productId"] ?? '',
    title: json["title"] ?? '',
    price14Kt: json["price14KT"] ?? 0,
    image01: json["image01"] ?? '',
    category: json["category"] ?? '',
    subCategory: json["subCategory"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "title": title,
    "price14KT": price14Kt,
    "image01": image01,
    "category": category,
    "subCategory": subCategory,
  };
}
