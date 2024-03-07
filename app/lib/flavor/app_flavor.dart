import 'flavor_consts.dart';

enum AppFlavor {
  prod(FlavorConsts.prod),
  dev(FlavorConsts.dev);

  const AppFlavor(this.fileName);

  factory AppFlavor.parse(String? flavor) {
    return switch (flavor?.toLowerCase()) {
      FlavorConsts.prod => AppFlavor.prod,
      FlavorConsts.dev => AppFlavor.dev,
      String() => AppFlavor.dev,
      null => AppFlavor.dev
    };
  }

  final String fileName;
}
