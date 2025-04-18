import 'app_const.dart';

class LocalStrings {
  static String appName =
      appStrings.isNotEmpty ? appStrings['appName'] : "Salt & Glitz";

  ///<<<------------------- API ------------------->>>
  static String getHomeViewApi = appStrings.isNotEmpty
      ? appStrings['getHomeViewApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/homePage/home";
  static String resetPasswordApi = appStrings.isNotEmpty
      ? appStrings['resetPasswordApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/api/users/verifyOtpAndResetPassword";
  static String forgotPasswordApi = appStrings.isNotEmpty
      ? appStrings['forgotPasswordApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/api/users/forgotPassword";
  static String sendOtpApi = appStrings.isNotEmpty
      ? appStrings['sendOtpApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/otp/send-otp";
  static String getOtpApi = appStrings.isNotEmpty
      ? appStrings['getOtpApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/otp/get-otp";
  static String registerApi = appStrings.isNotEmpty
      ? appStrings['registerApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/api/users/register";
  static String womenCategoriesApi = appStrings.isNotEmpty
      ? appStrings['womenCategoriesApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/category/categoryData";
  static String menCategoriesApi = appStrings.isNotEmpty
      ? appStrings['menCategoriesApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/category/categoryData/Male";
  static String logoutApi = appStrings.isNotEmpty
      ? appStrings['logoutApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/api/users/logout";
  static String logInApi = appStrings.isNotEmpty
      ? appStrings['logInApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/api/users/login";
  static String filterProductApi = appStrings.isNotEmpty
      ? appStrings['filterProductApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/upload/filterProduct";
  static String sendEmailOtpApi = appStrings.isNotEmpty
      ? appStrings['sendEmailOtpApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/otp/send-otp";
  static String searchProductApi = appStrings.isNotEmpty
      ? appStrings['searchProductApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/search/searchProduct";
  static String wishlistProductApi = appStrings.isNotEmpty
      ? appStrings['wishlistProductApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/wishlist/create_wishlist";
  static String removeWishlistProductApi = appStrings.isNotEmpty
      ? appStrings['removeWishlistProductApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/wishlist/remove_wishlist/";
  static String getWishlistProductApi = appStrings.isNotEmpty
      ? appStrings['getWishlistProductApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/wishlist/get_wishlist/";
  static String addToCartApi = appStrings.isNotEmpty
      ? appStrings['addToCartApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/cart/addCart";
  static String getCartApi = appStrings.isNotEmpty
      ? appStrings['getCartApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/cart/getCart/";
  static String removeCartApi = appStrings.isNotEmpty
      ? appStrings['removeCartApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/cart/remove/";
  static String incrementCartItemQuantityApi = appStrings.isNotEmpty
      ? appStrings['incrementCartItemQuantityApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/cart/cartIncrement";
  static String decrementCartItemQuantityApi = appStrings.isNotEmpty
      ? appStrings['decrementCartItemQuantityApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/cart/cartDecrement";
  static String mergeProductApi = appStrings.isNotEmpty
      ? appStrings['mergeProductApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/merge/mergeCartAndWishlist";
  static String googleSigInApi = appStrings.isNotEmpty
      ? appStrings['googleSigInApi']
      : "https://saltandglitz-api-131827005467.asia-south2.run.app/api/users/google-login";
  static String
      updateRatingApi = /*appStrings.isNotEmpty
      ? appStrings['updateRatingApi']
      :*/
      "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/rating/updateRating";
  static String
      getRatingApi = /*appStrings.isNotEmpty
      ? appStrings['getRatingApi']
      :*/
      "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/rating/getRating/";
  static String
      addRatingApi = /*appStrings.isNotEmpty
      ? appStrings['addRatingApi']
      :*/
      "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/rating/addRating";
  static String
      createOrderApi = /*appStrings.isNotEmpty
      ? appStrings['createOrderApi']
      :*/
      "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/order/createOrder/";
  static String
      getAddressApi = /*appStrings.isNotEmpty
      ? appStrings['getAddressApi']
      :*/
      "https://saltandglitz-api-131827005467.asia-south2.run.app/v1/address/getAddress/";

  ///<<<------------------- Dashboard Screen ------------------->>>
  static String solitaire =
      appStrings.isNotEmpty ? appStrings['solitaire'] : "Solitaire";
  static String searchNotAvailable = appStrings.isNotEmpty
      ? appStrings['searchNotAvailable']
      : "Search products items not available!";
  static String hardwareSalt = appStrings.isNotEmpty
      ? appStrings['hardwareSalt']
      : "HardWare By Salt and Glitz";
  static String shopNow =
      appStrings.isNotEmpty ? appStrings['shopNow'] : "Shop Now >";
  static String shopBy =
      appStrings.isNotEmpty ? appStrings['shopBy'] : "Shop by Category";
  static String wrappedWithLove = appStrings.isNotEmpty
      ? appStrings['wrappedWithLove']
      : "Wrapped with Love !";
  static String earings =
      appStrings.isNotEmpty ? appStrings['earings'] : "Earings";
  static String brilliantDesign = appStrings.isNotEmpty
      ? appStrings['brilliantDesign']
      : "Brilliant design and unparalleled craftsmanship.";
  static String newArrival =
      appStrings.isNotEmpty ? appStrings['newArrival'] : "New Arrivals";
  static String planOfPurchase = appStrings.isNotEmpty
      ? appStrings['planOfPurchase']
      : "Your Plan of Purchase";
  static String startYourPop =
      appStrings.isNotEmpty ? appStrings['startYourPop'] : "Start your pop!";
  static String aHassleFree = appStrings.isNotEmpty
      ? appStrings['aHassleFree']
      : "A hassle free Plan of Purchase";
  static String in9Easy = appStrings.isNotEmpty
      ? appStrings['in9Easy']
      : "In 9 easy installments, own your\nfavorite designs!";
  static String rings = appStrings.isNotEmpty ? appStrings['rings'] : "Rings";
  static String pendants =
      appStrings.isNotEmpty ? appStrings['pendants'] : "Pendants";
  static String goldChains =
      appStrings.isNotEmpty ? appStrings['goldChains'] : "GoldChains";
  static String earrings =
      appStrings.isNotEmpty ? appStrings['earrings'] : "Earrings";
  static String nosePins =
      appStrings.isNotEmpty ? appStrings['nosePins'] : "Nose Pins";
  static String watches =
      appStrings.isNotEmpty ? appStrings['watches'] : "Watches";
  static String giftsGraduate = appStrings.isNotEmpty
      ? appStrings['giftsGraduate']
      : "Gifts for the Graduate";
  static String giftsHim =
      appStrings.isNotEmpty ? appStrings['giftsHim'] : "Gifts for Him";
  static String giftsHer =
      appStrings.isNotEmpty ? appStrings['giftsHer'] : "Gifts for Her";
  static String shippingReturns = appStrings.isNotEmpty
      ? appStrings['shippingReturns']
      : "Shipping & Returns";
  static String complementaryShipping = appStrings.isNotEmpty
      ? appStrings['complementaryShipping']
      : "We offer Complementary Shipping & Returns";
  static String learnMore =
      appStrings.isNotEmpty ? appStrings['learnMore'] : "Learn More >";
  static String yourService =
      appStrings.isNotEmpty ? appStrings['yourService'] : "At Your Service";
  static String ourClient = appStrings.isNotEmpty
      ? appStrings['ourClient']
      : "Our Client car experts are always here.";
  static String contactUs =
      appStrings.isNotEmpty ? appStrings['contactUs'] : "Contact Us >";
  static String bookAppointment = appStrings.isNotEmpty
      ? appStrings['bookAppointment']
      : "Book Appointment";
  static String inStoreVirtual = appStrings.isNotEmpty
      ? appStrings['inStoreVirtual']
      : "We're happy in-store or virtual appointments.";
  static String bookNow =
      appStrings.isNotEmpty ? appStrings['bookNow'] : "Book Now >";
  static String blueBox =
      appStrings.isNotEmpty ? appStrings['blueBox'] : "Blue Box";
  static String purchaseComes = appStrings.isNotEmpty
      ? appStrings['purchaseComes']
      : "Purchase comes wrapped in our Blue Box.";
  static String exploreAll =
      appStrings.isNotEmpty ? appStrings['exploreAll'] : "Explore All Gifts >";
  static String clientCare =
      appStrings.isNotEmpty ? appStrings['clientCare'] : "Client Care";
  static String ourCompany =
      appStrings.isNotEmpty ? appStrings['ourCompany'] : "Our Company";
  static String contact =
      appStrings.isNotEmpty ? appStrings['contact'] : "- Contact Us";
  static String saltAndGlitz =
      appStrings.isNotEmpty ? appStrings['saltAndGlitz'] : "- Salt and Glitz";
  static String trackOrder =
      appStrings.isNotEmpty ? appStrings['trackOrder'] : "- Track Order";
  static String bookAnAppointment = appStrings.isNotEmpty
      ? appStrings['bookAnAppointment']
      : "- Book an Appointment";
  static String sustainability =
      appStrings.isNotEmpty ? appStrings['sustainability'] : "- Sustainability";
  static String supplyChains = appStrings.isNotEmpty
      ? appStrings['supplyChains']
      : "- Supply Chains Act";
  static String askedQuestions = appStrings.isNotEmpty
      ? appStrings['askedQuestions']
      : "- Asked Questions";
  static String californiaPrivacy = appStrings.isNotEmpty
      ? appStrings['californiaPrivacy']
      : "- California Privacy";
  static String shippingsReturns = appStrings.isNotEmpty
      ? appStrings['shippingsReturns']
      : "- Shippings & Returns";
  static String careers = appStrings.isNotEmpty
      ? appStrings['careers']
      : "- Salt and Glitz Careers";
  static String productsCare = appStrings.isNotEmpty
      ? appStrings['productsCare']
      : "- Products Care & Returns";
  static String policies =
      appStrings.isNotEmpty ? appStrings['policies'] : "- Policies";
  static String giftCards =
      appStrings.isNotEmpty ? appStrings['giftCards'] : "- Gift Cards";
  static String transparency = appStrings.isNotEmpty
      ? appStrings['transparency']
      : "- Transparency in Coverage";
  static String accessibility =
      appStrings.isNotEmpty ? appStrings['accessibility'] : "- Accessibility";
  static String sharePersonal = appStrings.isNotEmpty
      ? appStrings['sharePersonal']
      : "- Do Not Share Personal Information";
  static String targetedAdvertising = appStrings.isNotEmpty
      ? appStrings['targetedAdvertising']
      : "- Targeted Advertising";
  static String relatedSite = appStrings.isNotEmpty
      ? appStrings['relatedSite']
      : "Related Salt and Glitz sites";
  static String weddingsGift = appStrings.isNotEmpty
      ? appStrings['weddingsGift']
      : "- Wedding & Gift Registry";
  static String businessAccounts = appStrings.isNotEmpty
      ? appStrings['businessAccounts']
      : "- Business Accounts";
  static String saltAndGlitzPress = appStrings.isNotEmpty
      ? appStrings['saltAndGlitzPress']
      : "- Salt and Glitz for the Press";
  static String foundation = appStrings.isNotEmpty
      ? appStrings['foundation']
      : "- The Salt and Glitz & Co. Foundation";
  static String alertline = appStrings.isNotEmpty
      ? appStrings['alertline']
      : "- Salt and Glitz Alertline";
  static String siteIndex =
      appStrings.isNotEmpty ? appStrings['siteIndex'] : "- Site index";
  static String latestSaltAndGlitz = appStrings.isNotEmpty
      ? appStrings['latestSaltAndGlitz']
      : "Latest from Salt and Glitz";
  static String knowAbout = appStrings.isNotEmpty
      ? appStrings['knowAbout']
      : "Be the first know about exciting new designs,special events, store openings and much more";
  static String email = appStrings.isNotEmpty ? appStrings['email'] : "Email";
  static String signUp =
      appStrings.isNotEmpty ? appStrings['signUp'] : "Sign Up";
  static String yourCartWaiting = appStrings.isNotEmpty
      ? appStrings['yourCartWaiting']
      : "Your Cart is Waiting!";
  static String goToCart =
      appStrings.isNotEmpty ? appStrings['goToCart'] : "GO TO CART";
  static String
      saltPromise = /*appStrings.isNotEmpty
      ? appStrings['saltPromise']
      :*/
      "The Salt Promise";
  static String
      easyReturns = /*appStrings.isNotEmpty
      ? appStrings['easyReturns']
      :*/
      "30 Days Easy\nReturns";
  static String
      oneYearWarranty = /*appStrings.isNotEmpty
      ? appStrings['oneYearWarranty']
      :*/
      "One Year\nWarranty";
  static String
      hundredCertified = /*appStrings.isNotEmpty
      ? appStrings['hundredCertified']
      :*/
      "100%\nCertified";
  static String
      lifeTimeExchange = /*appStrings.isNotEmpty
      ? appStrings['lifeTimeExchange']
      :*/
      "Lifetime Exchange\n& Buyback";
  static String
      exclusiveDeals = /*appStrings.isNotEmpty
      ? appStrings['exclusiveDeals']
      :*/
      "Exclusive Deals";
  static String
      curatedOnlyForYou = /*appStrings.isNotEmpty
      ? appStrings['curatedOnlyForYou']
      :*/
      "Curated Only For You";

  ///<<<------------------- Add to cart Screen ------------------->>>
  static String shoppingCart =
      appStrings.isNotEmpty ? appStrings['shoppingCart'] : "Shopping Cart";
  static String pointsOrder = appStrings.isNotEmpty
      ? appStrings['pointsOrder']
      : "Get ₹ 2455 Exclusive points on the order.";
  static String nextOrder = appStrings.isNotEmpty
      ? appStrings['nextOrder']
      : "Redeem these points on your next order";
  static String oderOnline = appStrings.isNotEmpty
      ? appStrings['oderOnline']
      : "Order online & pick up your home";
  static String sameDay = appStrings.isNotEmpty
      ? appStrings['sameDay']
      : "on the same day choose nearby store";
  static String tiaTwine = appStrings.isNotEmpty
      ? appStrings['goToCart']
      : "Tia Twine solitaire Ring";
  static String chain = appStrings.isNotEmpty ? appStrings['chain'] : "Chain";
  static String orderRupeesFirst =
      appStrings.isNotEmpty ? appStrings['orderRupeesFirst'] : "₹58,296";
  static String orderRupeesSecond =
      appStrings.isNotEmpty ? appStrings['orderRupeesSecond'] : "₹72,869";
  static String quantity =
      appStrings.isNotEmpty ? appStrings['quantity'] : "Quantity :";
  static String quantityFirst =
      appStrings.isNotEmpty ? appStrings['quantityFirst'] : "1";
  static String quantitySecond =
      appStrings.isNotEmpty ? appStrings['quantitySecond'] : "2";
  static String size = appStrings.isNotEmpty ? appStrings['size'] : "Size :";
  static String sizeFirst =
      appStrings.isNotEmpty ? appStrings['sizeFirst'] : "12";
  static String sizeSecond =
      appStrings.isNotEmpty ? appStrings['sizeSecond'] : "13";
  static String sizeThird =
      appStrings.isNotEmpty ? appStrings['sizeThird'] : "15";
  static String deliveryDate = appStrings.isNotEmpty
      ? appStrings['deliveryDate']
      : "Est Delivery by 1st Aug";
  static String offersBenefits = appStrings.isNotEmpty
      ? appStrings['offersBenefits']
      : "Offers & Benefits";
  static String applyCoupon =
      appStrings.isNotEmpty ? appStrings['applyCoupon'] : "Apply Coupon";
  static String oderSummary =
      appStrings.isNotEmpty ? appStrings['oderSummary'] : "Order Summary";
  static String subtotal =
      appStrings.isNotEmpty ? appStrings['subtotal'] : "Subtotal";
  static String grandTotalPrice =
      appStrings.isNotEmpty ? appStrings['grandTotalPrice'] : "₹1,20,840";
  static String shippingCharge =
      appStrings.isNotEmpty ? appStrings['shippingCharge'] : "Shipping Charge";
  static String shippingInsurance = appStrings.isNotEmpty
      ? appStrings['shippingInsurance']
      : "Shipping Insurance";
  static String free = appStrings.isNotEmpty ? appStrings['free'] : "Free";
  static String grandTotal =
      appStrings.isNotEmpty ? appStrings['grandTotal'] : "Grand Total";
  static String contactFurther = appStrings.isNotEmpty
      ? appStrings['contactFurther']
      : "Contact us for further assistance";
  static String call = appStrings.isNotEmpty ? appStrings['call'] : "Call";
  static String chat = appStrings.isNotEmpty ? appStrings['chat'] : "Chat";
  static String whatsapp =
      appStrings.isNotEmpty ? appStrings['whatsapp'] : "Whatsapp";
  static String viewOrder =
      appStrings.isNotEmpty ? appStrings['viewOrder'] : "View Order Summary";
  static String placeOrder =
      appStrings.isNotEmpty ? appStrings['placeOrder'] : "PLACE ORDER";
  static String moveDesign = appStrings.isNotEmpty
      ? appStrings['moveDesign']
      : "Move design from cart";
  static String designCart = appStrings.isNotEmpty
      ? appStrings['designCart']
      : "Are you sure you want to move this design from the cart?";
  static String remove =
      appStrings.isNotEmpty ? appStrings['remove'] : "REMOVE";
  static String moveWishlist =
      appStrings.isNotEmpty ? appStrings['moveWishlist'] : "MOVE TO WISHLIST";

  ///<<<------------------- Bottom Screen ------------------->>>
  static String home = appStrings.isNotEmpty ? appStrings['home'] : "Home";
  static String categories =
      appStrings.isNotEmpty ? appStrings['categories'] : "Categories";
  static String you = appStrings.isNotEmpty ? appStrings['you'] : "You";

  ///<<<------------------- Categories Screen ------------------->>>
  static String women = appStrings.isNotEmpty ? appStrings['women'] : "Women";
  static String men = appStrings.isNotEmpty ? appStrings['men'] : "Men";

  ///<<<------------------- Women categories Screen ------------------->>>
  static String topCategories =
      appStrings.isNotEmpty ? appStrings['topCategories'] : "Top categories";
  static String bracelets =
      appStrings.isNotEmpty ? appStrings['bracelets'] : "Bracelets & Bangles";
  static String necklaces =
      appStrings.isNotEmpty ? appStrings['necklaces'] : "Necklaces";
  static String mangalsutra =
      appStrings.isNotEmpty ? appStrings['mangalsutra'] : "Mangalsutra";
  static String mostBrowsed =
      appStrings.isNotEmpty ? appStrings['mostBrowsed'] : "Most Browsed";
  static String moreJewellery =
      appStrings.isNotEmpty ? appStrings['moreJewellery'] : "More Jewellery";
  static String saltAndGlitzPostcards = appStrings.isNotEmpty
      ? appStrings['saltAndGlitzPostcards']
      : 'Saltand Glitz Postcards';
  static String shopGifts =
      appStrings.isNotEmpty ? appStrings['shopGifts'] : "Shop For Gifts";
  static String silverJewellery = appStrings.isNotEmpty
      ? appStrings['silverJewellery']
      : "Silver Jewellery | Wedding Edit";
  static String needHelp =
      appStrings.isNotEmpty ? appStrings['needHelp'] : "Need Help In Buying";
  static String shopStyle =
      appStrings.isNotEmpty ? appStrings['shopStyle'] : "Shop By Style";
  static String shopByPrice =
      appStrings.isNotEmpty ? appStrings['shopByPrice'] : "Shop By Price";
  static String allRings =
      appStrings.isNotEmpty ? appStrings['allRings'] : "All Rings";
  static String engagement =
      appStrings.isNotEmpty ? appStrings['engagement'] : "Engagement";
  static String dailywear =
      appStrings.isNotEmpty ? appStrings['dailywear'] : "Dailywear";
  static String platinumRings =
      appStrings.isNotEmpty ? appStrings['platinumRings'] : "Platinum Rings";
  static String bands = appStrings.isNotEmpty ? appStrings['bands'] : "Bands";
  static String cocktail =
      appStrings.isNotEmpty ? appStrings['cocktail'] : "Cocktail";
  static String coupleRings =
      appStrings.isNotEmpty ? appStrings['coupleRings'] : "Couple Rings";
  static String itemFirstPrice =
      appStrings.isNotEmpty ? appStrings['itemFirstPrice'] : "below20k";
  static String itemSecondPrice =
      appStrings.isNotEmpty ? appStrings['itemSecondPrice'] : "20kTo30k";
  static String itemThirdPrice =
      appStrings.isNotEmpty ? appStrings['itemThirdPrice'] : "30kTo50k";
  static String itemForPrice =
      appStrings.isNotEmpty ? appStrings['itemForPrice'] : "50kTo100k";
  static String itemFivePrice =
      appStrings.isNotEmpty ? appStrings['itemFivePrice'] : "100kTo200k";
  static String itemSixPrice =
      appStrings.isNotEmpty ? appStrings['itemSixPrice'] : "200kTo300k";
  static String itemSevenPrice =
      appStrings.isNotEmpty ? appStrings['itemSevenPrice'] : "300kTo500k";
  static String itemEightPrice =
      appStrings.isNotEmpty ? appStrings['itemEightPrice'] : "above500k";
  static String ringFilter =
      appStrings.isNotEmpty ? appStrings['ringFilter'] : "Ring";
  static String earringFilter =
      appStrings.isNotEmpty ? appStrings['earringFilter'] : "Earring";
  static String ladiesBraceletFilter = appStrings.isNotEmpty
      ? appStrings['ladiesBraceletFilter']
      : "Ladies Bracelet";
  static String gemstoneFilter =
      appStrings.isNotEmpty ? appStrings['gemstoneFilter'] : "Gemstone";
  static String platinumFilter =
      appStrings.isNotEmpty ? appStrings['platinumFilter'] : "Platinum";
  static String solitaireFilter =
      appStrings.isNotEmpty ? appStrings['solitaireFilter'] : "Solitaire";
  static String goldFilter =
      appStrings.isNotEmpty ? appStrings['goldFilter'] : "Gold";
  static String chainOccasionFilter = appStrings.isNotEmpty
      ? appStrings['chainOccasionFilter']
      : "Chain Bracelet";
  static String jhumkasOccasionFilter = appStrings.isNotEmpty
      ? appStrings['jhumkasOccasionFilter']
      : "Jhumkas Earring";
  static String ovalOccasionFilter = appStrings.isNotEmpty
      ? appStrings['ovalOccasionFilter']
      : "Oval Bracelet";
  static String solitaireOccasionFilter = appStrings.isNotEmpty
      ? appStrings['solitaireOccasionFilter']
      : "Solitaire Rings";
  static String engagementOccasionFilter = appStrings.isNotEmpty
      ? appStrings['engagementOccasionFilter']
      : "Engagement Rings";
  static String graduateGiftsFilter = appStrings.isNotEmpty
      ? appStrings['graduateGiftsFilter']
      : "Gift for Graduate";
  static String birthdayGiftsFilter = appStrings.isNotEmpty
      ? appStrings['birthdayGiftsFilter']
      : "Gift for Birthday";
  static String weddingGiftsFilter = appStrings.isNotEmpty
      ? appStrings['weddingGiftsFilter']
      : "Gift for Wedding";
  static String engagementGiftsFilter = appStrings.isNotEmpty
      ? appStrings['engagementGiftsFilter']
      : "Gift for Engagement";
  static String herGiftsFilter =
      appStrings.isNotEmpty ? appStrings['herGiftsFilter'] : "Gift for Her";
  static String charms =
      appStrings.isNotEmpty ? appStrings['charms'] : "Charms";
  static String noseRings =
      appStrings.isNotEmpty ? appStrings['noseRings'] : "Nose Rings";
  static String platinum =
      appStrings.isNotEmpty ? appStrings['platinum'] : "Platinum";
  static String watchCharms =
      appStrings.isNotEmpty ? appStrings['watchCharms'] : "Watch Charms";
  static String kt = appStrings.isNotEmpty ? appStrings['kt'] : "22 KT";
  static String allCollection =
      appStrings.isNotEmpty ? appStrings['allCollection'] : "All Collections";
  static String anniversaryGifts = appStrings.isNotEmpty
      ? appStrings['anniversaryGifts']
      : "Anniversary Gifts";
  static String birthdayGifts =
      appStrings.isNotEmpty ? appStrings['birthdayGifts'] : "Birthday Gifts";
  static String bestSelling =
      appStrings.isNotEmpty ? appStrings['bestSelling'] : "Best Selling Gifts";
  static String youMay =
      appStrings.isNotEmpty ? appStrings['youMay'] : "You May Also Like";
  static String shopOccasions = appStrings.isNotEmpty
      ? appStrings['shopOccasions']
      : "Shop For Occasions";
  static String saltAndPostcards = appStrings.isNotEmpty
      ? appStrings['saltAndPostcards']
      : 'Salt and Glitz Postcards';
  static String embedVideo = appStrings.isNotEmpty
      ? appStrings['embedVideo']
      : 'Embed a heartfelt video in your ring!';
  static String knowHow =
      appStrings.isNotEmpty ? appStrings['knowHow'] : 'Know How';
  static String clTv = appStrings.isNotEmpty ? appStrings['clTv'] : 'CL TV';
  static String watchBuy = appStrings.isNotEmpty
      ? appStrings['watchBuy']
      : 'Watch & Buy With Influencers.';
  static String playNow =
      appStrings.isNotEmpty ? appStrings['playNow'] : 'Play Now';
  static String pop =
      appStrings.isNotEmpty ? appStrings['pop'] : 'Salt and Glitz PoP!';
  static String planYour = appStrings.isNotEmpty
      ? appStrings['planYour']
      : 'Plan your purchases in advance.';
  static String learnMoreText =
      appStrings.isNotEmpty ? appStrings['learnMoreText'] : 'Learn More';
  static String goldExchange = appStrings.isNotEmpty
      ? appStrings['goldExchange']
      : 'Gold Exchange Program';
  static String yourPrecious = appStrings.isNotEmpty
      ? appStrings['yourPrecious']
      : 'Your precious gold,our new designs!';
  static String knowMore =
      appStrings.isNotEmpty ? appStrings['knowMore'] : 'Know More';
  static String gold = appStrings.isNotEmpty ? appStrings['gold'] : 'Gold';
  static String buySell = appStrings.isNotEmpty
      ? appStrings['buySell']
      : 'Buy, sell or redeem digital gold.';
  static String
      exitApp = /*appStrings.isNotEmpty
      ? appStrings['exitApp']
      :*/
      'Exit App';
  static String
      askExit = /*appStrings.isNotEmpty
      ? appStrings['askExit']
      :*/
      'Do you want to exit this app?';
  static String no = /*appStrings.isNotEmpty
      ? appStrings['no']
      : */
      'No';
  static String
      yes = /* appStrings.isNotEmpty
      ? appStrings['yes']
      : */
      'Yes';

  ///<<<---------------------------- Men categories screen String ---------------------------->>>
  static String studs = appStrings.isNotEmpty ? appStrings['studs'] : 'Studs';
  static String braceletsText =
      appStrings.isNotEmpty ? appStrings['braceletsText'] : 'Bracelets';
  static String kada = appStrings.isNotEmpty ? appStrings['kada'] : 'Kada';
  static String allDesigns =
      appStrings.isNotEmpty ? appStrings['allDesigns'] : 'All Designs';
  static String shopPrice =
      appStrings.isNotEmpty ? appStrings['shopPrice'] : 'Shop By Price';
  static String giftHim =
      appStrings.isNotEmpty ? appStrings['giftHim'] : 'Gifts For Him';
  static String milestoneGifts =
      appStrings.isNotEmpty ? appStrings['milestoneGifts'] : 'Milestone Gifts';
  static String shopMaterial =
      appStrings.isNotEmpty ? appStrings['shopMaterial'] : 'Shop By Material';
  static String aboveMenFirstPrice =
      appStrings.isNotEmpty ? appStrings['aboveMenFirstPrice'] : 'Under ₹30k';
  static String aboveMenSecondPrice =
      appStrings.isNotEmpty ? appStrings['aboveMenSecondPrice'] : '₹30 - ₹50k';
  static String aboveMenThirdPrice =
      appStrings.isNotEmpty ? appStrings['aboveMenThirdPrice'] : '₹50k & Above';
  static String menPlatinum =
      appStrings.isNotEmpty ? appStrings['menPlatinum'] : 'Platinum';
  static String menGold =
      appStrings.isNotEmpty ? appStrings['menGold'] : 'Gold';
  static String menDiamond =
      appStrings.isNotEmpty ? appStrings['menDiamond'] : 'Diamond';

  ///<<<---------------------------- Wishlist screen String ---------------------------->>>
  static String wishlist =
      appStrings.isNotEmpty ? appStrings['wishlist'] : 'Wishlist';
  static String wishlistEmpty = appStrings.isNotEmpty
      ? appStrings['wishlistEmpty']
      : 'Your wishlist is empty. Add some products to your wishlist and come back later!';
  static String moveCart =
      appStrings.isNotEmpty ? appStrings['moveCart'] : 'Move to Cart';
  static String wishlistPriceFirst =
      appStrings.isNotEmpty ? appStrings['wishlistPriceFirst'] : '₹50,000';
  static String wishlistPriceSecond =
      appStrings.isNotEmpty ? appStrings['wishlistPriceSecond'] : '₹30,657';
  static String wishlistPriceThird =
      appStrings.isNotEmpty ? appStrings['wishlistPriceThird'] : '₹40,000';
  static String wishlistPriceFor =
      appStrings.isNotEmpty ? appStrings['wishlistPriceFor'] : '₹70,589';
  static String wishlistPriceFive =
      appStrings.isNotEmpty ? appStrings['wishlistPriceFive'] : '₹80,000';
  static String wishlistPriceSix =
      appStrings.isNotEmpty ? appStrings['wishlistPriceSix'] : '₹30,999';
  static String wishlistPriceSeven =
      appStrings.isNotEmpty ? appStrings['wishlistPriceSeven'] : '₹40,789';
  static String wishlistPriceEight =
      appStrings.isNotEmpty ? appStrings['wishlistPriceEight'] : '₹50,999';

  ///<<<---------------------------- Collection screen String ---------------------------->>>
  static String sort = appStrings.isNotEmpty ? appStrings['sort'] : 'Sort';
  static String collectionEmpty = appStrings.isNotEmpty
      ? appStrings['collectionEmpty']
      : 'Looks like there are no products in this collection right now. Check back later or explore other collections!';
  static String filter =
      appStrings.isNotEmpty ? appStrings['filter'] : 'Filter';
  static String sortBy =
      appStrings.isNotEmpty ? appStrings['sortBy'] : 'Sort Designs By';
  static String latest =
      appStrings.isNotEmpty ? appStrings['latest'] : 'Latest';
  static String loginLikeItem = appStrings.isNotEmpty
      ? appStrings['loginLikeItem']
      : 'Please log in to like items!';

  static String featured =
      appStrings.isNotEmpty ? appStrings['featured'] : 'Featured';
  static String priceLow =
      appStrings.isNotEmpty ? appStrings['priceLow'] : 'Price: Low to High';
  static String priceHigh =
      appStrings.isNotEmpty ? appStrings['priceHigh'] : 'Price: High to Low';

  // static  String customerRating = 'Customer Rating';
  static String latestText =
      appStrings.isNotEmpty ? appStrings['latestText'] : 'LATEST';
  static String bestSeller =
      appStrings.isNotEmpty ? appStrings['bestSeller'] : 'BESTSELLER';
  static String blankText =
      appStrings.isNotEmpty ? appStrings['blankText'] : '';
  static String ratingFirst =
      appStrings.isNotEmpty ? appStrings['ratingFirst'] : '4.8';
  static String ratingSecond =
      appStrings.isNotEmpty ? appStrings['ratingSecond'] : '5.0';
  static String ratingThird =
      appStrings.isNotEmpty ? appStrings['ratingThird'] : '3.8';
  static String ratingFor =
      appStrings.isNotEmpty ? appStrings['ratingFor'] : '3.0';
  static String ratingFive =
      appStrings.isNotEmpty ? appStrings['ratingFive'] : '2.0';
  static String ratingSix =
      appStrings.isNotEmpty ? appStrings['ratingSix'] : '4.9';
  static String priceProductItemFirst =
      appStrings.isNotEmpty ? appStrings['priceProductItemFirst'] : '11,833';
  static String priceProductItemSecond =
      appStrings.isNotEmpty ? appStrings['priceProductItemSecond'] : '14,791';
  static String priceProductItemThird =
      appStrings.isNotEmpty ? appStrings['priceProductItemThird'] : '20,000';
  static String priceProductItemFor =
      appStrings.isNotEmpty ? appStrings['priceProductItemFor'] : '30,000';
  static String priceProductItemFive =
      appStrings.isNotEmpty ? appStrings['priceProductItemFive'] : '25,000';
  static String priceProductItemSix =
      appStrings.isNotEmpty ? appStrings['priceProductItemSix'] : '35,000';
  static String priceProductItemSeven =
      appStrings.isNotEmpty ? appStrings['priceProductItemSeven'] : '15,000';
  static String priceProductItemEight =
      appStrings.isNotEmpty ? appStrings['priceProductItemEight'] : '17,800';
  static String priceProductItemNine =
      appStrings.isNotEmpty ? appStrings['priceProductItemNine'] : '18,000';
  static String priceProductItemTen =
      appStrings.isNotEmpty ? appStrings['priceProductItemTen'] : '23,999';
  static String priceProductItemEleven =
      appStrings.isNotEmpty ? appStrings['priceProductItemEleven'] : '50,000';
  static String priceProductItemTwelve =
      appStrings.isNotEmpty ? appStrings['priceProductItemTwelve'] : '60,000';
  static String addToCart =
      appStrings.isNotEmpty ? appStrings['addToCart'] : 'ADD TO CART';
  static String goldenRing =
      appStrings.isNotEmpty ? appStrings['goldenRing'] : 'Golden Ring';
  static String diamondRingFirst =
      appStrings.isNotEmpty ? appStrings['diamondRingFirst'] : 'Diamond Ring';
  static String diamondRingSecond =
      appStrings.isNotEmpty ? appStrings['diamondRingSecond'] : 'Diamond Ring';
  static String stoneRing =
      appStrings.isNotEmpty ? appStrings['stoneRing'] : 'Stone Ring';
  static String stoneDiamondRing = appStrings.isNotEmpty
      ? appStrings['stoneDiamondRing']
      : 'Stone & Diamond Ring';

  ///<<<---------------------------- Collection filter screen String ---------------------------->>>
  static String filters =
      appStrings.isNotEmpty ? appStrings['filters'] : 'Filters';
  static String price = appStrings.isNotEmpty ? appStrings['price'] : 'Price';
  static String productsType =
      appStrings.isNotEmpty ? appStrings['productsType'] : 'Product Type';

  // static  String weightRanges = 'Weight Ranges';
  static String material =
      appStrings.isNotEmpty ? appStrings['material'] : 'Material';

  // static  String metal = 'Metal';
  static String shopFor =
      appStrings.isNotEmpty ? appStrings['shopFor'] : 'Shop For';
  static String occasion =
      appStrings.isNotEmpty ? appStrings['occasion'] : 'Occasion';
  static String gemstone =
      appStrings.isNotEmpty ? appStrings['gemstone'] : 'Gemstone';
  static String gifts = appStrings.isNotEmpty ? appStrings['gifts'] : 'Gifts';
  static String theme = appStrings.isNotEmpty ? appStrings['theme'] : 'Theme';
  static String seeFilter =
      appStrings.isNotEmpty ? appStrings['seeFilter'] : 'See More Filter';
  static String stoneSize =
      appStrings.isNotEmpty ? appStrings['stoneSize'] : 'Center Stone Size';
  static String fastDelivery =
      appStrings.isNotEmpty ? appStrings['fastDelivery'] : 'Fast Delivery';
  static String mangalsutraStyle = appStrings.isNotEmpty
      ? appStrings['mangalsutraStyle']
      : 'Mangalsutra Style';
  static String engravable =
      appStrings.isNotEmpty ? appStrings['engravable'] : 'Engravable';
  static String clearAll =
      appStrings.isNotEmpty ? appStrings['clearAll'] : 'CLEAR ALL';
  static String applyFilters =
      appStrings.isNotEmpty ? appStrings['applyFilters'] : 'APPLY FILTERS';

  ///<<<---------------------------- Product screen String ---------------------------->>>
  static String search =
      appStrings.isNotEmpty ? appStrings['search'] : 'Search products...';
  static String priceInclusive = appStrings.isNotEmpty
      ? appStrings['priceInclusive']
      : 'Price inclusive of taxes. See the full';
  static String priceBreakup =
      appStrings.isNotEmpty ? appStrings['priceBreakup'] : 'price breakup';
  static String specialOffer = appStrings.isNotEmpty
      ? appStrings['specialOffer']
      : 'Special offer for you';
  static String getOfferId =
      appStrings.isNotEmpty ? appStrings['getOfferId'] : 'Get if for 57586  ';
  static String useJb =
      appStrings.isNotEmpty ? appStrings['useJb'] : 'Use JB10';
  static String apply = appStrings.isNotEmpty ? appStrings['apply'] : 'Apply';
  static String sizeWithoutDots =
      /*appStrings.isNotEmpty ? appStrings['sizeWithoutDots'] :*/ 'Size';
  static String color = appStrings.isNotEmpty ? appStrings['color'] : 'COLOR';
  static String purity =
      appStrings.isNotEmpty ? appStrings['purity'] : 'PURITY';
  static String ktFirst =
      appStrings.isNotEmpty ? appStrings['ktFirst'] : '14Kt';
  static String ktSecond =
      appStrings.isNotEmpty ? appStrings['ktSecond'] : '18Kt';
  static String makingCharg =
      appStrings.isNotEmpty ? appStrings['makingCharg'] : 'Making Charg';
  static String chargFirst =
      appStrings.isNotEmpty ? appStrings['chargFirst'] : 'Rs.10500/-';
  static String sizeInches = appStrings.isNotEmpty
      ? appStrings['sizeInches']
      : 'Size 6.5 inches (customisable)';
  static String deliveryCancellation = appStrings.isNotEmpty
      ? appStrings['deliveryCancellation']
      : 'DELIVERY & CANCELLATION';
  static String estimatedTime = appStrings.isNotEmpty
      ? appStrings['estimatedTime']
      : 'ESTIMATED DELIVERY BY 27TH AUG 2024';
  static String yourPincode =
      appStrings.isNotEmpty ? appStrings['yourPincode'] : 'Your pincode';
  static String categoriesTitle =
      appStrings.isNotEmpty ? appStrings['categoriesTitle'] : 'CATEGORIES: ';
  static String categoriesItems = appStrings.isNotEmpty
      ? appStrings['categoriesItems']
      : 'Bracelet, Everyday, Mangalsutra Bracelet';
  static String tag = appStrings.isNotEmpty ? appStrings['tag'] : 'TAG: ';
  static String workwear =
      appStrings.isNotEmpty ? appStrings['workwear'] : 'Workwear';
  static String shareOn =
      appStrings.isNotEmpty ? appStrings['shareOn'] : 'Share On: ';
  static String chatUs =
      appStrings.isNotEmpty ? appStrings['chatUs'] : 'CHAT WITH US';
  static String roseGold =
      appStrings.isNotEmpty ? appStrings['roseGold'] : 'Rose Gold';
  static String whiteGold =
      appStrings.isNotEmpty ? appStrings['whiteGold'] : 'White Gold';
  static String yellowGold =
      appStrings.isNotEmpty ? appStrings['yellowGold'] : 'Yellow Gold';
  static String productDetails =
      appStrings.isNotEmpty ? appStrings['productDetails'] : 'PRODUCT DETAILS';
  static String weight =
      appStrings.isNotEmpty ? appStrings['weight'] : 'Weight';
  static String gross =
      appStrings.isNotEmpty ? appStrings['gross'] : 'Gross(Product) - ';
  static String net =
      appStrings.isNotEmpty ? appStrings['net'] : 'NET(Gold) - ';
  static String purityText =
      appStrings.isNotEmpty ? appStrings['purityText'] : 'Purity';
  static String ktGold =
      appStrings.isNotEmpty ? appStrings['ktGold'] : 'Kt Yellow Gold';
  static String diamondGemstone = appStrings.isNotEmpty
      ? appStrings['diamondGemstone']
      : 'Diamond & Gemstones';
  static String weightCt =
      appStrings.isNotEmpty ? appStrings['weightCt'] : 'Weight 0.688Ct';
  static String diamondSecond =
      appStrings.isNotEmpty ? appStrings['diamondSecond'] : 'Diamond 25';
  static String unitWeight =
      /*appStrings.isNotEmpty ? appStrings['unitWeight'] :*/ 'Unit Weight';
  static String sizeGold =
      appStrings.isNotEmpty ? appStrings['sizeGold'] : '0.01 to 0.07';
  static String colorText =
      appStrings.isNotEmpty ? appStrings['colorText'] : 'Color';
  static String gh = appStrings.isNotEmpty ? appStrings['gh'] : 'GH';
  static String clarity =
      appStrings.isNotEmpty ? appStrings['clarity'] : 'Clarity';
  static String vs = appStrings.isNotEmpty ? appStrings['vs'] : 'vs';
  static String shape = appStrings.isNotEmpty ? appStrings['shape'] : 'Shape';
  static String round = appStrings.isNotEmpty ? appStrings['round'] : 'Round';
  static String noDiamonds =
      appStrings.isNotEmpty ? appStrings['noDiamonds'] : 'No. Of Diamonds';
  static String diamondSize =
      appStrings.isNotEmpty ? appStrings['diamondSize'] : '25';
  static String total =
      appStrings.isNotEmpty ? appStrings['total'] : 'Total Weight';
  static String wrightSize =
      appStrings.isNotEmpty ? appStrings['wrightSize'] : '0.688';
  static String priceBreakupUpper =
      appStrings.isNotEmpty ? appStrings['priceBreakupUpper'] : 'PRICE BREAKUP';
  static String goldText =
      appStrings.isNotEmpty ? appStrings['goldText'] : 'Gold';
  static String goldPrice =
      appStrings.isNotEmpty ? appStrings['goldPrice'] : 'Rs.29904/-';
  static String diamond =
      appStrings.isNotEmpty ? appStrings['diamond'] : 'Diamond';
  static String diamondPrice =
      appStrings.isNotEmpty ? appStrings['diamondPrice'] : 'Rs.17200/-';
  static String makingCharge =
      appStrings.isNotEmpty ? appStrings['makingCharge'] : 'Making Charge';
  static String chargeFirst =
      appStrings.isNotEmpty ? appStrings['chargeFirst'] : 'Rs.10500/-';
  static String gst = appStrings.isNotEmpty ? appStrings['gst'] : 'GST';
  static String gstPrice =
      appStrings.isNotEmpty ? appStrings['gstPrice'] : 'Rs.1728/-';
  static String totalText =
      appStrings.isNotEmpty ? appStrings['totalText'] : 'Total';
  static String totalPrice =
      appStrings.isNotEmpty ? appStrings['totalPrice'] : 'Rs.59332/-';
  static String estimatedPrice = appStrings.isNotEmpty
      ? appStrings['estimatedPrice']
      : 'This is an estimated price,actual price may differ as per actual weights.';
  static String ourPromise =
      appStrings.isNotEmpty ? appStrings['ourPromise'] : 'OUR PROMISE';
  static String certifiedPercent =
      appStrings.isNotEmpty ? appStrings['certifiedPercent'] : '100% Certified';
  static String returns =
      appStrings.isNotEmpty ? appStrings['returns'] : '30 Days Easy Returns';
  static String exchange = appStrings.isNotEmpty
      ? appStrings['exchange']
      : 'Lifetime Exchange & Buyback';
  static String warranty =
      appStrings.isNotEmpty ? appStrings['warranty'] : 'One Year Warranty';
  static String certifiedRecognised = appStrings.isNotEmpty
      ? appStrings['certifiedRecognised']
      : 'Certified By\nRecognised lab';
  static String certifiedSalt = appStrings.isNotEmpty
      ? appStrings['certifiedSalt']
      : '100% Certified\nby Salt';
  static String learnAbout = appStrings.isNotEmpty
      ? appStrings['learnAbout']
      : 'Learn more on about our ';
  static String termsPolicies =
      appStrings.isNotEmpty ? appStrings['termsPolicies'] : 'TERMS & POLICIES';
  static String hallmarked =
      appStrings.isNotEmpty ? appStrings['hallmarked'] : 'Hallmarked Gold';
  static String certified =
      appStrings.isNotEmpty ? appStrings['certified'] : 'Certified Jewellery';
  static String certificate = appStrings.isNotEmpty
      ? appStrings['certificate']
      : 'CERTIFICATE OF AUTHENTICITY';
  static String jewelleryCertified = appStrings.isNotEmpty
      ? appStrings['jewelleryCertified']
      : 'Every piece of jewellery that we make is certified for authenticity by third-party international laboratories like ';
  static String sgl = appStrings.isNotEmpty ? appStrings['sgl'] : 'SGL ';
  static String and = appStrings.isNotEmpty ? appStrings['and'] : 'and ';
  static String igl = appStrings.isNotEmpty ? appStrings['igl'] : 'IGL.';
  static String buyNow =
      appStrings.isNotEmpty ? appStrings['buyNow'] : 'BUY NOW';
  static String review =
      /*appStrings.isNotEmpty ? appStrings['review'] :*/ 'Reviews';
  static String clickReview =
      /*appStrings.isNotEmpty ? appStrings['clickReview'] :*/ 'Click to reviews';
  static String byDefaultRating =
      /*appStrings.isNotEmpty ? appStrings['byDefaultRating'] :*/ '0';
  static String firstRating =
      /*appStrings.isNotEmpty ? appStrings['firstRating'] :*/ '1';
  static String secondRating =
      /*appStrings.isNotEmpty ? appStrings['secondRating'] :*/ '2';
  static String thirdRating =
      /*appStrings.isNotEmpty ? appStrings['thirdRating'] :*/ '3';
  static String foreRating =
      /*appStrings.isNotEmpty ? appStrings['foreRating'] :*/ '4';
  static String fiveRating =
      /*appStrings.isNotEmpty ? appStrings['fiveRating'] :*/ '5';
  static String howItem =
      /*appStrings.isNotEmpty ? appStrings['howItem'] :*/ 'How do you like this item?';
  static String feedback =
      /*appStrings.isNotEmpty ? appStrings['feedback'] :*/ 'Feedback ';
  static String feedbackStar =
      /*appStrings.isNotEmpty ? appStrings['feedbackStar'] :*/ '*';
  static String addFiles =
      /*appStrings.isNotEmpty ? appStrings['addFiles'] :*/ 'Add files';
  static String acceptsImageFormat =
      /*appStrings.isNotEmpty ? appStrings['acceptsImageFormat'] :*/ 'Accepts .gif, .jpg, .png (Max 5MB per file)';
  static String next = /*appStrings.isNotEmpty ? appStrings['next'] :*/ 'Next';
  static String update = /*appStrings.isNotEmpty ? appStrings['update'] :*/
      'Update';
  static String invalidFile =
      /*appStrings.isNotEmpty ? appStrings['invalidFile'] :*/ 'Invalid file. Please select a .gif, .jpg, or .png file under 5MB.';
  static String noSelectedImage =
      /*appStrings.isNotEmpty ? appStrings['next'] :*/ 'No image selected.';
  static String selectImage =
      /*appStrings.isNotEmpty ? appStrings['selectImage'] :*/ 'Select Image';
  static String camera =
      /*appStrings.isNotEmpty ? appStrings['camera'] :*/ 'Camera';
  static String gallery =
      /*appStrings.isNotEmpty ? appStrings['gallery'] :*/ 'Gallery';
  static String name = /*appStrings.isNotEmpty ? appStrings['name'] :*/ 'Name';
  static String submit =
      /*appStrings.isNotEmpty ? appStrings['submit'] :*/ 'Submit';
  static String
      ratingLogin = /* appStrings.isNotEmpty
      ? appStrings['ratingLogin']
      :*/
      'You want to rat this product, please log in first.';
  static String
      selectRating = /* appStrings.isNotEmpty
      ? appStrings['selectRating']
      :*/
      'Please select star rating.';
  static String
      enterFeedback = /* appStrings.isNotEmpty
      ? appStrings['enterFeedback']
      :*/
      'Please enter feedback';
  static String
      adminApproval = /* appStrings.isNotEmpty
      ? appStrings['adminApproval']
      :*/
      'Waiting For Admin Approval Rating';
  static String
      ratingUpdated = /* appStrings.isNotEmpty
      ? appStrings['adminApproval']
      :*/
      'Rating updated successfully';

  ///<<<---------------------------- My Account screen String ---------------------------->>>
  static String welcome =
      appStrings.isNotEmpty ? appStrings['welcome'] : 'Welcome!';
  static String login = appStrings.isNotEmpty ? appStrings['login'] : 'LOGIN';
  static String loginDiscover = appStrings.isNotEmpty
      ? appStrings['loginDiscover']
      : 'Login to discover Exclusive points, offers & more';
  static String orders =
      appStrings.isNotEmpty ? appStrings['orders'] : 'Orders';
  static String viewStatus = appStrings.isNotEmpty
      ? appStrings['viewStatus']
      : 'To view the status of your order,please log in ';
  static String addCart =
      appStrings.isNotEmpty ? appStrings['addCart'] : 'Add to cart';
  static String viewCart =
      appStrings.isNotEmpty ? appStrings['viewCart'] : 'To view cart list';
  static String coins = appStrings.isNotEmpty ? appStrings['coins'] : 'Coins';
  static String comingSoon =
      appStrings.isNotEmpty ? appStrings['comingSoon'] : 'COMING SOON...';
  static String viewWishlist = appStrings.isNotEmpty
      ? appStrings['viewWishlist']
      : 'To view wishlist items';
  static String yourOffers =
      appStrings.isNotEmpty ? appStrings['yourOffers'] : 'Your Offers';
  static String viewOffers = appStrings.isNotEmpty
      ? appStrings['viewOffers']
      : 'To view your offers, ';
  static String faqs = appStrings.isNotEmpty ? appStrings['faqs'] : 'FAQs';
  static String shipping =
      appStrings.isNotEmpty ? appStrings['shipping'] : 'Shipping';
  static String warrantyAccount =
      /*appStrings.isNotEmpty ? appStrings['warrantyAccount'] :*/ 'Warranty';
  static String cancellation =
      /*appStrings.isNotEmpty ? appStrings['cancellation'] :*/ 'cancellation';
  static String shippingPolicy =
      /*appStrings.isNotEmpty ? appStrings['shipping'] :*/ 'shippingPolicy';
  static String exchangeText =
      appStrings.isNotEmpty ? appStrings['exchangeText'] : 'Exchange';
  static String returnText =
      appStrings.isNotEmpty ? appStrings['returnText'] : 'Return';
  static String repair =
      appStrings.isNotEmpty ? appStrings['repair'] : 'Repair';
  static String rateUs =
      appStrings.isNotEmpty ? appStrings['rateUs'] : 'Rate Us';
  static String shareApp =
      appStrings.isNotEmpty ? appStrings['shareApp'] : 'Share App';
  static String sendFeedback =
      appStrings.isNotEmpty ? appStrings['sendFeedback'] : 'Send Feedback';
  static String termsUse =
      appStrings.isNotEmpty ? appStrings['termsUse'] : 'Terms of Use';
  static String callUs =
      appStrings.isNotEmpty ? appStrings['callUs'] : 'Call Us';
  static String appVersion =
      appStrings.isNotEmpty ? appStrings['appVersion'] : 'APP VERSION';
  static String hi = appStrings.isNotEmpty ? appStrings['hi'] : 'Hi';
  static String completeProfile = appStrings.isNotEmpty
      ? appStrings['completeProfile']
      : 'Complete your profile and get 250 Exclusive points';
  static String completePercentage =
      appStrings.isNotEmpty ? appStrings['completePercentage'] : '60%';
  static String complete =
      appStrings.isNotEmpty ? appStrings['complete'] : 'COMPLETE';
  static String viewAll =
      appStrings.isNotEmpty ? appStrings['viewAll'] : 'VIEW ALL';
  static String offFirst =
      appStrings.isNotEmpty ? appStrings['offFirst'] : '5% OFF';
  static String buyProducts = appStrings.isNotEmpty
      ? appStrings['buyProducts']
      : 'Buy 2 or more Shaya products, get free';
  static String referralCodeFirst =
      appStrings.isNotEmpty ? appStrings['referralCodeFirst'] : 'SHAYASPL5';
  static String validDateOffer = appStrings.isNotEmpty
      ? appStrings['validDateOffer']
      : 'Valid until August 09 2024';
  static String flatProducts = appStrings.isNotEmpty
      ? appStrings['flatProducts']
      : 'Flat 5% Off on Solitaire Mount SKU';
  static String referralCodeSecond =
      appStrings.isNotEmpty ? appStrings['referralCodeSecond'] : 'MOUNT5';
  static String logout =
      appStrings.isNotEmpty ? appStrings['logout'] : 'LOGOUT';
  static String logoutDialogText =
      appStrings.isNotEmpty ? appStrings['logoutDialogText'] : 'Log Out';
  static String cancel =
      appStrings.isNotEmpty ? appStrings['cancel'] : 'Cancel';
  static String askLogout = appStrings.isNotEmpty
      ? appStrings['askLogout']
      : 'Are you sure you want to log out? You will need to log in again to continue.';

  ///<<<---------------------------- Login Screen screen String ---------------------------->>>
  static String welcomeBack =
      appStrings.isNotEmpty ? appStrings['welcomeBack'] : 'Welcome back!';
  static String loginUnlock = appStrings.isNotEmpty
      ? appStrings['loginUnlock']
      : 'Login to unlock best prices and become an insider for our exclusive launches offers.';

  // static  String enterNumber = 'Enter Mobile Number or Email';
  static String continueLogin =
      appStrings.isNotEmpty ? appStrings['continueLogin'] : 'CONTINUE TO LOGIN';
  static String orText = appStrings.isNotEmpty ? appStrings['orText'] : 'OR';
  static String loginWhatsapp = appStrings.isNotEmpty
      ? appStrings['loginWhatsapp']
      : 'LOGIN WITH WHATSAPP';
  static String newSaltAndGlitz = appStrings.isNotEmpty
      ? appStrings['newSaltAndGlitz']
      : 'New to Salt and Glitz?  ';
  static String createAccount =
      appStrings.isNotEmpty ? appStrings['createAccount'] : 'Create Account';
  static String continuingAgree = appStrings.isNotEmpty
      ? appStrings['continuingAgree']
      : 'By continuing you agree to Salt and Glitz ';
  static String termsConditions = appStrings.isNotEmpty
      ? appStrings['termsConditions']
      : 'Terms and Conditions';
  static String andText = appStrings.isNotEmpty ? appStrings['andText'] : ' & ';
  static String privacyPolicy =
      appStrings.isNotEmpty ? appStrings['privacyPolicy'] : 'Privacy Policy';

  ///<<<---------------------------- Create Account Screen screen String ---------------------------->>>
  static String signupWhatsapp = appStrings.isNotEmpty
      ? appStrings['signupWhatsapp']
      : 'SIGNUP WITH WHATSAPP';
  static String mobile =
      appStrings.isNotEmpty ? appStrings['mobile'] : 'Mobile';
  static String enterEmail =
      appStrings.isNotEmpty ? appStrings['enterEmail'] : 'Enter Email';
  static String firstName =
      appStrings.isNotEmpty ? appStrings['firstName'] : 'First Name';
  static String lastName =
      appStrings.isNotEmpty ? appStrings['lastName'] : 'Last Name';
  static String password =
      appStrings.isNotEmpty ? appStrings['password'] : 'Password';
  static String chars = appStrings.isNotEmpty ? appStrings['chars'] : '8 Chrs';
  static String uppercase =
      appStrings.isNotEmpty ? appStrings['uppercase'] : '1 Uppercase';
  static String lowercase =
      appStrings.isNotEmpty ? appStrings['lowercase'] : '1 Lowercase';
  static String symbol =
      appStrings.isNotEmpty ? appStrings['symbol'] : '1 Symbol';
  static String number =
      appStrings.isNotEmpty ? appStrings['number'] : '1 Number';
  static String confirmPassword = appStrings.isNotEmpty
      ? appStrings['confirmPassword']
      : 'Confirm Password';
  static String female =
      appStrings.isNotEmpty ? appStrings['female'] : 'Female';
  static String male = appStrings.isNotEmpty ? appStrings['male'] : 'Male';
  static String notSpecify = appStrings.isNotEmpty
      ? appStrings['notSpecify']
      : "i don't want to specify";
  static String optWhatsapp = appStrings.isNotEmpty
      ? appStrings['optWhatsapp']
      : 'Opt for whatsapp support';
  static String sharingDelivery = appStrings.isNotEmpty
      ? appStrings['sharingDelivery']
      : 'We will be sharing delivery & precious order related communication & certification.Also provide you with an interactive whatsapp support';
  static String signMe =
      appStrings.isNotEmpty ? appStrings['signMe'] : 'SIGN ME UP';
  static String alreadyAccount = appStrings.isNotEmpty
      ? appStrings['alreadyAccount']
      : 'Already have an account? ';
  static String loginLowercase =
      appStrings.isNotEmpty ? appStrings['loginLowercase'] : 'Login';
  static String enterMobileNumber = appStrings.isNotEmpty
      ? appStrings['enterMobileNumber']
      : 'Please enter mobile number';
  static String enterValidNumber = appStrings.isNotEmpty
      ? appStrings['enterValidNumber']
      : 'Please enter valid mobile number';
  static String enterEmailText = appStrings.isNotEmpty
      ? appStrings['enterEmailText']
      : 'Please enter email';
  static String enterValidEmail = appStrings.isNotEmpty
      ? appStrings['enterValidEmail']
      : 'Please enter valid email';
  static String enterFirstName = appStrings.isNotEmpty
      ? appStrings['enterFirstName']
      : 'Please enter First Name';
  static String enterLastName = appStrings.isNotEmpty
      ? appStrings['enterLastName']
      : 'Please enter Last Name';
  static String enterPassword = appStrings.isNotEmpty
      ? appStrings['enterPassword']
      : 'Please enter Password';
  static String validPassword = appStrings.isNotEmpty
      ? appStrings['validPassword']
      : 'Please enter valid Password';
  static String enterConfirmPassword = appStrings.isNotEmpty
      ? appStrings['enterConfirmPassword']
      : 'Please enter Confirm Password';
  static String validConfirmPassword = appStrings.isNotEmpty
      ? appStrings['validConfirmPassword']
      : 'Please enter Match Password';
  static String signupSuccessfully = appStrings.isNotEmpty
      ? appStrings['signupSuccessfully']
      : 'Signup Successfully!';
  static String loginSuccessfully = appStrings.isNotEmpty
      ? appStrings['loginSuccessfully']
      : 'Login Successfully!';

  ///<<<---------------------------- Edit profile Screen screen String ---------------------------->>>
  static String myAccount =
      appStrings.isNotEmpty ? appStrings['myAccount'] : 'My Account';
  static String editProfile =
      appStrings.isNotEmpty ? appStrings['editProfile'] : 'Edit Profile';
  static String specialOccasions = appStrings.isNotEmpty
      ? appStrings['specialOccasions']
      : 'Add more events to get exclusive & curated offers for your loved ones and special occasions';
  static String firstNameStar =
      appStrings.isNotEmpty ? appStrings['firstNameStar'] : 'First Name*';
  static String lastNameStar =
      appStrings.isNotEmpty ? appStrings['lastNameStar'] : 'Last Name*';
  static String mobileNumber =
      appStrings.isNotEmpty ? appStrings['mobileNumber'] : 'Mobile Number*';
  static String emailId =
      appStrings.isNotEmpty ? appStrings['emailId'] : 'Email ID*';
  static String verify =
      appStrings.isNotEmpty ? appStrings['verify'] : 'VERIFY';
  static String pinCode =
      appStrings.isNotEmpty ? appStrings['pinCode'] : 'PIN Code*';
  static String other = appStrings.isNotEmpty ? appStrings['other'] : 'Other';
  static String birthday =
      appStrings.isNotEmpty ? appStrings['birthday'] : 'Birthday (Optional)';
  static String anniversary = appStrings.isNotEmpty
      ? appStrings['anniversary']
      : 'Anniversary (Optional)';
  static String occupation = appStrings.isNotEmpty
      ? appStrings['occupation']
      : 'Occupation (Optional)';
  static String spousBirthday = appStrings.isNotEmpty
      ? appStrings['spousBirthday']
      : 'Spous Birthda y (Optional)';
  static String addMore =
      appStrings.isNotEmpty ? appStrings['addMore'] : '+ ADD MORE EVENTS';
  static String byClicking = appStrings.isNotEmpty
      ? appStrings['byClicking']
      : '*By clicking on Save Changes, you accept our ';
  static String tAndC = appStrings.isNotEmpty ? appStrings['tAndC'] : 'T&C';
  static String saveChanges =
      appStrings.isNotEmpty ? appStrings['saveChanges'] : 'SAVE CHANGES';
  static String enterOtp = appStrings.isNotEmpty
      ? appStrings['enterOtp']
      : 'Enter OTP sent to your Email & verify account';
  static String resend =
      appStrings.isNotEmpty ? appStrings['resend'] : 'RESEND IN ';
  static String resendText =
      appStrings.isNotEmpty ? appStrings['resendText'] : 'RESEND';
  static String secs = appStrings.isNotEmpty ? appStrings['secs'] : 'SECS';
  static String otpSent =
      appStrings.isNotEmpty ? appStrings['otpSent'] : 'OTP sent successfully';
  static String selectOccupation = appStrings.isNotEmpty
      ? appStrings['selectOccupation']
      : 'Select Occupation';
  static String engineer =
      appStrings.isNotEmpty ? appStrings['engineer'] : 'Engineer';
  static String consultant =
      appStrings.isNotEmpty ? appStrings['consultant'] : 'Consultant';
  static String charted =
      appStrings.isNotEmpty ? appStrings['charted'] : 'Chartered Accountant';
  static String marketing =
      appStrings.isNotEmpty ? appStrings['marketing'] : 'Marketing/Sales';
  static String teacher =
      appStrings.isNotEmpty ? appStrings['teacher'] : 'Teacher';
  static String entrepreneur =
      appStrings.isNotEmpty ? appStrings['entrepreneur'] : 'Entrepreneur';
  static String designer =
      appStrings.isNotEmpty ? appStrings['designer'] : 'Designer';
  static String homemaker =
      appStrings.isNotEmpty ? appStrings['homemaker'] : 'Homemaker';
  static String itProfessional =
      appStrings.isNotEmpty ? appStrings['itProfessional'] : 'IT Professional';
  static String others =
      appStrings.isNotEmpty ? appStrings['others'] : 'Others';
  static String doctor =
      appStrings.isNotEmpty ? appStrings['doctor'] : 'Doctor';
  static String lawyer =
      appStrings.isNotEmpty ? appStrings['lawyer'] : 'Lawyer';
  static String designerStylist = appStrings.isNotEmpty
      ? appStrings['designerStylist']
      : 'Designer/ Stylist';
  static String influencer =
      appStrings.isNotEmpty ? appStrings['influencer'] : 'Influencer';
  static String enterPinCode = appStrings.isNotEmpty
      ? appStrings['enterPinCode']
      : 'Please enter pin code';
  static String selectGender = appStrings.isNotEmpty
      ? appStrings['selectGender']
      : 'Please select your gender';
  static String enterBirthday = appStrings.isNotEmpty
      ? appStrings['enterBirthday']
      : 'Please enter birthday';
  static String saveChangesMessage = appStrings.isNotEmpty
      ? appStrings['saveChangesMessage']
      : 'Successfully save changes';

  ///<<<---------------------------- Add to Cart screen String ---------------------------->>>
  static String addToCartEmpty = appStrings.isNotEmpty
      ? appStrings['addToCartEmpty']
      : 'Your cart is looking a little empty. Fill it up with your favorite items and enjoy a shopping spree!';
  static String pleaseLogin = appStrings.isNotEmpty
      ? appStrings['pleaseLogin']
      : 'To place your order, please log in first.';

  ///<<<---------------------------- SetPassword screen String ---------------------------->>>
  static String passwordToLogin = appStrings.isNotEmpty
      ? appStrings['passwordToLogin']
      : 'Enter Password to login';
  static String xyzGmail =
      appStrings.isNotEmpty ? appStrings['xyzGmail'] : 'xyz@gmail.com';
  static String changeEmail =
      appStrings.isNotEmpty ? appStrings['changeEmail'] : 'Change Email';
  static String phoneNumber =
      appStrings.isNotEmpty ? appStrings['phoneNumber'] : '+91 *****67890';
  static String logIn = appStrings.isNotEmpty ? appStrings['logIn'] : 'Log In';
  static String forgotPassword =
      appStrings.isNotEmpty ? appStrings['forgotPassword'] : 'Forgot Password?';
  static String getOTP =
      appStrings.isNotEmpty ? appStrings['getOTP'] : 'GET OTP ON YOUR EMAIL';

  ///<<<---------------------------- SetOTP screen String ---------------------------->>>
  static String enterOTP =
      appStrings.isNotEmpty ? appStrings['enterOTP'] : 'Enter OTP';
  static String logInWithPassword = appStrings.isNotEmpty
      ? appStrings['logInWithPassword']
      : 'LOGIN WITH PASSWORD';
  static String resendOTP =
      appStrings.isNotEmpty ? appStrings['resendOTP'] : 'RESEND OTP';
  static String reset = appStrings.isNotEmpty ? appStrings['reset'] : 'RESET';

  ///<<<---------------------------- ResetPassword screen String ---------------------------->>>
  static String checkYourEmail = appStrings.isNotEmpty
      ? appStrings['checkYourEmail']
      : 'Check your Email \n to reset your password';
  static String linkToResetPassword = appStrings.isNotEmpty
      ? appStrings['linkToResetPassword']
      : 'A link to reset your password has been \n sent to your email';
  static String continueToLogin = appStrings.isNotEmpty
      ? appStrings['continueToLogin']
      : 'CONTINUE TO LOGIN';
  static String ifNotArriveEmail = appStrings.isNotEmpty
      ? appStrings['ifNotArriveEmail']
      : 'If it doesn’t arrive soon, check your spam folder or ';
  static String sendEmailAgain = appStrings.isNotEmpty
      ? appStrings['sendEmailAgain']
      : 'Sent the email again';

  ///<<<---------------------------- Analysis log string ---------------------------->>>

  static String logGuestUser =
      appStrings.isNotEmpty ? appStrings['logGuestUser'] : 'Guest';

  ///<<<---------------------------- Analysis dashboard screen log string ---------------------------->>>
  static String logHomeView =
      appStrings.isNotEmpty ? appStrings['logHomeView'] : 'Home_View';
  static String logHomeBannerView = appStrings.isNotEmpty
      ? appStrings['logHomeBannerView']
      : 'Home_Banner_Products_View';
  static String logHomeSolitaireView = appStrings.isNotEmpty
      ? appStrings['logHomeSolitaireView']
      : 'Home_Solitaire_Products_View';
  static String logHomeGiftView = appStrings.isNotEmpty
      ? appStrings['logHomeGiftView']
      : 'Home_Gifts_Products_View';
  static String logHomeRecentProductView = appStrings.isNotEmpty
      ? appStrings['logHomeRecentProductView']
      : 'Recent_Products_View';

  ///<<<---------------------------- Analysis categories screen log string ---------------------------->>>
  static String logCategories =
      appStrings.isNotEmpty ? appStrings['logCategories'] : 'Categories_View';
  static String logCategoriesWomenView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenView']
      : 'Categories_Women_View';
  static String logCategoriesMenView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenView']
      : 'Categories_Men_View';

  ///<<<---------------------------- Analysis women categories screen log string ---------------------------->>>
  static String logCategoriesWomenShopStyleView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenShopStyleView']
      : 'Women_Shop_By_Style_View';
  static String logCategoriesWomenShopByPriceView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenShopByPriceView']
      : 'Women_Shop_By_Price_View';
  static String logCategoriesWomenMostBrowsedView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenMostBrowsedView']
      : 'Women_Most_Browsed_View';
  static String logCategoriesWomenSilverJewelleryView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenSilverJewelleryView']
      : 'Women_Silver_Wedding_Jewellery_View';
  static String logCategoriesWomenPostCardsView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenPostCardsView']
      : 'Women_PostCards_View';
  static String logCategoriesWomenClTvView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenClTvView']
      : 'Women_CL_TV_View';
  static String logCategoriesWomenPopView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenPopView']
      : 'Women_Pop_View';
  static String logCategoriesWomenGoldExchangeView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenGoldExchangeView']
      : 'Women_Gold_Exchange_Program_View';
  static String logCategoriesWomenDigitalGoldView = appStrings.isNotEmpty
      ? appStrings['logCategoriesWomenDigitalGoldView']
      : 'Women_Digital_Gold_View';

  ///<<<---------------------------- Analysis men categories screen log string ---------------------------->>>
  static String logCategoriesMenShopStyleView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenShopStyleView']
      : 'Men_Shop_By_Style_View';
  static String logCategoriesMenShopByPriceView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenShopByPriceView']
      : 'Men_Shop_By_Price_View';
  static String logCategoriesMenMostBrowsedView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenMostBrowsedView']
      : 'Men_Most_Browsed_View';
  static String logCategoriesMenSilverJewelleryView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenSilverJewelleryView']
      : 'Men_Silver_Wedding_Jewellery_View';
  static String logCategoriesMenPostCardsView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenPostCardsView']
      : 'Men_PostCards_View';
  static String logCategoriesMenClTvView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenClTvView']
      : 'Men_CL_TV_View';
  static String logCategoriesMenPopView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenPopView']
      : 'Men_Pop_View';
  static String logCategoriesMenGoldExchangeView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenGoldExchangeView']
      : 'Men_Gold_Exchange_Program_View';
  static String logCategoriesMenDigitalGoldView = appStrings.isNotEmpty
      ? appStrings['logCategoriesMenDigitalGoldView']
      : 'Men_Digital_Gold_View';

  ///<<<---------------------------- Analysis collections screen log string ---------------------------->>>
  static String logCollectionView = appStrings.isNotEmpty
      ? appStrings['logCollectionView']
      : 'Collection_Products_View';
  static String logCollectionProductFavorite = appStrings.isNotEmpty
      ? appStrings['logCollectionProductFavorite']
      : 'Product_Favorite_Click';
  static String logCollectionProductUnFavorite = appStrings.isNotEmpty
      ? appStrings['logCollectionProductUnFavorite']
      : 'Product_UnFavorite_Click';
  static String logCollectionInquiryCall = appStrings.isNotEmpty
      ? appStrings['logCollectionInquiryCall']
      : 'Inquiry_Call_Click';
  static String logCollectionSortProduct = appStrings.isNotEmpty
      ? appStrings['logCollectionSortProduct']
      : 'Sort_Products_Click';
  static String logCollectionAddCart = appStrings.isNotEmpty
      ? appStrings['logCollectionAddCart']
      : 'Product_Add_Cart_Click';

  ///<<<---------------------------- Analysis wishlist screen log string ---------------------------->>>
  static String logWishList =
      appStrings.isNotEmpty ? appStrings['logWishList'] : 'Wishlist_View';
  static String logWishListWhatsappClick = appStrings.isNotEmpty
      ? appStrings['logWishListWhatsappClick']
      : 'Wishlist_Whatsapp_Click';
  static String logWishListCallClick = appStrings.isNotEmpty
      ? appStrings['logWishListCallClick']
      : 'Wishlist_Call_Click';
  static String logWishListChatClick = appStrings.isNotEmpty
      ? appStrings['logWishListChatClick']
      : 'Wishlist_Chat_Click';
  static String logWishListRemoveProduct = appStrings.isNotEmpty
      ? appStrings['logWishListRemoveProduct']
      : 'Wishlist_Remove_Product';
  static String logWishListMoveCartProduct = appStrings.isNotEmpty
      ? appStrings['logWishListMoveCartProduct']
      : 'Wishlist_Move_Cart_Product';
  static String logWishListShareProduct = appStrings.isNotEmpty
      ? appStrings['logWishListShareProduct']
      : 'Wishlist_Share_Product';

  ///<<<---------------------------- Analysis collection filter screen log string ---------------------------->>>
  static String logCollectionFilterView = appStrings.isNotEmpty
      ? appStrings['logCollectionFilterView']
      : 'Collection_Filter_View';
  static String logCollectionClearAllFilter = appStrings.isNotEmpty
      ? appStrings['logCollectionClearAllFilter']
      : 'Clear_All_Filter';
  static String logCollectionProductFilter = appStrings.isNotEmpty
      ? appStrings['logCollectionProductFilter']
      : 'Product_Filter';

  ///<<<---------------------------- Analysis product screen log string ---------------------------->>>
  static String logProductDetailView = appStrings.isNotEmpty
      ? appStrings['logProductDetailView']
      : 'Product_Detail_View';
  static String logProductSearch = appStrings.isNotEmpty
      ? appStrings['logCollectionProductFilter']
      : 'Search_Product';
  static String logProductAngleView = appStrings.isNotEmpty
      ? appStrings['logProductAngleView']
      : 'Product_Angle_View';
  static String logProductFavoriteClick = appStrings.isNotEmpty
      ? appStrings['logProductFavoriteClick']
      : 'Product_Favorite_Click';
  static String logProductUnFavoriteClick = appStrings.isNotEmpty
      ? appStrings['logProductUnFavoriteClick']
      : 'Product_UnFavorite_Click';
  static String logProductPriceBreakupClick = appStrings.isNotEmpty
      ? appStrings['logProductPriceBreakupClick']
      : 'Product_Price_Breakup_View_Click';
  static String logProductSpecialOfferClick = appStrings.isNotEmpty
      ? appStrings['logProductSpecialOfferClick']
      : 'Product_Special_Offer_View_Click';
  static String logProductCouponCodeApplyClick = appStrings.isNotEmpty
      ? appStrings['logProductCouponCodeApplyClick']
      : 'Product_Coupon_Code_Apply_Click';
  static String logProductProductTypeSelection = appStrings.isNotEmpty
      ? appStrings['logProductProductTypeSelection']
      : 'Product_Type_Selection';
  static String logProductSliver =
      appStrings.isNotEmpty ? appStrings['logProductSliver'] : 'Silver';
  static String logProductGold =
      appStrings.isNotEmpty ? appStrings['logProductGold'] : 'Gold';
  static String logProductDeliveryCancellationClick = appStrings.isNotEmpty
      ? appStrings['logProductDeliveryCancellationClick']
      : 'Product_Delivery_Cancellation_Click';
  static String logProductFacebookShare = appStrings.isNotEmpty
      ? appStrings['logProductFacebookShare']
      : 'Product_Facebook_Share';
  static String logProductWhatsappShare = appStrings.isNotEmpty
      ? appStrings['logProductWhatsappShare']
      : 'Product_Whatsapp_Share';
  static String logProductTelegramShare = appStrings.isNotEmpty
      ? appStrings['logProductTelegramShare']
      : 'Product_Telegram_Share';
  static String logProductClipboardCopy = appStrings.isNotEmpty
      ? appStrings['logProductClipboardCopy']
      : 'Product_Clipboard_Copy';
  static String logProductChatWithUs = appStrings.isNotEmpty
      ? appStrings['logProductChatWithUs']
      : 'Product_Chat_With_Us_Click';

  ///<<<---------------------------- Analysis add cart screen log string ---------------------------->>>
  static String logAddCartView =
      appStrings.isNotEmpty ? appStrings['logAddCartView'] : 'Add_To_Cart_View';
  static String logAddCartWhatsappClick = appStrings.isNotEmpty
      ? appStrings['logAddCartWhatsappClick']
      : 'Add_To_Cart_Whatsapp_Click';
  static String logAddCartMoveWishlistProductClick = appStrings.isNotEmpty
      ? appStrings['logAddCartMoveWishlistProductClick']
      : 'Add_To_Cart_Move_Wishlist_Product_Click';
  static String logAddCartReMoveProductClick = appStrings.isNotEmpty
      ? appStrings['logAddCartReMoveProductClick']
      : 'Add_To_Cart_RemoveMove_Product_Click';
  static String logAddCartApplyCouponClick = appStrings.isNotEmpty
      ? appStrings['logAddCartApplyCouponClick']
      : 'Add_To_Cart_Apply_Coupon_Click';
  static String logAddCartCallClick = appStrings.isNotEmpty
      ? appStrings['logAddCartCallClick']
      : 'Add_To_Cart_Call_Click';
  static String logAddCartChatClick = appStrings.isNotEmpty
      ? appStrings['logAddCartChatClick']
      : 'Add_To_Cart_Chat_Click';
  static String logAddCartPlaceOrderClick = appStrings.isNotEmpty
      ? appStrings['logAddCartPlaceOrderClick']
      : 'Add_To_Cart_Place_Order_Click';

  ///<<<---------------------------- Analysis my account screen log string ---------------------------->>>
  static String logMyAccountView = appStrings.isNotEmpty
      ? appStrings['logMyAccountView']
      : 'My_Account_View';
  static String logMyAccountLoginClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountLoginClick']
      : 'My_Account_Login_Button_Click';
  static String logMyAccountLogoutClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountLogoutClick']
      : 'My_Account_Logout_Button_Click';
  static String logMyAccountLogoutFacebookClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountLogoutFacebookClick']
      : 'My_Account_Logout_Facebook_Button_Click';
  static String logMyAccountLogoutGoogleClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountLogoutGoogleClick']
      : 'My_Account_Logout_Google_Button_Click';
  static String logMyAccountButtonClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountButtonClick']
      : 'Button_Click';
  static String logMyAccountOfferLoginClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountOfferLoginClick']
      : 'My_Account_Offers_Purpose_Login_Click';
  static String logMyAccountCallClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountCallClick']
      : 'My_Account_Call_Us_Button_Click';
  static String logMyAccountChatClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountChatClick']
      : 'My_Account_Chat_Button_Click';
  static String logMyAccountWhatsappClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountWhatsappClick']
      : 'My_Account_Whatsapp_Button_Click';
  static String logMyAccountEmailClick = appStrings.isNotEmpty
      ? appStrings['logMyAccountEmailClick']
      : 'My_Account_Email_Button_Click';
  static String logMyAccountCompleteProfile = appStrings.isNotEmpty
      ? appStrings['logMyAccountCompleteProfile']
      : 'My_Account_Complete_Profile_Click';
  static String logMyAccountViewAllOffer = appStrings.isNotEmpty
      ? appStrings['logMyAccountViewAllOffer']
      : 'My_Account_ViewAll_Offers_Click';
  static String logMyAccountReferralCodeCopy = appStrings.isNotEmpty
      ? appStrings['logMyAccountReferralCodeCopy']
      : 'Referral_Code_Copy';

  ///<<<---------------------------- Analysis login screen log string ---------------------------->>>
  static String logLogInView =
      appStrings.isNotEmpty ? appStrings['logLogInView'] : 'Log_In_View';
  static String logLogInButtonClick = appStrings.isNotEmpty
      ? appStrings['logLogInButtonClick']
      : 'Continue_Login_Button_Click';
  static String logLogInGoogleButtonClick = appStrings.isNotEmpty
      ? appStrings['logLogInGoogleButtonClick']
      : 'Login_Screen_Google_Login_Button_Click';
  static String logLogInFacebookButtonClick = appStrings.isNotEmpty
      ? appStrings['logLogInFacebookButtonClick']
      : 'Login_Screen_Facebook_Login_Button_Click';
  static String logLogInCreateAccountClick = appStrings.isNotEmpty
      ? appStrings['logLogInCreateAccountClick']
      : 'Login_Screen_Create_Account_Click';
  static String logLogInTermsView = appStrings.isNotEmpty
      ? appStrings['logLogInTermsView']
      : 'Login_Screen_Terms_Conditions_View';
  static String logLogInPrivacyPolicyView = appStrings.isNotEmpty
      ? appStrings['logLogInPrivacyPolicyView']
      : 'Login_Screen_Privacy_Policy_View';

  ///<<<---------------------------- Analysis create account screen log string ---------------------------->>>
  static String createNewAccountView = appStrings.isNotEmpty
      ? appStrings['createNewAccountView']
      : 'Create_New_Account_View';
  static String createNewAccountTermsView = appStrings.isNotEmpty
      ? appStrings['createNewAccountTermsView']
      : 'Create_New_Account_Terms_Conditions_View';
  static String createNewAccountPrivacyPolicyView = appStrings.isNotEmpty
      ? appStrings['createNewAccountPrivacyPolicyView']
      : 'Create_New_Account_Privacy_Policy_View';
  static String createNewAccountGoogleButtonClick = appStrings.isNotEmpty
      ? appStrings['createNewAccountGoogleButtonClick']
      : 'Create_New_Account_Google_Login_Button_Click';
  static String createNewAccountFacebookButtonClick = appStrings.isNotEmpty
      ? appStrings['createNewAccountFacebookButtonClick']
      : 'Create_New_Account_Facebook_Login_Button_Click';
  static String createNewAccountButtonClick = appStrings.isNotEmpty
      ? appStrings['createNewAccountButtonClick']
      : 'Create_New_Account_Button_Click';
  static String createNewAccountLoginClick = appStrings.isNotEmpty
      ? appStrings['createNewAccountLoginClick']
      : 'Create_New_Account_Login_View_Click';

  ///<<<---------------------------- Analysis create account screen log string ---------------------------->>>
  static String editProfileView = appStrings.isNotEmpty
      ? appStrings['editProfileView']
      : 'Edit_Profile_View';
  static String editProfileWhatsappClick = appStrings.isNotEmpty
      ? appStrings['editProfileWhatsappClick']
      : 'Edit_Profile_Whatsapp_Click';
  static String editProfileSaveChanges = appStrings.isNotEmpty
      ? appStrings['editProfileSaveChanges']
      : 'Edit_Profile_Save_Changes';
  static String editProfileVerifyEmail = appStrings.isNotEmpty
      ? appStrings['editProfileVerifyEmail']
      : 'Edit_Profile_Verify_Email_Click';
  static String editProfileAddEventClick = appStrings.isNotEmpty
      ? appStrings['editProfileAddEventClick']
      : 'Edit_Profile_Add_Events_Click';
  static String editProfileTermConditionView = appStrings.isNotEmpty
      ? appStrings['editProfileTermConditionView']
      : 'Edit_Profile_Term_Condition_View';
  static String editProfilePrivacyPolicyView = appStrings.isNotEmpty
      ? appStrings['editProfilePrivacyPolicyView']
      : 'Edit_Profile_Privacy_Policy_View';

  ///<<<---------------------------- Network connectivity screen log string ---------------------------->>>
  static String noDetectInternet = appStrings.isNotEmpty
      ? appStrings['noDetectInternet']
      : "Oops! You're offline.\nNo network detected! Make sure you're connected to the internet.";
  static String enableInternet = appStrings.isNotEmpty
      ? appStrings['enableInternet']
      : "No network detected!\nMake sure you're Enable internet";
  static String retry = appStrings.isNotEmpty ? appStrings['retry'] : "Retry";

  ///<<<---------------------------- Place Order screen string ---------------------------->>>
  static String deliveryDetails = appStrings.isNotEmpty
      ? appStrings['deliveryDetails']
      : "Delivery Details";
  static String shippingAddress = appStrings.isNotEmpty
      ? appStrings['shippingAddress']
      : "Shipping Address";
  static String billingAddress =
      appStrings.isNotEmpty ? appStrings['billingAddress'] : "Billing Address";
  static String continuePlaceOrder =
      appStrings.isNotEmpty ? appStrings['continuePlaceOrder'] : "continue";
  static String orderSummary =
      appStrings.isNotEmpty ? appStrings['orderSummary'] : "Order Summary";
  static String earring =
      appStrings.isNotEmpty ? appStrings['earring'] : "Earring";
  static String earliestDelivery = appStrings.isNotEmpty
      ? appStrings['earliestDelivery']
      : "Earliest Delivery dates selected for your pincode";
  static String homeDelivery =
      appStrings.isNotEmpty ? appStrings['homeDelivery'] : "Home Delivery";
  static String changeYourDeliveryDate = appStrings.isNotEmpty
      ? appStrings['changeYourDeliveryDate']
      : "+ Change your delivery date";
  static String sku = appStrings.isNotEmpty ? appStrings['sku'] : "SKU : ";
  static String couponDiscount =
      appStrings.isNotEmpty ? appStrings['couponDiscount'] : "COUPON DISCOUNT";
  static String subTotal2 =
      appStrings.isNotEmpty ? appStrings['subTotal2'] : "SUBTOTAL";
  static String shippingCharges = appStrings.isNotEmpty
      ? appStrings['shippingCharges']
      : "SHIPPING CHARGES";
  static String totalCost =
      appStrings.isNotEmpty ? appStrings['totalCost'] : "TOTAL COST";
  static String needHelp2 =
      appStrings.isNotEmpty ? appStrings['needHelp2'] : "Need Help?";
  static String weAreAvailable = appStrings.isNotEmpty
      ? appStrings['weAreAvailable']
      : "We're available by phone +91 -44-66075200 (Toll Free) \n every day, 9 AM to 1 AM IST (Mon - Sun)";
  static String contactUs2 =
      appStrings.isNotEmpty ? appStrings['contactUs2'] : "Contact Us: ";
  static String contactNumber = appStrings.isNotEmpty
      ? appStrings['contactNumber']
      : "+91 -44-66075200 (Helpline) |";
  static String contactUsAt = appStrings.isNotEmpty
      ? appStrings['contactUsAt']
      : "contactus@saltandglitz.com";
  static String inStorePickUp =
      appStrings.isNotEmpty ? appStrings['inStorePickUp'] : "In-Store Pick Up";
  static String buyNowPickUp = appStrings.isNotEmpty
      ? appStrings['buyNowPickUp']
      : "Buy now, Pick up from our store at your convenience";
  static String addANewAddress = appStrings.isNotEmpty
      ? appStrings['addANewAddress']
      : "Add a New Address";
  static String sameAsShippingAddress = appStrings.isNotEmpty
      ? appStrings['sameAsShippingAddress']
      : "Same as Shipping Address";
  static String useADifferentBillingAddress = appStrings.isNotEmpty
      ? appStrings['useADifferentBillingAddress']
      : "Use a Different Billing Address";
  static String streetHouseNumber = appStrings.isNotEmpty
      ? appStrings['streetHouseNumber']
      : "Street & House Number";
  static String additionalInformation = appStrings.isNotEmpty
      ? appStrings['additionalInformation']
      : "Additional Information";
  static String city = appStrings.isNotEmpty ? appStrings['city'] : "City";
  static String state = appStrings.isNotEmpty ? appStrings['state'] : "State";
  static String country =
      appStrings.isNotEmpty ? appStrings['country'] : "Country";
  static String selectAddressType = appStrings.isNotEmpty
      ? appStrings['selectAddressType']
      : "Select Address Type";
  static String work = appStrings.isNotEmpty ? appStrings['work'] : "Work";
  static String save = appStrings.isNotEmpty ? appStrings['save'] : "Save";
  static String street =
      /*appStrings.isNotEmpty ? appStrings['street'] :*/ "Street : ";
  static String cityWithDots =
      /*appStrings.isNotEmpty ? appStrings['cityWithDots'] :*/ "City : ";
  static String stateWithDots =
      /*appStrings.isNotEmpty ? appStrings['stateWithDots'] :*/ "State : ";
  static String postalCode =
      /*appStrings.isNotEmpty ? appStrings['stateWithDots'] :*/ "PostalCode : ";
  static String countryWithDots =
      /*appStrings.isNotEmpty ? appStrings['countryWithDots'] :*/ "Country : ";

  ///<<<---------------------------- Gift screen log string ---------------------------->>>
  static String chooseAGiftWrap = appStrings.isNotEmpty
      ? appStrings['chooseAGiftWrap']
      : "Choose a Gift Wrap";
  static String warmHugs =
      appStrings.isNotEmpty ? appStrings['warmHugs'] : "Warm hugs";
  static String purpleAun =
      appStrings.isNotEmpty ? appStrings['purpleAun'] : "Purple aun";
  static String fairyTales =
      appStrings.isNotEmpty ? appStrings['fairyTales'] : "Fairy Tales";
  static String addAGiftMessage = appStrings.isNotEmpty
      ? appStrings['addAGiftMessage']
      : "Add a gift message";
  static String optional =
      appStrings.isNotEmpty ? appStrings['optional'] : "Optional";
  static String whoIsThisGiftFor = appStrings.isNotEmpty
      ? appStrings['whoIsThisGiftFor']
      : "Who is the gift for?";
  static String youCanWriteAPersonalNote = appStrings.isNotEmpty
      ? appStrings['youCanWriteAPersonalNote']
      : "You can write a personal note with this gift. We \n promise we'll send it to your loved one.";
  static String recipientsMobile = appStrings.isNotEmpty
      ? appStrings['recipientsMobile']
      : "Recipient's Mobile*";
  static String self = appStrings.isNotEmpty ? appStrings['self'] : "Self";
  static String friend =
      appStrings.isNotEmpty ? appStrings['friend'] : "Friend";
  static String family =
      appStrings.isNotEmpty ? appStrings['family'] : "Family";
  static String wife = appStrings.isNotEmpty ? appStrings['wife'] : "Wife";
  static String mother =
      appStrings.isNotEmpty ? appStrings['mother'] : "Mother";
  static String father =
      appStrings.isNotEmpty ? appStrings['father'] : "Father";
  static String brother =
      appStrings.isNotEmpty ? appStrings['brother'] : "Brother";
  static String sister =
      appStrings.isNotEmpty ? appStrings['sister'] : "Sister";
  static String processToPayment = appStrings.isNotEmpty
      ? appStrings['processToPayment']
      : "Process To Payment";

  ///<<<---------------------------- Payment screen log string ---------------------------->>>
  static String creditCard =
      appStrings.isNotEmpty ? appStrings['creditCard'] : "Credit Card";
  static String debitCard =
      appStrings.isNotEmpty ? appStrings['debitCard'] : "Debit Card";
  static String upi = appStrings.isNotEmpty ? appStrings['upi'] : "UPI";
  static String netBanking =
      appStrings.isNotEmpty ? appStrings['netBanking'] : "Net Banking";
  static String cashOnDelivery = appStrings.isNotEmpty
      ? appStrings['cashOnDelivery']
      : "COD : Cash On Delivery";
  static String saveAndPayViaCreditCard = appStrings.isNotEmpty
      ? appStrings['saveAndPayViaCreditCard']
      : "Save & Pay via Credit Card";
  static String saveAndPayViaDebitCard = appStrings.isNotEmpty
      ? appStrings['saveAndPayViaDebitCard']
      : "Save & Pay via Debit Card";
  static String paytmGooglePay = appStrings.isNotEmpty
      ? appStrings['paytmGooglePay']
      : appStrings.isNotEmpty
          ? appStrings['processToPayment']
          : "Paytm, Phonepe, Google Pay, & more";
  static String selectFromListOfBanks = appStrings.isNotEmpty
      ? appStrings['selectFromListOfBanks']
      : "Select from a List of Banks";
  static String cod = appStrings.isNotEmpty ? appStrings['cod'] : "COD";
  static String add = appStrings.isNotEmpty ? appStrings['add'] : "Add";
  static String payNow =
      appStrings.isNotEmpty ? appStrings['payNow'] : "PAY NOW";
  static String preferredPayment = appStrings.isNotEmpty
      ? appStrings['preferredPayment']
      : "Preferred Payment Options";
  static String giftCard =
      appStrings.isNotEmpty ? appStrings['giftCard'] : "Gift Card";
  static String haveAGiftCard =
      appStrings.isNotEmpty ? appStrings['haveAGiftCard'] : "Have a gift Card?";
  static String availableAdditionalDiscount = appStrings.isNotEmpty
      ? appStrings['availableAdditionalDiscount']
      : "Available Additional Discount with gift cards";
}

class AppFonts {
  static String fontFamily =
      appStrings.isNotEmpty ? appStrings['fontFamily'] : 'Segoe';
}
