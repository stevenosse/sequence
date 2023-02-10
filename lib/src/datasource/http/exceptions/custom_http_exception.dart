import 'package:equatable/equatable.dart';

class CustomHttpException extends Equatable {
  final String code;
  final CustomHttpError errorType;
  final String details;

  const CustomHttpException({
    required this.code,
    required this.details,
    required this.errorType,
  });

  @override
  List<Object?> get props => [code, details, errorType];
}

enum CustomHttpError {
  parsing,
  http,
}
