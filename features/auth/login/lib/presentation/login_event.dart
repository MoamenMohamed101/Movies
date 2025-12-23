import 'package:equatable/equatable.dart';

// In the BLoC pattern, the login_event.dart file defines "What happened?" from the user's perspective.
// It represents the inputs to the BLoC.

// Purpose: This is a base class that all other events must inherit from.
// Equatable: It extends Equatable so that the BLoC can compare two events.
// If the user clicks the "Login" button twice with the exact same data, Equatable helps the BLoC avoid unnecessary processing
// if it's already handling that exact request.
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

// Trigger: This event is fired every time the user types a character in the Username/Email text field.
// Data carried: It carries the current string inside the text field (userName).
// Why: The BLoC needs this to perform real-time validation (e.g., checking if the field is empty to enable/disable the login button).
class UserNameChanged extends LoginEvent {
  final String userName;
  const UserNameChanged(this.userName);
  @override
  List<Object?> get props => [userName];
}

// Trigger: Fired every time the user types in the password field.
// Data carried: The current password string.
// Why: Similar to username, for real-time validation or to store the value in the BLoC's memory.
class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

// Trigger: Fired when the user taps the final "Login" button.
// Data carried: Both the userName and password.
// Why: This is the "Action" event. When the BLoC receives this,
// it knows it should stop validating and actually start the authentication process (calling the API).
class LoginButtonPressed extends LoginEvent {
  final String userName;
  final String password;
  const LoginButtonPressed({required this.userName, required this.password});
  @override
  List<Object?> get props => [userName, password];
}

// In Simple Terms:
// Think of this file as a Menu of Actions.

// The UI (the screen) is the customer who picks an action (e.g., "I typed a username").
// The BLoC is the kitchen that receives that action and decides what to do next.
