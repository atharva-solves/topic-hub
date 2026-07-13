import 'package:dio/dio.dart';
import 'package:getx_memo_app/core/errors/app_exceptions.dart';

// UI Message <--- Format (AppException) <--- err translator <--- raw err
class ApiErrorHandler {
  //meth :- stat,ret ApiException instance,input err

  static AppException handleError(dynamic error) {
    //DIO Crash
    if (error is DioException) {
      switch (error.type) {
        //timeout
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return FetchDataException(
            message: 'Connection timed out.Please try again.',
          );

        //connection
        case DioExceptionType.connectionError:
          return FetchDataException(message: 'No Internet Connection');

        //server responded err
        case DioExceptionType.badResponse:

          //execute this action block

          final statusCode = error.response?.statusCode;

          if (statusCode == 400) {
            return InvalidInputException(message: 'Bad request');
          } else if (statusCode == 401 || statusCode == 403) {
            return UnauthorizedException(
              message: 'Unauthorized access.Please login again',
            );
          } else if (statusCode == 404) {
            return FetchDataException(message: 'Requested resource not found');
          } else {
            return FetchDataException(message: 'Server Error : $statusCode');
          }

        //random DIO exception
        default:
          FetchDataException(message: 'Something went wrong with network');
      }
    }

    //crash was not due to DIO
    return FetchDataException(message: 'Unexptected error occured');
  }
}


//meth flow :


 //if err DIO ->

            //START CASE
    //           FD 1.slow internet (timeout err)
    //                      a.conn b.send c.recieve

    //            FD 2.No internet (connection err)

    //            3.Bad response (serv responded eith err)
                  // take code in var 
                  // start if else
    //                       INV IN  a.400 > Bad req
    //                       UNAU    b.401 or 403 > unauth
    //                       FD      c.404 > serv not found
    //                       FD      d.random serv err 

    //             4.deaf > random DIO
                  //END CASE
                  //END DIO

    // method Fallback ret Unexpected err


    //Switch synt:
      
    //    switch (valToCompare){
    //       case val1:
    //       case val2:
    //       case val3:
    //          [---------------------]
    //          | perform this action |          
    //          |                     |          
    //          [---------------------]     
    //          return/break

        //       case val_4:
    //          [---------------------]
    //          | perform this action |          
    //          |                     |          
    //          [---------------------]    
    //          
    //       deafault:
    //          [---------------------]
    //          | perform this action |          
    //          |                     |          
    //          [---------------------]     
    //                       
    //        }