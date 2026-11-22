import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../session/presentation/cubit/session_cubit.dart';
import '../cubit/sign_on_cubit.dart';
import '../cubit/sign_on_effect.dart';
import '../cubit/sign_on_state.dart';

/// Acts on the cubit's one-shot effect. Pages below the top one stay mounted
/// and hear it too, so only the route on top acts, then acknowledges.
void handleSignOnEffect(BuildContext context, SignOnState state) {
  final effect = state.effect;
  if (effect == null || !(ModalRoute.of(context)?.isCurrent ?? false)) {
    return;
  }
  switch (effect) {
    case SignOnToCode():
      // `go`, not `push`: the router decides what a signed-in session on the
      // code screen sees next ("You're in"), and it reads this location.
      context.go(Routes.code);
    case SignOnSignedIn(:final session):
      // The router redirects to the gate screen or Home once this saves. The
      // button stays busy until then, so it is acknowledged afterwards.
      final cubit = context.read<SignOnCubit>();
      context
          .read<SessionCubit>()
          .signedIn(session)
          .whenComplete(cubit.effectHandled);
      return;
  }
  context.read<SignOnCubit>().effectHandled();
}
