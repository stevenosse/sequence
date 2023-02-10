class CustomHttpException {
  final String code;
  final CustomHttpError errorType;
  final String details;

  CustomHttpException({
    required this.code,
    required this.details,
    required this.errorType,
  });
}

enum CustomHttpError {
  parsing,
  http,
}
