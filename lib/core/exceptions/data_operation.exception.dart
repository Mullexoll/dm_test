abstract class DataOperationException {
  final int statusCode;
  final String message;
  DataOperationException(this.message, this.statusCode);
}

class DataSuccess extends DataOperationException {
  DataSuccess(super.message, super.statusCode);
}

class DataFailure extends DataOperationException {
  DataFailure(super.message, super.statusCode);
}
