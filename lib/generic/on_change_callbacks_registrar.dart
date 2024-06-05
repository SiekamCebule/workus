class OnChangeCallbacksRegistrar<T> {
  final _callbacks = <Function(T value)>[];

  void register(Function(T value) callback) {
    _callbacks.add(callback);
  }

  void forEach(Function(Function(T value)) onChange) {
    for (var callback in _callbacks) {
      onChange(callback);
    }
  }
}
