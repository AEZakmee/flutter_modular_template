class CocktailUI {
  const CocktailUI({
    required this.id,
    required this.title,
    required this.favorite,
  });

  factory CocktailUI.empty() {
    return const CocktailUI(
      id: '',
      title: '',
      favorite: false,
    );
  }

  final String id;
  final String title;
  final bool favorite;

  CocktailUI copyWith({
    String? id,
    String? title,
    bool? favorite,
  }) {
    return CocktailUI(
      id: id ?? this.id,
      title: title ?? this.title,
      favorite: favorite ?? this.favorite,
    );
  }
}
