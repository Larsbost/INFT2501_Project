/*
import 'package:flutter/material.dart';
import 'package:inft2501_prosjekt/generated/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LocaleProvider extends ChangeNotifier {
  late Locale _locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    var a = AppLocalizationDelegate.supportedLocales;
    if (!a.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
*/
