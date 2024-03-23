enum FeatureFavorite {
  disabled(id: 0),
  partial(id: 1),
  enabled(id: 2);

  const FeatureFavorite({required this.id});

  static FeatureFavorite getType(int id) {
    return switch (id) {
      0 => FeatureFavorite.disabled,
      1 => FeatureFavorite.partial,
      2 => FeatureFavorite.enabled,
      _ => FeatureFavorite.disabled,
    };
  }

  final int id;

  bool isEnabled() => this == FeatureFavorite.enabled;
}
