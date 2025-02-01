import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';

import '../../../local_storage/sqflite_local_storage.dart';

class CollectionController extends GetxController {
  var currentIndex = (-1).obs;
  var favoriteStatus = <bool>[];

  // Sort collection data
  List sortProductsLst = [
    LocalStrings.latest,
    LocalStrings.featured,
    LocalStrings.priceLow,
    LocalStrings.priceHigh,
    LocalStrings.customerRating
  ];

  // Collection image
  List collectionDataImageLst = [
    MyImages.ringOneImage,
    MyImages.ringSecondImage,
    MyImages.ringThirdImage,
    MyImages.ringForImage,
    MyImages.ringFiveImage,
    MyImages.ringOneImage,
    MyImages.ringThirdImage,
    MyImages.ringSecondImage,
  ];

  // Collection item name
  List collectionDataNameLst = [
    LocalStrings.goldenRing,
    LocalStrings.diamondRingFirst,
    LocalStrings.diamondRingSecond,
    LocalStrings.stoneRing,
    LocalStrings.stoneDiamondRing,
    LocalStrings.goldenRing,
    LocalStrings.diamondRingSecond,
    LocalStrings.diamondRingFirst,
  ];

  // Collection item cutoff price
  List collectionCutOffPrice = [
    LocalStrings.priceProductItemFirst,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFive,
    LocalStrings.priceProductItemSeven,
    LocalStrings.priceProductItemNine,
    LocalStrings.priceProductItemEleven,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFirst,
  ];

// Collection item total price

  List collectionTotalPrice = [
    LocalStrings.priceProductItemSecond,
    LocalStrings.priceProductItemFor,
    LocalStrings.priceProductItemSix,
    LocalStrings.priceProductItemEight,
    LocalStrings.priceProductItemTen,
    LocalStrings.priceProductItemTwelve,
    LocalStrings.priceProductItemFor,
    LocalStrings.priceProductItemSecond,
  ];

  //Collection rating lst
  List collectionRatingLst = [
    LocalStrings.ratingFirst,
    LocalStrings.ratingSecond,
    LocalStrings.ratingThird,
    LocalStrings.ratingFor,
    LocalStrings.ratingFive,
    LocalStrings.ratingSix,
    LocalStrings.ratingFirst,
    LocalStrings.ratingSecond,
  ];

  //Collection post update lst
  List collectionPostUpdateLst = [
    LocalStrings.latestText,
    LocalStrings.bestSeller,
    LocalStrings.blankText,
    LocalStrings.bestSeller,
    LocalStrings.latestText,
    LocalStrings.bestSeller,
    LocalStrings.blankText,
    LocalStrings.bestSeller,
  ];

  // Initialize with a default value (e.g., false for all items)
  @override
  void onInit() {
    super.onInit();
    favoriteStatus = List.generate(collectionDataImageLst.length, (_) => false);
  }

  void toggleFavorite(int index) {
    favoriteStatus[index] = !favoriteStatus[index];
    update(); // Notify listeners
  }

  bool isFavorite(int index) {
    return favoriteStatus[index];
  }

  // Sort selecting item
  sortCurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }

  // Sqflite database using recently stored products
  void addProduct(
      String image, String name, String totalCost, String cutoffCost) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnImage: image,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnTotalCost: totalCost,
      DatabaseHelper.columnCutoffCost: cutoffCost,
    };

    final dbHelper = DatabaseHelper.instance;

    // Check if the product already exists
    List<Map<String, dynamic>> existingProducts =
        await dbHelper.queryRowsByName(
            image: image,
            name: name,
            totalCost: totalCost,
            cutoffCost: cutoffCost);

    if (existingProducts.isNotEmpty) {
      // Update the existing product
      row[DatabaseHelper.columnId] =
          existingProducts.first[DatabaseHelper.columnId];
      await dbHelper.update(row);
    } else {
      // Insert the new product
      await dbHelper.insert(row);
    }

    update();
  }
}
