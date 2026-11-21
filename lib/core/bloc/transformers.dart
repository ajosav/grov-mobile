import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

/// Wait for [duration] of quiet, then keep only the latest event. For search
/// boxes and fields that validate as the user types.
EventTransformer<E> debounceRestartable<E>([
  Duration duration = const Duration(milliseconds: 300),
]) =>
    (events, mapper) =>
        restartable<E>().call(events.debounce(duration), mapper);

/// Ignore events while one is running. For submit buttons.
EventTransformer<E> dropWhileBusy<E>() => droppable<E>();

/// Latest wins; cancels the previous run. For loads and refreshes.
EventTransformer<E> latestOnly<E>() => restartable<E>();

/// One at a time, in order. For writes that must not interleave.
EventTransformer<E> inOrder<E>() => sequential<E>();
