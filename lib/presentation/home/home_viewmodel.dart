import 'dart:math';

import '../../domain/model/cocktail/cocktail.dart';
import '../../domain/model/cocktail/cocktail_list.dart';
import '../../domain/services/answers_service.dart';
import '../../domain/services/auth/auth.dart';
import '../../domain/usecases/cocktails/fetch_coctails_use_case.dart';
import '../mappers/answer_mapper.dart';
import '../model/answer_ui.dart';
import '../utils/base_viewmodel.dart';
import '../utils/extensions.dart';

final class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required FetchCocktailsUseCase fetchCocktailsUseCase,
    required AnswersService answersService,
    required Auth auth,
  })  : _fetchCocktailsUseCase = fetchCocktailsUseCase,
        _answersService = answersService,
        _auth = auth;

  final FetchCocktailsUseCase _fetchCocktailsUseCase;
  final AnswersService _answersService;
  final Auth _auth;

  CocktailList _cocktails = CocktailList.empty();
  List<AnswerUI> _answers = List.empty();

  List<Cocktail> get cocktails => _cocktails.drinks;
  int get cocktailsLength => cocktails.length;

  List<AnswerUI> get answers => _answers;

  @override
  Future<void> init() async {
    initAnswers();

    await loadData<CocktailList>(
      _fetchCocktailsUseCase,
      onData: (data) {
        _cocktails = data;
      },
    );

    notifyListeners();
  }

  void initAnswers() {
    _answers = _answersService.getAnswers().map((e) => e.toUI()).toList();
    _answersService.observeAnswers().listen((items) {
      _answers = items.map((e) => e.toUI()).toList();
      notifyListeners();
    }).disposeWith(this);
  }

  Future<void> addAnswer() async {
    await _answersService.cacheAnswer(
      name: 'Name',
      years: Random().nextInt(10000),
    );
  }

  Future<void> clearAnswers() async {
    await _answersService.clearAnswers();
  }

  Future<void> logOut() => _auth.signOut();
}
