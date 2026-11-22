import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/brand_logo.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/sign_on_cubit.dart';
import '../cubit/sign_on_state.dart';

class const SignInTransitionHost({required final Widget child, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      child,
      BlocSelector<SignOnCubit, SignOnState, bool>(
        selector: (s) => s.signingIn,
        builder: (context, signingIn) => IgnorePointer(
          ignoring: !signingIn,
          child: AnimatedOpacity(
            opacity: signingIn ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: signingIn ? const SignInTransition() : const SizedBox(),
          ),
        ),
      ),
    ],
  );
}

class const SignInTransition({super.key}) extends StatefulWidget {
  @override
  State<SignInTransition> createState() => _SignInTransitionState();
}

class _SignInTransitionState()
    extends State<SignInTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reduced motion: the logo and the words stay still.
    final still = MediaQuery.disableAnimationsOf(context);
    if (still) {
      _pulse.stop();
      _started = false;
    } else if (!_started) {
      _started = true;
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context).authBusySigningIn;
    final curve = CurvedAnimation(parent: _pulse, curve: Curves.easeInOut);
    return Semantics(
      container: true,
      liveRegion: true,
      label: label,
      child: ColoredBox(
        color: context.tokens.canvas,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpace.s6,
            children: [
              // Only the logo's transform and opacity animate: no relayout.
              AnimatedBuilder(
                animation: curve,
                builder: (context, child) => Opacity(
                  opacity: 0.7 + 0.3 * curve.value,
                  child: Transform.scale(
                    scale: 0.94 + 0.06 * curve.value,
                    child: child,
                  ),
                ),
                child: const RepaintBoundary(child: BrandLogo()),
              ),
              ExcludeSemantics(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: context.tokens.inkMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
