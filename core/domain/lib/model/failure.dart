import 'package:domain/model/localised_message.dart';

class Failure {
  int code;
  LocalisedMessage message;

  Failure(this.code, this.message);
}
