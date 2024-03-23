import '../../model/cocktails/cocktails_list_response.dart';
import '../api_requests.dart';

class CocktailsApiClient {
  CocktailsApiClient({required ApiRequests requests}) : _requests = requests;

  final ApiRequests _requests;

  Future<CocktailListResponse> fetchAll() async {
    final data = await _requests.get('search.php?f=a');
    final cocktails = CocktailListResponse.fromJson(data);
    return cocktails;
  }
}
