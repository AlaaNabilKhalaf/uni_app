// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Universtiy Email`
  String get UniEmail {
    return Intl.message(
      'Universtiy Email',
      name: 'UniEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get UniEmailHint {
    return Intl.message(
      'Enter Your Email',
      name: 'UniEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get LoginPassword {
    return Intl.message(
      'Password',
      name: 'LoginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get LoginPasswordHint {
    return Intl.message(
      'Enter Your Password',
      name: 'LoginPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Scann QR Code`
  String get QrScanner {
    return Intl.message(
      'Scann QR Code',
      name: 'QrScanner',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message(
      'Welcome',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get ResetPassword {
    return Intl.message(
      'Reset Password',
      name: 'ResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get OldPassword {
    return Intl.message(
      'Old Password',
      name: 'OldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get NewPassword {
    return Intl.message(
      'New Password',
      name: 'NewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New PassWord`
  String get ConNewPassWord {
    return Intl.message(
      'Confirm New PassWord',
      name: 'ConNewPassWord',
      desc: '',
      args: [],
    );
  }

  /// `Go To Login`
  String get GoToLogin {
    return Intl.message(
      'Go To Login',
      name: 'GoToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Enter old Password`
  String get OldPasswordHint {
    return Intl.message(
      'Enter old Password',
      name: 'OldPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get NewPasswordHint {
    return Intl.message(
      'Enter New Password',
      name: 'NewPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get ConNewPassWordHint {
    return Intl.message(
      'Enter New Password',
      name: 'ConNewPassWordHint',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get LangLab {
    return Intl.message(
      'العربية',
      name: 'LangLab',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email and password first`
  String get LoginValidationMassage {
    return Intl.message(
      'Please enter your email and password first',
      name: 'LoginValidationMassage',
      desc: '',
      args: [],
    );
  }

  /// `All Fields are Required`
  String get AllFieldsRequired {
    return Intl.message(
      'All Fields are Required',
      name: 'AllFieldsRequired',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `OPS`
  String get OPS {
    return Intl.message(
      'OPS',
      name: 'OPS',
      desc: '',
      args: [],
    );
  }

  /// `Scan a Code!`
  String get ScanACode {
    return Intl.message(
      'Scan a Code!',
      name: 'ScanACode',
      desc: '',
      args: [],
    );
  }

  /// `DONE`
  String get DONE {
    return Intl.message(
      'DONE',
      name: 'DONE',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong try again`
  String get Error {
    return Intl.message(
      'Something went wrong try again',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `Your New Passwords Don't Match`
  String get NewPasswordsDoNotMatch {
    return Intl.message(
      'Your New Passwords Don\'t Match',
      name: 'NewPasswordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong .. please try again`
  String get SomethingWentWrong {
    return Intl.message(
      'Something went wrong .. please try again',
      name: 'SomethingWentWrong',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
