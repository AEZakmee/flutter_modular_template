import '../../../constants/asset_path.dart';
import '../../model/cocktails/cocktails_list_response.dart';
import '../json_asset_client.dart';

class CocktailsAssetClient extends JsonAssetClient {
  @override
  String path = AssetPath.cocktailsJsonPath;

  Future<CocktailListResponse> fetchAll() async {
    final cocktails = CocktailListResponse.fromJson(
      await readJson(),
    );
    return cocktails;
  }
}
