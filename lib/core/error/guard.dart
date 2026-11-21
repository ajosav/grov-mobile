import 'dart:async';

import 'failure.dart';
import 'result.dart';

Future<Result<T>> guardLocal<T>(Future<T> Function() call) async {
  try {
    return Result.ok(await call());
  } on Object catch (e) {
    return Result.err(CacheFailure('$e'));
  }
}

Stream<Result<T>> guardStream<T>(Stream<T> source) => source
    .map<Result<T>>(Result.ok)
    .transform(
      StreamTransformer<Result<T>, Result<T>>.fromHandlers(
        handleError: (error, _, sink) =>
            sink.add(Result.err(CacheFailure('$error'))),
      ),
    );
