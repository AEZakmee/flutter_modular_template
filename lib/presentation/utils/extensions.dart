import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme/app_colors.dart';
import 'base_viewmodel.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  AppColors get colors => theme.extension<AppColors>()!;
}

extension DisposeWithStreamSubscriptionExtension<T> on StreamSubscription<T> {
  void disposeWith(BaseViewModel viewModel) {
    viewModel.addDisposable(this);
  }
}
