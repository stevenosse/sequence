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

class I18n {
  I18n();

  static I18n? _current;

  static I18n get current {
    assert(_current != null,
        'No instance of I18n was loaded. Try to initialize the I18n delegate before accessing I18n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I18n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I18n();
      I18n._current = instance;

      return instance;
    });
  }

  static I18n of(BuildContext context) {
    final instance = I18n.maybeOf(context);
    assert(instance != null,
        'No instance of I18n present in the widget tree. Did you add I18n.delegate in localizationsDelegates?');
    return instance!;
  }

  static I18n? maybeOf(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  /// `Tap to start recognition`
  String get musicRecognition_initialActionIndicatorLabel {
    return Intl.message(
      'Tap to start recognition',
      name: 'musicRecognition_initialActionIndicatorLabel',
      desc: '',
      args: [],
    );
  }

  /// `No match found`
  String get musicRecognition_failed_noMatch {
    return Intl.message(
      'No match found',
      name: 'musicRecognition_failed_noMatch',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occured. Please try again`
  String get musicRecognition_failed_other {
    return Intl.message(
      'An unexpected error occured. Please try again',
      name: 'musicRecognition_failed_other',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get musicRecognition_failed_tryAgainButtonLabel {
    return Intl.message(
      'Try again',
      name: 'musicRecognition_failed_tryAgainButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recognition failed`
  String get musicRecognition_failed_title {
    return Intl.message(
      'Recognition failed',
      name: 'musicRecognition_failed_title',
      desc: '',
      args: [],
    );
  }

  /// `We are unable to record a sample, did you provide microphone access ?`
  String get musicRecognition_recordFailed {
    return Intl.message(
      'We are unable to record a sample, did you provide microphone access ?',
      name: 'musicRecognition_recordFailed',
      desc: '',
      args: [],
    );
  }

  /// `Looking for matches...`
  String get musicRecognition_loadingLabel {
    return Intl.message(
      'Looking for matches...',
      name: 'musicRecognition_loadingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Open in spotify`
  String get musicDetails_spotifyButtonlabel {
    return Intl.message(
      'Open in spotify',
      name: 'musicDetails_spotifyButtonlabel',
      desc: '',
      args: [],
    );
  }

  /// `Open in Apple Music`
  String get musicDetails_appleMusicButtonlabel {
    return Intl.message(
      'Open in Apple Music',
      name: 'musicDetails_appleMusicButtonlabel',
      desc: '',
      args: [],
    );
  }

  /// `This app is built for learning purposes only.`
  String get developerNotice {
    return Intl.message(
      'This app is built for learning purposes only.',
      name: 'developerNotice',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I18n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);
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
