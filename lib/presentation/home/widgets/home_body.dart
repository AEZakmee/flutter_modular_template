import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/cocktail/cocktail.dart';
import '../../app/main_viewmodel.dart';
import '../../model/answer_ui.dart';
import '../../utils/extensions.dart';
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
      child: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: Selector<HomeViewModel, List<Cocktail>>(
                selector: (context, viewModel) => viewModel.state.cocktails,
                builder: (context, cocktails, child) {
                  print('rebuilt cocktails');
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        cocktails.length,
                        (index) => Text(
                          cocktails[index].strDrink,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              context.localizations.helloText,
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LocaleSwitcher(name: 'English', locale: Locale('en')),
                LocaleSwitcher(name: 'Български', locale: Locale('bg')),
              ],
            ),
            MaterialButton(
              onPressed: () => submitAction(
                const HomeAction.logOut(),
              ),
              color: context.colors.primaryColor,
              child: Text(context.localizations.logout),
            ),
            TextButton(
              onPressed: () => submitAction(
                HomeAction.addAnswer(Random().nextInt(10000)),
              ),
              child: const Text('Add answer'),
            ),
            TextButton(
              onPressed: () => submitAction(
                const HomeAction.clearAnswers(),
              ),
              child: const Text('Clear answers'),
            ),
            Selector<HomeViewModel, List<AnswerUI>>(
              selector: (context, viewModel) => viewModel.state.answers,
              builder: (context, answers, child) {
                print('rebuilt answers');
                return Column(
                  children: [
                    ...List.generate(
                      answers.length,
                      (index) => Text(answers[index].years),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({
    required this.name,
    required this.locale,
    super.key,
  });
  final String name;
  final Locale locale;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () => context.read<MainViewModel>().setLocale(locale),
          child: Text(
            name,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      );
}
