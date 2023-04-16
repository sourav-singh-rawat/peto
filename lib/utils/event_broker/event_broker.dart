part 'event_broker_impl.dart';

class KEvent {}

abstract class KEventBroker {
  static KEventBroker instance = _KEventBrokerImpl();

  void addListener(KEventListener listener);

  void emitEvent(KEvent event);
}

mixin KEventListener {
  void onEvent(KEvent event);
}
