import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';

import '../../../analytics/app_analytics.dart';

class CollectionFilterController extends GetxController {
  var selectedCategory = 0.obs;
  var selectedFilters = <String>[].obs;

  void updateCategory(int index) {
    selectedCategory.value = index;
    update();
  }

// Selected categories wise filter
  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    update();
  }

  /// Get filter data key & value list of model type
  // Function to get formatted filters as a map of categories to selected filter values
  Map<String, List<String>> getFormattedFilters() {
    var formattedFilters = <String, List<String>>{};

    // Loop through each category to find the selected filter values
    for (var category in categories) {
      var filtersList = filters[category] ?? [];
      var selected = filtersList
          .where((filter) => selectedFilters.contains(filter))
          .toList();

      if (selected.isNotEmpty) {
        // Check if the category is 'Price' and clean the values
        if (category == 'Price') {
          selected = selected
              .map((filter) => filter.replaceAll('₹', '').trim())
              .toList();
        }

        // Add the selected filter values to the map for the specific category
        formattedFilters[category] = selected;
      }
    }

    return formattedFilters;
  }

  void logSelectedFilters() {
    print("Selected Filters: ${getFormattedFilters()}");

    /// Whole filter product set analysis product
    // AppAnalytics().actionTriggerWithProductsLogs(
    //     eventName: LocalStrings.logCollectionProductFilter,
    //     productFilter: getFormattedFilters(),
    //     index: 7);
  }

// Clear all selected filter
  void clearAllFilters() {
    selectedFilters.clear();
    update();
  }

  final List<String> categories = [
    LocalStrings.price,
    LocalStrings.productsType,
    // LocalStrings.material,
    LocalStrings.shopFor,
    LocalStrings.occasion,
    // LocalStrings.gemstone,
    LocalStrings.gifts,
    // LocalStrings.theme,
    // LocalStrings.fastDelivery,
    // LocalStrings.engravable,
  ];

  final Map<String, List<String>> filters = {
    /*LocalStrings.price: [
      'Under Rs.5000',
      'Rs.5001 To Rs.10000',
      'Rs.10001 To Rs.15000',
      'Rs.15001 To Rs.20000',
      'Rs.20001 To Rs.30000',
      'Rs.30001 To Rs.40000',
      'Rs.40001 To Rs.50000',
      'Rs.50001 To Rs.75000',
      'Rs.75001 To Rs.100000',
      'Rs.100001 To Rs.150000',
      'Rs.150001 To Rs.200000',
    ],*/
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
    // LocalStrings.material: [
    //   LocalStrings.gemstoneFilter,
    //   LocalStrings.platinumFilter,
    //   LocalStrings.solitaireFilter,
    //   LocalStrings.goldFilter,
    // ],
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
    // LocalStrings.gemstone: [
    //   'Pearl',
    //   'Synthetic Ruby',
    //   'Sapphire',
    //   'Synthetic Sapphire',
    //   'Ruby',
    //   'Synthetic Emerald',
    //   'Cat’s Eye',
    //   'Coral',
    //   'Emerald',
    //   'Topaz',
    //   'Citrine',
    //   'Onyx',
    //   'Synthetic Topaz',
    //   'Amethyst',
    //   'Smoky Quartz',
    //   'Synthetic Amethyst',
    //   'Synthetic Green',
    //   'Peridot',
    //   'Rose Quartz',
    //   'Synthetic Black',
    //   'Evil Eye Stone'
    // ],
    LocalStrings.gifts: [
      LocalStrings.graduateGiftsFilter,
      LocalStrings.birthdayGiftsFilter,
      LocalStrings.weddingGiftsFilter,
      LocalStrings.engagementGiftsFilter,
      LocalStrings.herGiftsFilter,
    ],
    // LocalStrings.theme: [
    //   'Quirky',
    //   'Designer',
    //   'Cluster',
    //   'Bow',
    //   'Essentials',
    //   'Contemporary',
    //   'Cut Out',
    //   'Heartbeat Diamonds',
    //   'Modern',
    //   'Tassels',
    //   'Traditional',
    //   'International Necklace',
    //   'Krishna'
    // ],
    // LocalStrings.fastDelivery: ['1'],
    // LocalStrings.engravable: ['1'],
  };
}
