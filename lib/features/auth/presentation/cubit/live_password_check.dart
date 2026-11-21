import 'dart:async';

import '../../domain/entities/password_problem.dart';
import '../../domain/password_policy.dart';
import '../../domain/usecases/check_password.dart';

class LivePasswordCheck(final CheckPassword _checkPassword) {
  Timer? _timer;
  int _seq = 0;

  /// [onResult] gets the problems and whether the server has confirmed them.
  void update(
    String password, {
    required void Function(Set<PasswordProblem> problems, bool serverChecked)
    onResult,
    String? email,
  }) {
    _timer?.cancel();
    final seq = ++_seq;
    final local = localPasswordProblems(password);
    onResult(local, false);
    if (password.isEmpty || local.isNotEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 300), () async {
      final result = await _checkPassword((password: password, email: email));
      if (seq != _seq) {
        return;
      }
      final check = result.valueOrNull;
      if (check != null) {
        onResult({...local, ...check.problems}, true);
      }
    });
  }

  void dispose() => _timer?.cancel();
}
