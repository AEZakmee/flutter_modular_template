import 'package:dependencies/exposer.dart';

import 'cocktail_response.dart';

part 'cocktails_list_response.g.dart';

@JsonSerializable()
class CocktailListResponse {
  CocktailListResponse({required this.drinks});

  factory CocktailListResponse.fromJson(Map<String, dynamic> json) =>
      _$CocktailListResponseFromJson(json);

  List<CocktailResponse> drinks;

  Map<String, dynamic> toJson() => _$CocktailListResponseToJson(this);
}
