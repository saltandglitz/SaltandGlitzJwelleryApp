import 'package:get/get.dart';
import 'package:saltandglitz/core/utils/local_strings.dart';

class CollectionFilterController extends GetxController {
  var selectedCategory = 0.obs;
  var selectedFilters = <String>[].obs;

  void updateCategory(int index) {
    selectedCategory.value = index;
    update();
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    update();
  }

  Map<String, List<String>> getFormattedFilters() {
    var formatted = <String, List<String>>{};
    for (var category in categories) {
      var filtersList = filters[category] ?? [];
      var selected = filtersList
          .where((filter) => selectedFilters.contains(filter))
          .toList();

      if (selected.isNotEmpty) {
        if (category == LocalStrings.price) {
          selected = selected.map((f) => f.replaceAll('₹', '').trim()).toList();
        }
        formatted[category] = selected;
      }
    }
    return formatted;
  }

  void logSelectedFilters() {
    print("Selected Filters: ${getFormattedFilters()}");
  }

  void clearAllFilters() {
    selectedFilters.clear();
    update();
  }

  final List<String> categories = [
    LocalStrings.price,
    LocalStrings.productsType,
    LocalStrings.shopFor,
    LocalStrings.occasion,
    LocalStrings.gifts,
  ];

  final Map<String, List<String>> filters = {
    LocalStrings.price: [
      "₹ ${LocalStrings.itemFirstPrice}",
      "₹ ${LocalStrings.itemSecondPrice}",
      "₹ ${LocalStrings.itemThirdPrice}",
      "₹ ${LocalStrings.itemForPrice}",
      "₹ ${LocalStrings.itemFivePrice}",
      "₹ ${LocalStrings.itemSixPrice}",
      "₹ ${LocalStrings.itemSevenPrice}",
      "₹ ${LocalStrings.itemEightPrice}",
    ],
    LocalStrings.productsType: [
      LocalStrings.ringFilter,
      LocalStrings.earringFilter,
      LocalStrings.ladiesBraceletFilter,
    ],
    LocalStrings.shopFor: [
      LocalStrings.female,
      LocalStrings.male,
    ],
    LocalStrings.occasion: [
      LocalStrings.chainOccasionFilter,
      LocalStrings.jhumkasOccasionFilter,
      LocalStrings.ovalOccasionFilter,
      LocalStrings.solitaireOccasionFilter,
      LocalStrings.engagementOccasionFilter,
    ],
    LocalStrings.gifts: [
      LocalStrings.graduateGiftsFilter,
      LocalStrings.birthdayGiftsFilter,
      LocalStrings.weddingGiftsFilter,
      LocalStrings.engagementGiftsFilter,
      LocalStrings.herGiftsFilter,
    ]
  };
}
