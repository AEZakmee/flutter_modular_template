import '../model/cocktails/cocktail.dart';
import '../model/handler/data_response.dart';
import '../repositories/cocktails_repository.dart';

class CocktailsService {
  CocktailsService({
    required CocktailsRepository cocktailsRepository,
  }) : _cocktailsRepository = cocktailsRepository;

  final CocktailsRepository _cocktailsRepository;

  Stream<Iterable<Cocktail>> observeCocktails() =>
      _cocktailsRepository.observeCocktails();

  DataResponse<Cocktail> getCocktail(String id) =>
      _cocktailsRepository.getCocktail(id);

  Future<void> updateCocktail(Cocktail cocktail) =>
      _cocktailsRepository.updateCocktail(cocktail);
}
