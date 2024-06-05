import 'package:workus/generic/on_change_callbacks_registrar.dart';

class OnChangeCallbacksInvoker<T> {
  OnChangeCallbacksInvoker({required this.registrar});

  final OnChangeCallbacksRegistrar<T> registrar;

  void invoke(T value) {
    registrar.forEach((onChange) {
      onChange(value);
    });
  }
}
