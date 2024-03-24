enum DetailsFeature {
  disabled(id: 0),
  sheet(id: 1),
  screen(id: 2);

  const DetailsFeature({required this.id});

  static DetailsFeature getType(int id) {
    return switch (id) {
      0 => DetailsFeature.disabled,
      1 => DetailsFeature.sheet,
      2 => DetailsFeature.screen,
      _ => DetailsFeature.disabled,
    };
  }

  final int id;
}
