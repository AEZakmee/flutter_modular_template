import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/cocktail_details_action.dart';
import '../viewmodel/cocktail_details_viewmodel.dart';

class CocktailDetailsBody extends StatelessWidget {
  const CocktailDetailsBody({
    required this.submitAction,
    super.key,
  });

  final Function(CocktailDetailsAction) submitAction;

  @override
  Widget build(BuildContext context) {
    final cocktail = context.watch<CocktailDetailsViewModel>().state.cocktail;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            cocktail.title,
          ),
          IconButton(
            onPressed: () => submitAction(
              const CocktailDetailsAction.toggleFavorite(),
            ),
            icon: Icon(
              cocktail.favorite ? Icons.favorite : Icons.favorite_border,
            ),
          )
        ],
      ),
    );
  }
}
