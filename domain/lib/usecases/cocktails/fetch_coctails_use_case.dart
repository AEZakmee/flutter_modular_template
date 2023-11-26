import '../../model/cocktail/cocktail_list.dart';
import '../../model/handler/data_response.dart';
import '../../repositories/cocktails_repository.dart';

class FetchCocktailsUseCase {
  FetchCocktailsUseCase({
    required CocktailsRepository cocktailsRepo,
  }) : _cocktailsRepo = cocktailsRepo;

  final CocktailsRepository _cocktailsRepo;

  Future<DataResponse<CocktailList>> call() =>
      _cocktailsRepo.fetchAllCocktails();
}
