import 'package:get_it/get_it.dart';
import 'package:umeed_user_app/components/calls_and_messaging.dart';

GetIt locator = new GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}
