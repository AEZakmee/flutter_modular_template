import 'package:domain/model/cocktail/cocktail_list.dart';
import 'package:domain/services/answers_service.dart';
import 'package:domain/services/auth/auth.dart';
import 'package:domain/usecases/cocktails/fetch_coctails_use_case.dart';

import '../../mappers/answer_mapper.dart';
import '../../utils/base_state_viewmodel.dart';
import '../../utils/extensions.dart';
import 'home_action.dart';
import 'home_state.dart';

final class HomeViewModel extends BaseStateViewModel<HomeState, HomeAction> {
  HomeViewModel({
    required FetchCocktailsUseCase fetchCocktailsUseCase,
    required AnswersService answersService,
    required Auth auth,
  })  : _fetchCocktailsUseCase = fetchCocktailsUseCase,
        _answersService = answersService,
        _auth = auth,
        super(
          initialState: HomeState(
            cocktails: List.empty(),
            answers: List.empty(),
          ),
        );

  final FetchCocktailsUseCase _fetchCocktailsUseCase;
  final AnswersService _answersService;
  final Auth _auth;

  @override
  Future<void> submitAction(HomeAction action) async {
    await action.when(
      addAnswer: _addAnswer,
      clearAnswers: _clearAnswers,
      logOut: _logOut,
    );
  }

  @override
  Future<void> init() async {
    initAnswers();

    await loadData<CocktailList>(
      _fetchCocktailsUseCase,
      onData: (data) {
        state = state.copyWith(cocktails: data.drinks);
      },
    );

    notifyListeners();
  }

  void initAnswers() {
    state = state.copyWith(
      answers: _answersService.getAnswers().map((e) => e.toUI()).toList(),
    );
    _answersService.observeAnswers().listen((items) {
      state = state.copyWith(
        answers: items.map((e) => e.toUI()).toList(),
      );
      notifyListeners();
    }).disposeWith(this);
  }

  Future<void> _addAnswer(int answer) async {
    await _answersService.cacheAnswer(
      name: 'Name',
      years: answer,
    );
  }

  Future<void> _clearAnswers() async {
    await _answersService.clearAnswers();
  }

  Future<void> _logOut() => _auth.signOut();
}
