import 'dart:async';

abstract class BaseUseCase<T, S> {
  FutureOr<T> execute([S param]);
}