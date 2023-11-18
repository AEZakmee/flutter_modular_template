import 'package:core/model/cocktail/cocktail_list.dart';
import 'package:core/model/handler/data_response.dart';
import 'package:data/repository/cocktalis/cocktails_repo.dart';

class FetchCocktailsUseCase {
  FetchCocktailsUseCase({
    required CocktailsRepository cocktailsRepo,
  }) : _cocktailsRepo = cocktailsRepo;

  final CocktailsRepository _cocktailsRepo;

  Future<DataResponse<CocktailList>> call() =>
      _cocktailsRepo.fetchAllCocktails();
}
