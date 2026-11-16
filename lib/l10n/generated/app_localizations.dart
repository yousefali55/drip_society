import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @languageSwitchArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageSwitchArabic;

  /// No description provided for @languageSwitchEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageSwitchEnglish;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get navAboutUs;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get navProducts;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @navNavigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navNavigation;

  /// No description provided for @orderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get orderNow;

  /// No description provided for @exploreProducts.
  ///
  /// In en, this message translates to:
  /// **'Explore Products'**
  String get exploreProducts;

  /// No description provided for @discoverMore.
  ///
  /// In en, this message translates to:
  /// **'Discover More'**
  String get discoverMore;

  /// No description provided for @aboutEyebrow.
  ///
  /// In en, this message translates to:
  /// **'ABOUT US'**
  String get aboutEyebrow;

  /// No description provided for @aboutHeadline.
  ///
  /// In en, this message translates to:
  /// **'Brewing Experiences,\nNot Just Coffee.'**
  String get aboutHeadline;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'At Drip Society, we don\'t simply serve coffee. We create an experience that inspires focus, creativity, and meaningful conversations. Every cup is crafted with care using premium beans and exceptional brewing techniques.'**
  String get aboutDescription;

  /// No description provided for @featurePremiumBeans.
  ///
  /// In en, this message translates to:
  /// **'Premium Coffee Beans'**
  String get featurePremiumBeans;

  /// No description provided for @featureExpertCoffee.
  ///
  /// In en, this message translates to:
  /// **'Expertly Crafted Coffee'**
  String get featureExpertCoffee;

  /// No description provided for @featureFreshDaily.
  ///
  /// In en, this message translates to:
  /// **'Freshly Brewed Every Day'**
  String get featureFreshDaily;

  /// No description provided for @heroBeanTitle.
  ///
  /// In en, this message translates to:
  /// **'Every Bean'**
  String get heroBeanTitle;

  /// No description provided for @heroBeanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tells a Story'**
  String get heroBeanSubtitle;

  /// No description provided for @heroBeanDescription.
  ///
  /// In en, this message translates to:
  /// **'Carefully selected premium coffee beans, roasted to deliver rich flavor, unforgettable aroma, and moments worth savoring.'**
  String get heroBeanDescription;

  /// No description provided for @heroBrewTitle.
  ///
  /// In en, this message translates to:
  /// **'Brew the'**
  String get heroBrewTitle;

  /// No description provided for @heroBrewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Perfect Moment'**
  String get heroBrewSubtitle;

  /// No description provided for @heroBrewDescription.
  ///
  /// In en, this message translates to:
  /// **'Whether you\'re starting your morning or taking a well-earned break, every cup is crafted to inspire your day.'**
  String get heroBrewDescription;

  /// No description provided for @heroPureTitle.
  ///
  /// In en, this message translates to:
  /// **'Pure Coffee.'**
  String get heroPureTitle;

  /// No description provided for @heroPureSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pure Passion.'**
  String get heroPureSubtitle;

  /// No description provided for @heroPureDescription.
  ///
  /// In en, this message translates to:
  /// **'Experience authentic premium coffee made from the finest beans, created for people who appreciate exceptional quality.'**
  String get heroPureDescription;

  /// No description provided for @productsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'OUR PRODUCTS'**
  String get productsEyebrow;

  /// No description provided for @productsHeading.
  ///
  /// In en, this message translates to:
  /// **'Premium Coffee Collection'**
  String get productsHeading;

  /// No description provided for @productsDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover handcrafted premium coffee beans, carefully roasted to bring unforgettable flavor to every cup.'**
  String get productsDescription;

  /// No description provided for @noProducts.
  ///
  /// In en, this message translates to:
  /// **'No products are available right now.'**
  String get noProducts;

  /// No description provided for @unableLoadProducts.
  ///
  /// In en, this message translates to:
  /// **'Unable to load products'**
  String get unableLoadProducts;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @grams200.
  ///
  /// In en, this message translates to:
  /// **'200g'**
  String get grams200;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Cart'**
  String get cartTitle;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @cartEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Add some premium coffee to keep going.'**
  String get cartEmptyDescription;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

  /// No description provided for @emptyCartMessage.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get emptyCartMessage;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @deliveryInformation.
  ///
  /// In en, this message translates to:
  /// **'Delivery Information'**
  String get deliveryInformation;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @openingWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Opening WhatsApp...'**
  String get openingWhatsApp;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @whatsappOpened.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp opened with your order'**
  String get whatsappOpened;

  /// No description provided for @whatsappUnable.
  ///
  /// In en, this message translates to:
  /// **'Unable to open WhatsApp right now'**
  String get whatsappUnable;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @selectGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Select governorate'**
  String get selectGovernorate;

  /// No description provided for @searchGovernorates.
  ///
  /// In en, this message translates to:
  /// **'Search governorates'**
  String get searchGovernorates;

  /// No description provided for @selectGovernorateValidation.
  ///
  /// In en, this message translates to:
  /// **'Please select your governorate.'**
  String get selectGovernorateValidation;

  /// No description provided for @governorateCairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get governorateCairo;

  /// No description provided for @governorateGiza.
  ///
  /// In en, this message translates to:
  /// **'Giza'**
  String get governorateGiza;

  /// No description provided for @governorateAlexandria.
  ///
  /// In en, this message translates to:
  /// **'Alexandria'**
  String get governorateAlexandria;

  /// No description provided for @governorateDakahlia.
  ///
  /// In en, this message translates to:
  /// **'Dakahlia'**
  String get governorateDakahlia;

  /// No description provided for @governorateRedSea.
  ///
  /// In en, this message translates to:
  /// **'Red Sea'**
  String get governorateRedSea;

  /// No description provided for @governorateBeheira.
  ///
  /// In en, this message translates to:
  /// **'Beheira'**
  String get governorateBeheira;

  /// No description provided for @governorateFayoum.
  ///
  /// In en, this message translates to:
  /// **'Fayoum'**
  String get governorateFayoum;

  /// No description provided for @governorateGharbia.
  ///
  /// In en, this message translates to:
  /// **'Gharbia'**
  String get governorateGharbia;

  /// No description provided for @governorateIsmailia.
  ///
  /// In en, this message translates to:
  /// **'Ismailia'**
  String get governorateIsmailia;

  /// No description provided for @governorateMenofia.
  ///
  /// In en, this message translates to:
  /// **'Menofia'**
  String get governorateMenofia;

  /// No description provided for @governorateMinya.
  ///
  /// In en, this message translates to:
  /// **'Minya'**
  String get governorateMinya;

  /// No description provided for @governorateQalyubia.
  ///
  /// In en, this message translates to:
  /// **'Qalyubia'**
  String get governorateQalyubia;

  /// No description provided for @governorateNewValley.
  ///
  /// In en, this message translates to:
  /// **'New Valley'**
  String get governorateNewValley;

  /// No description provided for @governorateSuez.
  ///
  /// In en, this message translates to:
  /// **'Suez'**
  String get governorateSuez;

  /// No description provided for @governorateAswan.
  ///
  /// In en, this message translates to:
  /// **'Aswan'**
  String get governorateAswan;

  /// No description provided for @governorateAssiut.
  ///
  /// In en, this message translates to:
  /// **'Assiut'**
  String get governorateAssiut;

  /// No description provided for @governorateBeniSuef.
  ///
  /// In en, this message translates to:
  /// **'Beni Suef'**
  String get governorateBeniSuef;

  /// No description provided for @governoratePortSaid.
  ///
  /// In en, this message translates to:
  /// **'Port Said'**
  String get governoratePortSaid;

  /// No description provided for @governorateDamietta.
  ///
  /// In en, this message translates to:
  /// **'Damietta'**
  String get governorateDamietta;

  /// No description provided for @governorateSharqia.
  ///
  /// In en, this message translates to:
  /// **'Sharqia'**
  String get governorateSharqia;

  /// No description provided for @governorateSouthSinai.
  ///
  /// In en, this message translates to:
  /// **'South Sinai'**
  String get governorateSouthSinai;

  /// No description provided for @governorateKafrElSheikh.
  ///
  /// In en, this message translates to:
  /// **'Kafr El Sheikh'**
  String get governorateKafrElSheikh;

  /// No description provided for @governorateMatrouh.
  ///
  /// In en, this message translates to:
  /// **'Matrouh'**
  String get governorateMatrouh;

  /// No description provided for @governorateLuxor.
  ///
  /// In en, this message translates to:
  /// **'Luxor'**
  String get governorateLuxor;

  /// No description provided for @governorateQena.
  ///
  /// In en, this message translates to:
  /// **'Qena'**
  String get governorateQena;

  /// No description provided for @governorateNorthSinai.
  ///
  /// In en, this message translates to:
  /// **'North Sinai'**
  String get governorateNorthSinai;

  /// No description provided for @governorateSohag.
  ///
  /// In en, this message translates to:
  /// **'Sohag'**
  String get governorateSohag;

  /// No description provided for @contactEyebrow.
  ///
  /// In en, this message translates to:
  /// **'CONTACT'**
  String get contactEyebrow;

  /// No description provided for @contactHeading.
  ///
  /// In en, this message translates to:
  /// **'Ready for your next cup?'**
  String get contactHeading;

  /// No description provided for @contactDescription.
  ///
  /// In en, this message translates to:
  /// **'Order your favorite Drip Society roast and enjoy a premium coffee ritual at home.'**
  String get contactDescription;

  /// No description provided for @contactFacebook.
  ///
  /// In en, this message translates to:
  /// **'Contact us on Facebook'**
  String get contactFacebook;

  /// No description provided for @footerBrandDescription.
  ///
  /// In en, this message translates to:
  /// **'Premium coffee rituals for slow mornings, focused work, and meaningful conversations.'**
  String get footerBrandDescription;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @openCart.
  ///
  /// In en, this message translates to:
  /// **'Open cart'**
  String get openCart;

  /// No description provided for @increaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get increaseQuantity;

  /// No description provided for @decreaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get decreaseQuantity;

  /// No description provided for @removeItem.
  ///
  /// In en, this message translates to:
  /// **'Remove item'**
  String get removeItem;

  /// No description provided for @orderCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get orderCustomer;

  /// No description provided for @orderAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get orderAddress;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderItems;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your order!'**
  String get thankYou;

  /// No description provided for @currencyEgp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currencyEgp;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again.'**
  String get errorConnection;

  /// No description provided for @errorCancelled.
  ///
  /// In en, this message translates to:
  /// **'The request was cancelled.'**
  String get errorCancelled;

  /// No description provided for @errorSecureConnection.
  ///
  /// In en, this message translates to:
  /// **'A secure connection couldn\'t be established.'**
  String get errorSecureConnection;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested resource couldn\'t be found.'**
  String get errorNotFound;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Please check your information and try again.'**
  String get errorValidation;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'The server is having trouble. Please try again later.'**
  String get errorServer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
