import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:loginn/components/independent.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

  return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });

  
}


  String get loginbtn {
    return Intl.message('login', name: 'loginbtn');
  }

  String get locale {
    return Intl.message('ar', name: 'locale');
  }

  String get lname {
    return Intl.message('UserName', name: 'lname');
  }

  String get lpassword {
    return Intl.message('Password', name: 'lpassword');
  }
  String get lforgotpass {
    return Intl.message('Forgot Password', name: 'lforgotpass');
  }
  String get lOr {
    return Intl.message('or', name: 'lOr');
  }
  String get lDontHaveAccount {
    return Intl.message('Dont have an account', name: 'lDontHaveAccount');
  }
  String get signupbtn {
    return Intl.message('Signup', name: 'signupbtn');
  }
  String get useraccount {
    return Intl.message('User', name: 'useraccount');
  }
  String get doctoraccount {
    return Intl.message('Doctor', name: 'doctoraccount');
  }
  String get doctordata {
    return Intl.message('Doctor Data', name: 'doctordata');
  }
  String get hospitalaccount {
    return Intl.message('Hospital', name: 'hospitalaccount');
  }
  String get sname {
    return Intl.message('Name', name: 'sname');
  }
  String get susername {
    return Intl.message('User Name', name: 'susername');
  }
  String get sphone {
    return Intl.message('Phone number', name: 'sphone');
  }
  String get images {
    return Intl.message(' images', name: 'images');
  }
  String get videos {
    return Intl.message(' videos', name: 'videos');
  }
  String get spassword {
    return Intl.message('Password', name: 'spassword');
  }
   String get enternumberofthemedicalstaffincenter {
    return Intl.message('enter number of the medical staff in center', name: 'enternumberofthemedicalstaffincenter');
  }
  String get sconfirmpass {
    return Intl.message('Confirm Password', name: 'sconfirmpass');
  }
  String get closerHospital {
    return Intl.message('closer', name: 'closerHospital');
  }
   String get govHospital {
    return Intl.message('Goverment', name: 'govHospital');
  }
  String get personalinformation {
    return Intl.message('Personal Infromation', name: 'personalinformation');
  }
   String get privetHospital {
    return Intl.message('Privet', name: 'privetHospital');
  }
  String get priceoffsession {
    return Intl.message('Price Of Session', name: 'priceoffsession');
  }
   String get independent {
    return Intl.message('Independent', name: 'independent');
  }
   String get save {
    return Intl.message('save', name: 'save');
  }
   String get home {
    return Intl.message('Home', name: 'home');
  }
  String get subscription {
    return Intl.message('Subscription', name: 'subscription');
  }
   String get consandarticls {
    return Intl.message('Consult & Articls', name: 'consandarticls');
  }
   String get subperiod {
    return Intl.message('Period', name: 'subperiod');
  }
   String get day {
    return Intl.message('day', name: 'day');
  }
   String get month {
    return Intl.message('month', name: 'month');
  }
  String get country {
    return Intl.message('country', name: 'country');
  }
   String get city {
    return Intl.message('city', name: 'city');
  }
   String get citywhereyouaregoingtopay  {
    return Intl.message('city where you are going to pay', name: 'citywhereyouaregoingtopay');
  }
   String get amount  {
    return Intl.message('amount', name: 'amount');
  }
   String get sar  {
    return Intl.message('SAR', name: 'sar');
  }
   String get subbtn  {
    return Intl.message('Subscription', name: 'subbtn');
  }
   String get reservation {
    return Intl.message('Reservation', name: 'reservation');
  }
   String get myaccount {
    return Intl.message('My Account', name: 'myaccount');
  }
   String get specialistshos {
    return Intl.message('Specialists', name: 'specialistshos');
  }
   String get specialistshosname {
    return Intl.message('name', name: 'specialistshosname');
  }
   String get specialization {
    return Intl.message('Specialization', name: 'specialization');
  }
  
   String get informationhos {
    return Intl.message('Information', name: 'informationhos');
  }
  String get absorptivecapacity {
    return Intl.message('Absorptive capacity', name: 'absorptivecapacity');
  }
   String get centerinformation {
    return Intl.message('Center Information ', name: 'centerinformation');
  }
  String get location {
    return Intl.message('location  ', name: 'location');
  }
   String get perinterview {
    return Intl.message('Per Interview', name: 'perinterview');
  }
   String get time {
    return Intl.message('Time ', name: 'time');
  }
  String get enterTimeofopeningandcloseing  {
    return Intl.message('enter Time of opening and closeing of the center ', name: 'enterTimeofopeningandcloseing');
  }
  String get medicalstaff {
    return Intl.message('Medical staff', name: 'medicalstaff');
  }
  String get openingdate {
    return Intl.message('Opening date', name: 'openingdate');
  }
   String get nationality {
    return Intl.message(' Nationality', name: 'nationality');
  }
  String get contactus {
    return Intl.message('Contact Us', name: 'contactus');
  }
  String get reservationbtn {
    return Intl.message('Reservation', name: 'reservationbtn');
  }
  String get message {
    return Intl.message(' Message', name: 'message');
  }
  String get consult {
    return Intl.message('Consult', name: 'consult');
  }
  String get qualifications {
    return Intl.message('Qualifications', name: 'qualifications');
  }
  String get source {
    return Intl.message('Source', name: 'source');
  }
  String get year {
    return Intl.message('Year', name: 'year');
  }
  String get experience {
    return Intl.message('Experience', name: 'experience');
  }
  String get addconsult {
    return Intl.message('Add  Consult', name: 'addconsult');
  }
  String get  docrequest{
    return Intl.message('Request', name: 'docrequest');
  }
  String get  address{
    return Intl.message('Address', name: 'address');
  }
  String get  album{
    return Intl.message('Album', name: 'album');
  }
  
  String get  upcoming{
    return Intl.message('Upcoming ', name: 'upcoming');
  }
  String get  bookreservationtitle{
    return Intl.message('Book Reservation ', name: 'bookreservationtitle');
  }
   String get  enterpatientname{
    return Intl.message('enter patient name ', name: 'enterpatientname');
  }
   String get  enterpatientgender{
    return Intl.message('enter patient gender ', name: 'enterpatientgender');
  }
   String get  current{
    return Intl.message('Current ', name: 'current');
  }
  String get past {
    return Intl.message('Past ', name: 'past');
  }
  String get reservationNum {
    return Intl.message('Reservation Number ', name: 'reservationNum');
  }
  String get reservtype {
    return Intl.message('Reservation Type', name: 'reservtype');
  }
  String get patientname {
    return Intl.message('Patient Name ', name: 'patientname');
  }
  String get patientage {
    return Intl.message('Age ', name: 'patientage');
  }
  String get gender {
    return Intl.message('Gender ', name: 'gender');
  }
  String get date {
    return Intl.message('Date ', name: 'date');
  }
  String get  description{
    return Intl.message('Description ', name: 'description');
  }
  String get  enterpatientdescription{
    return Intl.message('enter patient description ', name: 'enterpatientdescription');
  }
   String get  consultcontent{
    return Intl.message('Consult Content ', name: 'consultcontent');
  }
  String get confrimbtn {
    return Intl.message('Confirm ', name: 'confrimbtn');
  }
  String get cancelbtn {
    return Intl.message('Cancel ', name: 'cancelbtn');
  }
   String get callbtn {
    return Intl.message('Call ', name: 'callbtn');
  }
  String get consulting {
    return Intl.message('Consulting ', name: 'consulting');
  }
  String get consultbar {
    return Intl.message('Consult ', name: 'consultbar');
  }

String get articls {
    return Intl.message('Articls ', name: 'articls');
  }
  String get articlsbar {
    return Intl.message('Articl ', name: 'articlsbar');
  }

String get researchs {
    return Intl.message('Researchs ', name: 'researchs');
  }
  String get researchbar{
    return Intl.message('Research ', name: 'researchbar');
  }
  String get researchWriter{
    return Intl.message('Writer ', name: 'researchWriter');
  }
  String get dateofpublication{
    return Intl.message('Date of Publication ', name: 'dateofpublication');
  }
  String get editbtn {
    return Intl.message('Edit ', name: 'editbtn');
  }
  String get publishbtn {
    return Intl.message('Publish ', name: 'publishbtn');
  }
  String get addarticl {
    return Intl.message('Add Articl ', name: 'addarticl');
  }
  String get articlname {
    return Intl.message('Articl Name ', name: 'articlname');
  }
   String get articlcontent {
    return Intl.message('Articl Content ', name: 'articlcontent');
  }
  String get enterarticlcontent {
    return Intl.message('enter articl content ', name: 'enterarticlcontent');
  }
  String get addcomment {
    return Intl.message('add comment ', name: 'addcomment');
  }
   String get replybtn {
    return Intl.message('Reply ', name: 'replybtn');
  }
   String get morebtn {
    return Intl.message('More ', name: 'morebtn');
  }







}


class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}

class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) => SynchronousFuture<_DefaultCupertinoLocalizations>(_DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;
  
  _DefaultCupertinoLocalizations(this.locale);

 
}