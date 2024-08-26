import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../../utils/extensions.dart';
import '../../utils/snack_bar_helper.dart';
import '../../utils/ui_state_builder.dart';
import '../../utils/viewmodel_builder.dart';
import '../../utils/viewmodel_event_handler.dart';
import 'viewmodel/cocktail_details_event.dart';
import 'viewmodel/cocktail_details_viewmodel.dart';
import 'widgets/cocktail_details_body.dart';

class CocktailDetailsSheet extends StatelessWidget {
  const CocktailDetailsSheet({
    required this.cocktailId,
    super.key,
  });

  final String cocktailId;

  @override
  Widget build(BuildContext context) {
    void showFavoritesUpdated() => SnackBarHelper(context).showSuccessSnackBar(
          context.localizations.favoriteUpdated,
        );

    return ViewModelBuilder<CocktailDetailsViewModel>(
      viewModelBuilder: () => locator(param1: cocktailId),
      builder: (context, viewModel) => Scaffold(
        body: ViewModelEventHandler<CocktailDetailsEvent>(
          viewModel: viewModel,
          onEvent: (event) {
            event.when(
              showFavoriteSuccess: showFavoritesUpdated,
            );
          },
          child: UIStateBuilder<CocktailDetailsViewModel>(
            successState: CocktailDetailsBody(
              submitAction: viewModel.submitAction,
            ),
          ),
        ),
      ),
    );
  }
}
