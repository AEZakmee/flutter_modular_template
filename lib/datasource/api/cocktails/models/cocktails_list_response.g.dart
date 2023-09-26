// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktails_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CocktailListResponse _$CocktailListResponseFromJson(
        Map<String, dynamic> json) =>
    CocktailListResponse(
      drinks: (json['drinks'] as List<dynamic>)
          .map((e) => CocktailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CocktailListResponseToJson(
        CocktailListResponse instance) =>
    <String, dynamic>{
      'drinks': instance.drinks,
    };
