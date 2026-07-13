//phase I
//base blueprint of exception
class AppException implements Exception {
  final String exceptionMessage;
  final String prefix;

  AppException({
    this.exceptionMessage = 'Something went wrong',
    this.prefix = 'Error',
  });

  @override
  String toString() {
    return '$prefix:$exceptionMessage';
  }
}

//phase II
//3 seperate sub classes for specific exceptions

class FetchDataException extends AppException {
  //fields ,meth,<--from parents
  //Constr-->init list-->sup Constr
  FetchDataException({String message = ''})
    : super(exceptionMessage: message, prefix: 'Error During Communication');
}

class InvalidInputException extends AppException {
  InvalidInputException({String message = ""})
    : super(exceptionMessage: message, prefix: 'Invalid Input');
}

class UnauthorizedException extends AppException {
  UnauthorizedException({String message = ''})
    : super(exceptionMessage: message, prefix: 'Unauthorized Request');
}
