class GetCategoriesViewModel {
  final String? message;
  final List<Categories>? categories;
  final List<String>? genders;
  final List<Banners>? banners;
  final List<MergedProducts>? mergedProducts;

  GetCategoriesViewModel({
    this.message,
    this.categories,
    this.genders,
    this.banners,
    this.mergedProducts,
  });

  GetCategoriesViewModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        categories = (json['categories'] as List?)
            ?.map((dynamic e) => Categories.fromJson(e as Map<String, dynamic>))
            .toList(),
        genders = (json['genders'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        banners = (json['banners'] as List?)
            ?.map((dynamic e) => Banners.fromJson(e as Map<String, dynamic>))
            .toList(),
        mergedProducts = (json['mergedProducts'] as List?)
            ?.map((dynamic e) =>
                MergedProducts.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'message': message,
        'categories': categories?.map((e) => e.toJson()).toList(),
        'genders': genders,
        'banners': banners?.map((e) => e.toJson()).toList(),
        'mergedProducts': mergedProducts?.map((e) => e.toJson()).toList()
      };
}

class Categories {
  final String? category;
  final String? categoryImage;
  final List<SubCategory>? subCategory;

  Categories({
    this.category,
    this.categoryImage,
    this.subCategory,
  });

  Categories.fromJson(Map<String, dynamic> json)
      : category = json['category'] as String?,
        categoryImage = json['categoryImage'] as String?,
        subCategory = (json['subCategory'] as List?)
            ?.map(
                (dynamic e) => SubCategory.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'category': category,
        'categoryImage': categoryImage,
        'subCategory': subCategory?.map((e) => e.toJson()).toList()
      };
}

class SubCategory {
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

  SubCategory({
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

  SubCategory.fromJson(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
        id = json['id'] as String?,
        title = json['title'] as String?,
        price14KT = (json['price14KT'] as num?)?.toDouble(),
        price18KT = (json['price18KT'] as num?)?.toDouble(),
        image01 = json['image01'] as String?,
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
        image02 = json['image02'] as String?,
        image03 = json['image03'] as String?,
        updatedAt = json['updatedAt'] as String?,
        video = json['video'] as String?,
        gift = json['gift'] as String?,
        rating = (json['rating'] as num?)?.toDouble(),
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {
        '_id': productId,
        'id': id,
        'title': title,
        'price14KT': price14KT,
        'price18KT': price18KT,
        'image01': image01,
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
        'image02': image02,
        'image03': image03,
        'updatedAt': updatedAt,
        'video': video,
        'gift': gift,
        'rating': rating,
        'gender': gender
      };
}

class Banners {
  final String? bannerId;
  final String? bannerImage;
  final String? createdAt;
  final int? v;

  Banners({
    this.bannerId,
    this.bannerImage,
    this.createdAt,
    this.v,
  });

  Banners.fromJson(Map<String, dynamic> json)
      : bannerId = json['banner_id'] as String?,
        bannerImage = json['bannerImage'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'banner_id': bannerId,
        'bannerImage': bannerImage,
        'createdAt': createdAt,
        '__v': v
      };
}

class MergedProducts {
  final String? category;
  final String? categoryImage;
  final List<SubCategoryBrowsed>? subCategory;

  MergedProducts({
    this.category,
    this.categoryImage,
    this.subCategory,
  });

  MergedProducts.fromJson(Map<String, dynamic> json)
      : category = json['category'] as String?,
        categoryImage = json['categoryImage'] as String?,
        subCategory = (json['subCategory'] as List?)?.map((dynamic e) => SubCategoryBrowsed.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'category' : category,
    'categoryImage' : categoryImage,
    'subCategory' : subCategory?.map((e) => e.toJson()).toList()
  };
}

class SubCategoryBrowsed {
  final String? productId;
  final String? title;
  final double? price14KT;
  final String? image01;
  final String? category;
  final String? subCategory;

  SubCategoryBrowsed({
    this.productId,
    this.title,
    this.price14KT,
    this.image01,
    this.category,
    this.subCategory,
  });

  SubCategoryBrowsed.fromJson(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
        title = json['title'] as String?,
        price14KT = (json['price14KT'] as num?)?.toDouble(),
        image01 = json['image01'] as String?,
        category = json['category'] as String?,
        subCategory = json['subCategory'] as String?;

  Map<String, dynamic> toJson() => {
    'productId' : productId,
    'title' : title,
    'price14KT' : price14KT,
    'image01' : image01,
    'category' : category,
    'subCategory' : subCategory
  };
}