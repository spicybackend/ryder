class ProfileException implements Exception {
  final String message;

  ProfileException(this.message);
}

class UsernameAlreadyTakenException extends ProfileException {
  UsernameAlreadyTakenException()
      : super("Sorry, that username's already been taken");
}

class UsernameTooShortException extends ProfileException {
  UsernameTooShortException() : super("Sorry, that username's too short");
}
