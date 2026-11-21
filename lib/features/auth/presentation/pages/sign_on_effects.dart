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
  final onJoin = GoRouterState.of(context).uri.path == Routes.join;
  switch (effect) {
    case SignOnToPassword():
      onJoin
          ? context.pushReplacement(Routes.password)
          : context.push(Routes.password);
    case SignOnToJoin():
      context.push(Routes.join);
    case SignOnSignedIn(:final session):
      // The router redirects to the gate screen or Home from here.
      context.read<SessionCubit>().signedIn(session);
  }
  context.read<SignOnCubit>().effectHandled();
}
