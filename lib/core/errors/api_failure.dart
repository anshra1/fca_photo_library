// import 'package:equatable/equatable.dart';
// import 'package:fca_photo_library/core/errors/api_exception.dart';

// abstract class AuthError extends Equatable {
//   const AuthError({required this.message, required this.statusCode});

//   final String message;
//   final int statusCode;

//   String get errorMessage => '$statusCode Error:$message';

//   @override
//   List<Object> get props => [message, statusCode];
// }

// class FirebaseFailure extends AuthError {
//   const FirebaseFailure({
//     required super.message,
//     required super.statusCode,
//   });

//   FirebaseFailure.fromException(APIException exception)
//       : this(
//           message: exception.message,
//           statusCode: exception.statusCode,
//         );
// }
