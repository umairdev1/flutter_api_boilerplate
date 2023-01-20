// ignore_for_file: prefer_typing_uninitialized_variables

class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? message])
      : super(message, 'Error During Communication ');
}

class BadRequestExceptions extends AppExceptions {
  BadRequestExceptions([String? message]) : super(message, 'Invalid Request');
}

class UnauthorizedExceptions extends AppExceptions {
  UnauthorizedExceptions([String? message])
      : super(message, 'Unauthroized Request');
}

class InvalidInputExceptions extends AppExceptions {
  InvalidInputExceptions([String? message]) : super(message, 'Invalid Input');
}
