import 'package:get/get.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';

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

// Clear all selected filter
  void clearAllFilters() {
    selectedFilters.clear();
    update();
  }

  final List<String> categories = [
    LocalStrings.price,
    LocalStrings.productsType,
    LocalStrings.weightRanges,
    LocalStrings.material,
    LocalStrings.metal,
    LocalStrings.shopFor,
    LocalStrings.occasion,
    LocalStrings.gemstone,
    LocalStrings.gifts,
    LocalStrings.theme,
    LocalStrings.fastDelivery,
    LocalStrings.engravable,
  ];

  final Map<String, List<String>> filters = {
    LocalStrings.price: [
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
    ],
    LocalStrings.productsType: [
      'Earrings',
      'Rings',
      'Necklaces',
      'Pendants',
      'Set Product',
      'Bracelets',
      'Bangles',
      'Chains',
      'Sets',
      'Mangalsutra',
      'Nose pin',
      'Nath',
      'Charms',
      'Adjustable Rings',
      'Charms Builders',
      'Tanmaniya'
    ],
    LocalStrings.weightRanges: [
      '0-2 g',
      '2-5 g',
      '5-10 g',
      '10-20 g',
      '20-30 g',
    ],
    LocalStrings.material: [
      'Platinum',
      'Gold',
      'Diamond',
      'Gemstone',
      'Solitaire'
    ],
    LocalStrings.metal: [
      '18 KT Yellow',
      '18 KT White',
      '18 KT Rose',
      '18 KT Two Tone',
      '14 KT Yellow',
      '14 KT Rose',
      '14 KT Two Tone',
      '14 KT Three Tone',
      'Platinum 950'
    ],
    LocalStrings.shopFor: ['Women', 'Men'],
    LocalStrings.occasion: ['Work Wear', 'Daily Wear', 'Evening', 'Party Wear'],
    LocalStrings.gemstone: [
      'Pearl',
      'Synthetic Ruby',
      'Sapphire',
      'Synthetic Sapphire',
      'Ruby',
      'Synthetic Emerald',
      'Cat’s Eye',
      'Coral',
      'Emerald',
      'Topaz',
      'Citrine',
      'Onyx',
      'Synthetic Topaz',
      'Amethyst',
      'Smoky Quartz',
      'Synthetic Amethyst',
      'Synthetic Green',
      'Peridot',
      'Rose Quartz',
      'Synthetic Black',
      'Evil Eye Stone'
    ],
    LocalStrings.gifts: [
      'Self Gifting Curation',
      'Birthday Gifts',
      'Anniversary Gifts',
      'Women’s Day Gifts',
      'Harvest Season Gifts',
      'Festive Gifts',
      'Mother’s Day Gifts',
      'Karva Chauth Gifts for Wife',
      'Gifts for Friends',
      'New Arrivals',
      'Valentine’s Day Gifts for Mom',
      'Valentine’s Day Special Hearts Gifts',
      'Just Because Gifts',
      '15k',
      'Valentine’s Day Gifts for Wife'
    ],
    LocalStrings.theme: [
      'Quirky',
      'Designer',
      'Cluster',
      'Bow',
      'Essentials',
      'Contemporary',
      'Cut Out',
      'Heartbeat Diamonds',
      'Modern',
      'Tassels',
      'Traditional',
      'International Necklace',
      'Krishna'
    ],
    LocalStrings.fastDelivery: ['1'],
    LocalStrings.engravable: ['1'],
  };
}
