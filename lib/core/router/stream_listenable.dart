import 'dart:async';

import 'package:flutter/foundation.dart';

/// Lets go_router re-run `redirect` when [stream] emits.
class StreamListenable(Stream<dynamic> stream) extends ChangeNotifier {
  this {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
