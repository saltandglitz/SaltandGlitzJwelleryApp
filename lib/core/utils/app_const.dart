//Todo : App const Globally set Data
import '../../data/model/categories_filter_view_model.dart' hide Media;
import '../../data/model/get_categories_view_model.dart';
import '../../data/model/get_you_may_also_like_model.dart';
import '../../data/model/home_view_model.dart';

// Whole app filled strings
Map<String, dynamic> appStrings = {};

///<<<-------------- Dashboard Screen ----------------->>>
// List<Banner> bannerList = [];
List<BottomBanner> bottomBannerList = [];
List<CategoryImage> categoryList = [];
List<NewArrivals> newArrivalList = [];
List<FilterCategory> filterCategoryList = [];
List<Gifts> giftElementList = [];
List<Media> mediaList = [];
List<Solitire> solitaireList = [];
List<dynamic> advertiseBanner = [];
List<Categories> getCategoryData = [];
List<Banners> getCategoryBannerData = [];
List<MergedProducts> getCategoryMostBrowsedData = [];
List<Categories> getCategoryMaleData = [];
List<Banners> getCategoryBannerMaleData = [];
List<MergedProducts> getCategoryMostBrowsedMaleData = [];
List<UpdatedProducts> filterProductData = [];
List<YouMayAlsoLikeModel> youMayAlsoLikeData = [];
