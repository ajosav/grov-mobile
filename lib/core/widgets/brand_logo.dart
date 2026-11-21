import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import '../config/brand_config.dart';
import '../theme/app_tokens.dart' hide formatNaira;
import 'app_assets.dart';

class const BrandLogo({
  final double width = 176,
  final double height = 87,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset(
      AppAssets.logo,
      width: width,
      height: height,
      semanticsLabel: BrandConfig.name,
    );
    if (Theme.of(context).brightness != Brightness.dark) {
      return logo;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        // `on-night` is the cream used on night fields in both themes.
        color: context.tokens.onNight,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(padding: const EdgeInsets.all(AppSpace.s5), child: logo),
    );
  }
}
