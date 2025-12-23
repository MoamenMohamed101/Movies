import 'package:equatable/equatable.dart';

// The login_state.dart file defines "What the UI should look like" right now.
// Unlike events (which are momentary actions), states are persistent snapshots.
// The UI listens to these states to know what to draw on the screen.

// Purpose: It holds the "data" that might be present in multiple states, specifically validation errors.
// Why: By having these fields in the base class, any state could potentially carry separate error messages for fields,
// though it's mostly used by specific subclasses here.

class LoginState extends Equatable {
  final String? userNameError;
  final String? passwordError;
  final String? errorMessage;

  const LoginState({this.userNameError, this.passwordError, this.errorMessage});

  LoginState copyWith({
    String? userNameError,
    String? passwordError,
    String? errorMessage,
  }) {
    return LoginState(
      userNameError: userNameError ?? this.userNameError,
      passwordError: passwordError ?? this.passwordError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [userNameError, passwordError, errorMessage];
}

// Meaning: The screen just opened.
// UI Reaction: Show the empty form. No spinners, no error messages.
class LoginInitial extends LoginState {}

// Meaning: The user pressed "Login", and the app is currently talking to the server.
// UI Reaction:
//   Disable the Login button so the user doesn't click it twice.
//   Show a CircularProgressIndicator (spinner).
class LoginLoading extends LoginState {}

// Meaning: The server returned a 200 OK. The user is authenticated.
// UI Reaction: Navigate away from this screen (e.g., Navigator.pushReplacementNamed('/home')).
class LoginSuccess extends LoginState {}

// Meaning: Local validation failed. The user didn't type a valid email, or the password is too short before it was even sent to the server.
// UI Reaction: Show red error text under the specific text fields (e.g., "Password must be 6 characters").
class LoginInvalidCredentials extends LoginState {
  final String? userNameError;
  final String? passwordError;

  const LoginInvalidCredentials({this.userNameError, this.passwordError})
    : super(userNameError: userNameError, passwordError: passwordError);
}

// Meaning: The request was sent, but something went wrong. Could be "No Internet", "Server Down", or "Wrong Password" returned by the API.
// UI Reaction: Show a Snackbar or a global error message telling the user what went wrong (e.g., "Connection Timeout").
class LoginError extends LoginState {
  final String errorMessage;

  const LoginError(this.errorMessage) : super(errorMessage: errorMessage);
}

/*
Summary
The BLoC will output these states in a sequence like this:

1. Start: LoginInitial
2. (User types...)
3. (User clicks Login) -> BLoC emits (LoginLoading)
4. (Network finishes) -> BLoC emits (LoginSuccess OR LoginError)
 */

// ====================================================================================


/*
1. Equatable (package:equatable)
By default, Dart compares objects by reference (memory location), not by value.

Imagine this scenario:


var state1 = LoginState(userNameError: "Required");
var state2 = LoginState(userNameError: "Required");
print(state1 == state2); // FALSE! They are two different objects in memory.
The Problem: If the BLoC emits a new state that has the exact same data as the previous state, Flutter might still think it's "new" and rebuild the entire UI unnecessarily.

The Solution (Equatable): When you extend Equatable and define the props list:

dart
@override
List<Object?> get props => [userNameError, passwordError, errorMessage];
You are telling Dart: "If two objects have the same values for these properties, treat them as equal."

dart
print(state1 == state2); // TRUE! because their props are identical.
Benefit:

Performance: The BLoC library checks if (newState == oldState). If they are equal, it ignores the new state. This prevents your app from flickering or rebuilding widgets when nothing actually changed.

*/

// ====================================================================================

/*

copyWith
State objects in BLoC are usually immutable (marked with final). You cannot change a property of an existing state object; you must create a new one.

The Problem: If your state has 5 fields, and you only want to update one of them (e.g., updating just the passwordError), you would normally have to rewrite all the other 4 fields manually when creating the new object.

dart
// The hard way (without copyWith)
return LoginState(
  userNameError: currentState.userNameError, // You have to copy this manually
  passwordError: "New Password Error",       // This is the only change
  errorMessage: currentState.errorMessage,   // You have to copy this manually
);
The Solution (
copyWith
): The 
copyWith
 method is a helper function that lets you clone the current object while overriding only the specific fields you want to change.

dart
LoginState copyWith({
  String? userNameError,
  String? passwordError,
  String? errorMessage,
}) {
  return LoginState(
    // If a new value is provided, use it. Otherwise, keep the old one (this.userNameError).
    userNameError: userNameError ?? this.userNameError,
    passwordError: passwordError ?? this.passwordError,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
Usage:

dart
// The easy way
return state.copyWith(passwordError: "New Password Error");
Benefit:

Clean Code: You only mention the fields that changed.
*/