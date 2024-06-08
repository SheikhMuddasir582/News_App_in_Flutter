class AppExceptions implements Exception{

  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString(){
    return '$_prefix$_message';
  }
}

class InternetException extends AppExceptions{

  InternetException([String? message]) : super(message, 'no internet');
}

class RequestTimeOut extends AppExceptions{

  RequestTimeOut([String? message]) : super(message, 'request time out');
}

class ServerException extends AppExceptions{

  ServerException([String? message]) : super(message, 'Server error');
}

class InvalidDataException extends AppExceptions{

  InvalidDataException([String? message]) : super(message, 'invalid url');
}

class FetchDataException extends AppExceptions{

  FetchDataException([String? message]) : super(message, 'error occured');
}

class BadRequestException extends AppExceptions{
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnauthorisedException extends AppExceptions{
  UnauthorisedException([String? message]) : super(message, 'Unauthorised Request');
}