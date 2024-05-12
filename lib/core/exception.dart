sealed class ApplicationException {
  final String message;
  const ApplicationException(this.message);
}

class NetworkException extends ApplicationException {
  const NetworkException() : super("Network Error");
}

class ServerException extends ApplicationException {
  const ServerException() : super("Server Error");
}

class CacheException extends ApplicationException {
  const CacheException() : super("Cache Error");
}

class UnknownException extends ApplicationException {
  const UnknownException() : super("Unknown Error");
}

