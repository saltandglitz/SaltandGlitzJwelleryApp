class HomeViewModel {
  final String? message;
  final List<Banner>? banner;
  final List<NewArrivals>? newArrivals;
  final List<Poster>? poster;
  final List<Solitire>? solitire;
  final List<BottomBanner>? bottomBanner;
  final List<FilterCategory>? filterCategory;
  final List<CategoryImage>? categoryImage;
  final List<Gifts>? gifts;

  HomeViewModel({
    this.message,
    this.banner,
    this.newArrivals,
    this.poster,
    this.solitire,
    this.bottomBanner,
    this.filterCategory,
    this.categoryImage,
    this.gifts,
  });

  HomeViewModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        banner = (json['banner'] as List?)
            ?.map((dynamic e) => Banner.fromJson(e as Map<String, dynamic>))
            .toList(),
        newArrivals = (json['newArrivals'] as List?)
            ?.map(
                (dynamic e) => NewArrivals.fromJson(e as Map<String, dynamic>))
            .toList(),
        poster = (json['poster'] as List?)
            ?.map((dynamic e) => Poster.fromJson(e as Map<String, dynamic>))
            .toList(),
        solitire = (json['solitire'] as List?)
            ?.map((dynamic e) => Solitire.fromJson(e as Map<String, dynamic>))
            .toList(),
        bottomBanner = (json['bottomBanner'] as List?)
            ?.map(
                (dynamic e) => BottomBanner.fromJson(e as Map<String, dynamic>))
            .toList(),
        filterCategory = (json['filterCategory'] as List?)
            ?.map((dynamic e) =>
                FilterCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        categoryImage = (json['categoryImage'] as List?)
            ?.map((dynamic e) =>
                CategoryImage.fromJson(e as Map<String, dynamic>))
            .toList(),
        gifts = (json['gifts'] as List?)
            ?.map((dynamic e) => Gifts.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'message': message,
        'banner': banner?.map((e) => e.toJson()).toList(),
        'newArrivals': newArrivals?.map((e) => e.toJson()).toList(),
        'poster': poster?.map((e) => e.toJson()).toList(),
        'solitire': solitire?.map((e) => e.toJson()).toList(),
        'bottomBanner': bottomBanner?.map((e) => e.toJson()).toList(),
        'filterCategory': filterCategory?.map((e) => e.toJson()).toList(),
        'categoryImage': categoryImage?.map((e) => e.toJson()).toList(),
        'gifts': gifts?.map((e) => e.toJson()).toList()
      };
}

class Banner {
  final String? bannerId;
  final String? bannerImage;
  final String? createdAt;
  final int? v;

  Banner({
    this.bannerId,
    this.bannerImage,
    this.createdAt,
    this.v,
  });

  Banner.fromJson(Map<String, dynamic> json)
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

class Media {
  final String? type;
  final String? mobileBannerImage;

  Media({
    this.type,
    this.mobileBannerImage,
  });

  Media.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        mobileBannerImage = json['mobileBannerImage'] as String?;

  Map<String, dynamic> toJson() => {
        'type': type,
        'mobileBannerImage': mobileBannerImage,
      };
}

class NewArrivals {
  final String? productId;
  final String? isAlready;
  final List<MediaNewArrivals>? media;
  final String? id;
  final String? title;
  final String? gender;
  final num? price14KT;
  final num? price18KT;
  final String? image01;
  final String? image02;
  final String? image03;
  final String? image04;
  final String? image05;
  final String? video;
  final String? category;
  final String? subCategory;
  final String? material;
  final num? diamondprice;
  final num? makingCharge14KT;
  final num? makingCharge18KT;
  final double? grossWt;
  final double? netWeight14KT;
  final double? netWeight18KT;
  final num? gst14KT;
  final num? gst18KT;
  final num? total14KT;
  final num? total18KT;
  final bool? isFavourite;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  NewArrivals({
    this.productId,
    this.isAlready,
    this.media,
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

  NewArrivals.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        isAlready = json['isAlready'] as String?,
        media = (json['media'] as List?)
            ?.map((dynamic e) =>
                MediaNewArrivals.fromJson(e as Map<String, dynamic>))
            .toList(),
        id = json['id'] as String?,
        title = json['title'] as String?,
        gender = json['gender'] as String?,
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
        'isAlready': isAlready,
        'media': media?.map((e) => e.toJson()).toList(),
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

class MediaNewArrivals {
  final String? type;
  final String? productAsset;

  MediaNewArrivals({
    this.type,
    this.productAsset,
  });

  MediaNewArrivals.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        productAsset = json['productAsset'] as String?;

  Map<String, dynamic> toJson() => {'type': type, 'productAsset': productAsset};
}

class Poster {
  final String? posterId;
  final String? posterImage;
  final String? createdAt;
  final int? v;

  Poster({
    this.posterId,
    this.posterImage,
    this.createdAt,
    this.v,
  });

  Poster.fromJson(Map<String, dynamic> json)
      : posterId = json['poster_id'] as String?,
        posterImage = json['posterImage'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'poster_id': posterId,
        'posterImage': posterImage,
        'createdAt': createdAt,
        '__v': v
      };
}

class Solitire {
  final String? productId;
  final String? isAlready;
  final List<MediaSolitire>? media;
  final String? id;
  final String? title;
  final String? gender;
  final int? price14KT;
  final int? price18KT;
  final String? image01;
  final String? image02;
  final String? image03;
  final String? image04;
  final String? image05;
  final String? video;
  final String? category;
  final String? subCategory;
  final String? material;
  final int? diamondprice;
  final int? makingCharge14KT;
  final double? makingCharge18KT;
  final double? grossWt;
  final double? netWeight14KT;
  final double? netWeight18KT;
  final double? gst14KT;
  final int? gst18KT;
  final double? total14KT;
  final double? total18KT;
  final bool? isFavourite;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Solitire({
    this.productId,
    this.isAlready,
    this.media,
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

  Solitire.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        isAlready = json['isAlready'] as String?,
        media = (json['media'] as List?)
            ?.map((dynamic e) =>
                MediaSolitire.fromJson(e as Map<String, dynamic>))
            .toList(),
        id = json['id'] as String?,
        title = json['title'] as String?,
        gender = json['gender'] as String?,
        price14KT = json['price14KT'] as int?,
        price18KT = json['price18KT'] as int?,
        image01 = json['image01'] as String?,
        image02 = json['image02'] as String?,
        image03 = json['image03'] as String?,
        image04 = json['image04'] as String?,
        image05 = json['image05'] as String?,
        video = json['video'] as String?,
        category = json['category'] as String?,
        subCategory = json['subCategory'] as String?,
        material = json['material'] as String?,
        diamondprice = json['diamondprice'] as int?,
        makingCharge14KT = json['makingCharge14KT'] as int?,
        makingCharge18KT = json['makingCharge18KT'] as double?,
        grossWt = json['grossWt'] as double?,
        netWeight14KT = json['netWeight14KT'] as double?,
        netWeight18KT = json['netWeight18KT'] as double?,
        gst14KT = json['gst14KT'] as double?,
        gst18KT = json['gst18KT'] as int?,
        total14KT = json['total14KT'] as double?,
        total18KT = json['total18KT'] as double?,
        isFavourite = json['isFavourite'] as bool?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'isAlready': isAlready,
        'media': media?.map((e) => e.toJson()).toList(),
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

class MediaSolitire {
  final String? type;
  final String? productAsset;

  MediaSolitire({
    this.type,
    this.productAsset,
  });

  MediaSolitire.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        productAsset = json['productAsset'] as String?;

  Map<String, dynamic> toJson() => {'type': type, 'productAsset': productAsset};
}

class BottomBanner {
  final String? bottomBannerId;
  final String? bannerImage;
  final String? createdAt;
  final int? v;

  BottomBanner({
    this.bottomBannerId,
    this.bannerImage,
    this.createdAt,
    this.v,
  });

  BottomBanner.fromJson(Map<String, dynamic> json)
      : bottomBannerId = json['bottomBanner_id'] as String?,
        bannerImage = json['bannerImage'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'bottomBanner_id': bottomBannerId,
        'bannerImage': bannerImage,
        'createdAt': createdAt,
        '__v': v
      };
}

class FilterCategory {
  final String? filterCategoryId;
  final String? filterCategoryName;
  final String? filterCategoryImage;
  final String? createdAt;
  final int? v;

  FilterCategory({
    this.filterCategoryId,
    this.filterCategoryName,
    this.filterCategoryImage,
    this.createdAt,
    this.v,
  });

  FilterCategory.fromJson(Map<String, dynamic> json)
      : filterCategoryId = json['filterCategory_id'] as String?,
        filterCategoryName = json['filterCategoryName'] as String?,
        filterCategoryImage = json['filterCategoryImage'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'filterCategory_id': filterCategoryId,
        'filterCategoryName': filterCategoryName,
        'filterCategoryImage': filterCategoryImage,
        'createdAt': createdAt,
        '__v': v
      };
}

class CategoryImage {
  final String? categoryImageId;
  final String? categoryName;
  final String? categoryImage;
  final String? createdAt;
  final int? v;

  CategoryImage({
    this.categoryImageId,
    this.categoryName,
    this.categoryImage,
    this.createdAt,
    this.v,
  });

  CategoryImage.fromJson(Map<String, dynamic> json)
      : categoryImageId = json['categoryImage_Id'] as String?,
        categoryName = json['categoryName'] as String?,
        categoryImage = json['categoryImage'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'categoryImage_Id': categoryImageId,
        'categoryName': categoryName,
        'categoryImage': categoryImage,
        'createdAt': createdAt,
        '__v': v
      };
}

class Gifts {
  final String? giftId;
  final String? giftName;
  final String? giftImage;
  final String? createdAt;
  final int? v;

  Gifts({
    this.giftId,
    this.giftName,
    this.giftImage,
    this.createdAt,
    this.v,
  });

  Gifts.fromJson(Map<String, dynamic> json)
      : giftId = json['gift_id'] as String?,
        giftName = json['giftName'] as String?,
        giftImage = json['giftImage'] as String?,
        createdAt = json['createdAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'gift_id': giftId,
        'giftName': giftName,
        'giftImage': giftImage,
        'createdAt': createdAt,
        '__v': v
      };
}
