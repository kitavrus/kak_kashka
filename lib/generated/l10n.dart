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

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Category search with mistake`
  String get category_search_state_failure {
    return Intl.message(
      'Category search with mistake',
      name: 'category_search_state_failure',
      desc: '',
      args: [],
    );
  }

  /// `Category loaded with mistake`
  String get category_state_failure {
    return Intl.message(
      'Category loaded with mistake',
      name: 'category_state_failure',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get button_add {
    return Intl.message(
      'Add',
      name: 'button_add',
      desc: '',
      args: [],
    );
  }

  /// `Want is eat?`
  String get main_app_bar_title {
    return Intl.message(
      'Want is eat?',
      name: 'main_app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Goods`
  String get goods {
    return Intl.message(
      'Goods',
      name: 'goods',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get bottom_navigation_bar_item_label_home {
    return Intl.message(
      'Home',
      name: 'bottom_navigation_bar_item_label_home',
      desc: '',
      args: [],
    );
  }

  /// `Goods`
  String get bottom_navigation_bar_item_label_goods {
    return Intl.message(
      'Goods',
      name: 'bottom_navigation_bar_item_label_goods',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get bottom_navigation_bar_item_label_categories {
    return Intl.message(
      'Categories',
      name: 'bottom_navigation_bar_item_label_categories',
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
      Locale.fromSubtags(languageCode: 'ru'),
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
