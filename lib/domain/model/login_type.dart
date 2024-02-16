enum LoginType {
  custom(id: 0),
  firebase(id: 1);

  const LoginType({required this.id});

  static LoginType getType(int id) {
    return switch (id) {
      0 => LoginType.custom,
      1 => LoginType.firebase,
      int() => LoginType.custom,
    };
  }

  final int id;
}
