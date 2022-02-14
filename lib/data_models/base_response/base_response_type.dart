class BaseResponseType<T> {
  T data;
  MsgState message;
  ErrorType errorType;

  BaseResponseType({
    this.data,
    this.message,
    this.errorType,
  });
}

enum MsgState { DATA, LOADING, ERROR }

enum ErrorType {
  USER_ERROR,
  TOO_MANY_REQ,
  UNAUTHORIZED_ERROR,
  SERVER_ERROR,
  INTERNET_ERROR,
  TIME_OUT_ERROR
}
