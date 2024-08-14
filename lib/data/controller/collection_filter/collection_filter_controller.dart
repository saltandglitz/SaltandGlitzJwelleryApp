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
    LocalStrings.discountRanges,
    LocalStrings.productsType,
    LocalStrings.weightRanges,
    LocalStrings.material,
    LocalStrings.metal,
    LocalStrings.shopFor,
    LocalStrings.occasion,
    LocalStrings.gemstone,
    LocalStrings.gifts,
    LocalStrings.theme,
    LocalStrings.discounts,
    LocalStrings.gemstoneColour,
    LocalStrings.collections,
    LocalStrings.necklaceStyle,
    LocalStrings.chainLength,
    LocalStrings.braceletStyle,
    LocalStrings.pendantStyle,
    LocalStrings.tryHome,
    LocalStrings.curatedBy,
    LocalStrings.fastDelivery,
    LocalStrings.alphabet,
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
    LocalStrings.discountRanges: ['15-20%', 'Below 10%', '10-15%'],
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
    LocalStrings.discounts: [
      'Up to 15% off on Diamond Prices',
      'Up to 10% off on Diamond Prices',
      'Up to 5% off on Diamond Prices',
      'Up to 20% off on Diamond Prices',
      'Up to 10% off on Making Charges',
      'Flat 20% off on MRP',
      'Flat 10% off on MRP'
    ],
    LocalStrings.gemstoneColour: [
      'White',
      'Red',
      'Blue',
      'Green',
      'Pink',
      'Purple',
      'Yellow',
      'Black',
      'Orange'
    ],
    LocalStrings.collections: [
      'Butterfly - The Spirit of You',
      'Jaipur',
      'Bombay Deco',
      'Zyrah',
      'Aaranya',
      'Dragonfly',
      'Dewdrops',
      'Ballet',
      'Gold Lace',
      'Love Letters',
      'Disney Collection',
      'Harry Potter'
    ],
    LocalStrings.necklaceStyle: [
      'Casual Necklace',
      'Personalised',
      'Lariat',
      'Bar Necklace',
      'Multi Layered',
      'Long Chain',
      'Round Necklaces',
      'Yellow Gold Necklaces',
      'Western Necklace'
    ],
    LocalStrings.chainLength: ['16 inches'],
    LocalStrings.braceletStyle: ['Chain Bracelet'],
    LocalStrings.pendantStyle: [
      'Casual',
      'Chain Pendants',
      'Alphabets',
      'God Pendant'
    ],
    LocalStrings.tryHome: ['1'],
    LocalStrings.curatedBy: [
      'All',
      'Gifts for Raksha Bandhan',
      'Most Wishlisted',
      'Best Sellers',
      'Halimark Gold',
      'Global Offers',
      'Lightweight Gold Chain',
      'Influencers Edit',
      'International Self Gifting',
      'International Diwali Offer',
      'Golden Monday Preview',
      '13 to 19 Year Old Teens'
    ],
    LocalStrings.fastDelivery: ['Fast Delivery'],
    LocalStrings.alphabet: [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ],
    LocalStrings.engravable: ['1'],
  };
}
