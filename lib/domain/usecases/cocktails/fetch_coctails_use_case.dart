import '../../../data/repository/cocktalis/cocktails_repo.dart';
import '../../model/cocktail/cocktail_list.dart';
import '../../model/handler/data_response.dart';

class FetchCocktailsUseCase {
  FetchCocktailsUseCase({
    required CocktailsRepository cocktailsRepo,
  }) : _cocktailsRepo = cocktailsRepo;

  final CocktailsRepository _cocktailsRepo;

  Future<DataResponse<CocktailList>> call() =>
      _cocktailsRepo.fetchAllCocktails();
}
