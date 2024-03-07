import 'package:data/source/assets/cocktails/cocktails_asset_client.dart';

import '../locator.dart';

void asset() {
  locator.registerLazySingleton(
    CocktailsAssetClient.new,
  );
}
