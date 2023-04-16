part of 'event_broker.dart';

class _KEventBrokerImpl implements KEventBroker {
  final List<KEventListener> listeners = [];

  @override
  void addListener(KEventListener listener) {
    listeners.add(listener);
  }

  @override
  void emitEvent(KEvent event) {
    for (var listener in listeners) {
      listener.onEvent(event);
    }
  }
}
