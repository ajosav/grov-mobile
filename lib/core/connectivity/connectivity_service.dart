import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stream_transform/stream_transform.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class ConnectivityService {
  Future<bool> get isOnline;

  Stream<bool> get onlineChanges;
}

class ConnectivityPlusService([Connectivity? connectivity])
    implements ConnectivityService {
  this : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  static bool _isOnline(List<ConnectivityResult> r) =>
      r.any((e) => e != ConnectivityResult.none);

  @override
  Future<bool> get isOnline async =>
      _isOnline(await _connectivity.checkConnectivity());

  @override
  Stream<bool> get onlineChanges => _connectivity.onConnectivityChanged
      .map(_isOnline)
      .debounce(const Duration(milliseconds: 600))
      .distinct();
}
