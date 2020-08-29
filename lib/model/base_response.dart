
class BaseResponse<T> {
  String code;
  String message;
  T data;

  BaseResponse({
    this.code,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    code: json["code"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data,
  };
}