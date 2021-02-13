
import 'dart:async';

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'l10n/app_localizations.dart';
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
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: 0.16.1
///
///   # rest of dependencies
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
  AppLocalizations(String locale) : assert(locale != null), localeName = intl.Intl.canonicalizedLocale(locale.toString());

  // ignore: unused_field
  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('ur')
  ];

  // No description provided in @appName
  String get appName;

  // No description provided in @login
  String get login;

  // No description provided in @username
  String get username;

  // No description provided in @password
  String get password;

  // No description provided in @forgot
  String get forgot;

  // No description provided in @privacy
  String get privacy;

  // No description provided in @language
  String get language;

  // No description provided in @english
  String get english;

  // No description provided in @arabic
  String get arabic;

  // No description provided in @kurdish
  String get kurdish;

  // No description provided in @stdName
  String stdName(String name);

  // No description provided in @className
  String className(String className);

  // No description provided in @menu
  String get menu;

  // No description provided in @classTable
  String get classTable;

  // No description provided in @chat
  String get chat;

  // No description provided in @profile
  String get profile;

  // No description provided in @fee
  String get fee;

  // No description provided in @live
  String get live;

  // No description provided in @lessonPlan
  String get lessonPlan;

  // No description provided in @syllabus
  String get syllabus;

  // No description provided in @homework
  String get homework;

  // No description provided in @exam
  String get exam;

  // No description provided in @downloads
  String get downloads;

  // No description provided in @attendance
  String get attendance;

  // No description provided in @examination
  String get examination;

  // No description provided in @notice
  String get notice;

  // No description provided in @reviews
  String get reviews;

  // No description provided in @library
  String get library;

  // No description provided in @transport
  String get transport;

  // No description provided in @hostel
  String get hostel;

  // No description provided in @task
  String get task;

  // No description provided in @logOut
  String get logOut;

  // No description provided in @change
  String get change;

  // No description provided in @admNo
  String admNo(String no);

  // No description provided in @rollNo
  String rollNo(String no);

  // No description provided in @admissionDate
  String get admissionDate;

  // No description provided in @dob
  String get dob;

  // No description provided in @category
  String get category;

  // No description provided in @mobileNo
  String get mobileNo;

  // No description provided in @caste
  String get caste;

  // No description provided in @religion
  String get religion;

  // No description provided in @email
  String get email;

  // No description provided in @currentAddress
  String get currentAddress;

  // No description provided in @permanentAddress
  String get permanentAddress;

  // No description provided in @bloodGroup
  String get bloodGroup;

  // No description provided in @height
  String get height;

  // No description provided in @weight
  String get weight;

  // No description provided in @asOnDate
  String get asOnDate;

  // No description provided in @medicalHistory
  String get medicalHistory;

  // No description provided in @father
  String get father;

  // No description provided in @mother
  String get mother;

  // No description provided in @guardian
  String get guardian;

  // No description provided in @previousSchool
  String get previousSchool;

  // No description provided in @nic
  String get nic;

  // No description provided in @localId
  String get localId;

  // No description provided in @bankNo
  String get bankNo;

  // No description provided in @bankName
  String get bankName;

  // No description provided in @ifsc
  String get ifsc;

  // No description provided in @rte
  String get rte;

  // No description provided in @vehicleRoute
  String get vehicleRoute;

  // No description provided in @vehicleNo
  String get vehicleNo;

  // No description provided in @driverName
  String get driverName;

  // No description provided in @driverContact
  String get driverContact;

  // No description provided in @amount
  String get amount;

  // No description provided in @discount
  String get discount;

  // No description provided in @fine
  String get fine;

  // No description provided in @paid
  String get paid;

  // No description provided in @balance
  String get balance;

  // No description provided in @view
  String get view;

  // No description provided in @dueDate
  String get dueDate;

  // No description provided in @paidAmount
  String get paidAmount;

  // No description provided in @balanceAmount
  String get balanceAmount;

  // No description provided in @unPaid
  String get unPaid;

  // No description provided in @partial
  String get partial;

  // No description provided in @id
  String get id;

  // No description provided in @date
  String get date;

  // No description provided in @liveClass
  String get liveClass;

  // No description provided in @join
  String get join;

  // No description provided in @awaited
  String get awaited;

  // No description provided in @finished
  String get finished;

  // No description provided in @cancelled
  String get cancelled;

  // No description provided in @sunday
  String get sunday;

  // No description provided in @monday
  String get monday;

  // No description provided in @tuesday
  String get tuesday;

  // No description provided in @wednesday
  String get wednesday;

  // No description provided in @thursday
  String get thursday;

  // No description provided in @friday
  String get friday;

  // No description provided in @saturday
  String get saturday;

  // No description provided in @time
  String get time;

  // No description provided in @subject
  String get subject;

  // No description provided in @roomNo
  String get roomNo;

  // No description provided in @homeWork
  String get homeWork;

  // No description provided in @addHomeWork
  String get addHomeWork;

  // No description provided in @homeWorkDate
  String get homeWorkDate;

  // No description provided in @submissionDate
  String get submissionDate;

  // No description provided in @createdBy
  String get createdBy;

  // No description provided in @evaluatedBy
  String get evaluatedBy;

  // No description provided in @message
  String get message;

  // No description provided in @noImage
  String get noImage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  
  
  
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'ur': return AppLocalizationsUr();
  }

  assert(false, 'AppLocalizations.delegate failed to load unsupported locale "$locale"');
  return null;
}
