import 'package:workus/generic/unary_callbacks_registrar.dart';

class UnaryCallbacksInvoker<T> {
  UnaryCallbacksInvoker({required this.registrar});

  final UnaryCallbacksRegistrar<T> registrar;

  void invoke(T value) {
    registrar.forEach((onChange) {
      onChange(value);
    });
  }
}
