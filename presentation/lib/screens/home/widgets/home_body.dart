import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/cocktails/cocktail_ui.dart';
import '../../../widgets/staggered_list_animations.dart';
import '../viewmodel/home_action.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    required this.submitAction,
    super.key,
  });

  final Function(HomeAction) submitAction;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Selector<HomeViewModel, List<CocktailUI>>(
        selector: (context, viewModel) => viewModel.state.cocktails,
        builder: (context, cocktails, child) {
          return StaggeredListView(
            children: List.generate(
              cocktails.length,
              (index) {
                final cocktail = cocktails[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => submitAction(
                      HomeAction.openCocktail(cocktail.id),
                    ),
                    child: Row(
                      children: [
                        Text(cocktail.title),
                        if (cocktail.favorite)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.favorite),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
