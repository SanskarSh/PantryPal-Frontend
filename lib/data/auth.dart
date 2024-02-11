import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth.g.dart';

@RestApi(baseUrl: "https://p9kt6b8d-8000.inc1.devtunnels.ms")
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST("/auth/login")
  Future<AuthResponse> authenticate(@Body() Map<String, dynamic> body);

  @POST("/auth/verifyotp")
  Future<VerifyOtpResponse> verifyOtp(@Body() Map<String, dynamic> body);

  @POST("/auth/verifyotp")
  Future<VerifyOtpResponse> verifyOtpWithName(
      @Body() Map<String, dynamic> body);
}

class AuthRequest {
  String phone;

  AuthRequest({required this.phone});

  Map<String, dynamic> toJson() => {
        'phone': phone,
      };
}

class VerifyOtpNameRequest {
  String requestId;
  String userId;
  String code;
  String name;

  VerifyOtpNameRequest(
      {required this.requestId,
      required this.userId,
      required this.code,
      required this.name});

  Map<String, dynamic> toJson() => {
        'request_id': requestId,
        'userId': userId,
        'code': code,
        'name': name,
      };
}

class VerifyOtpRequest {
  String requestId;
  String userId;
  String code;

  VerifyOtpRequest(
      {required this.requestId, required this.userId, required this.code});

  Map<String, dynamic> toJson() => {
        'request_id': requestId,
        'userId': userId,
        'code': code,
      };
}

class AuthResponse {
  String type;
  String message;

  bool status;
  String requestId;
  String userId;

  AuthResponse(
      {required this.status,
      required this.userId,
      required this.requestId,
      required this.type,
      required this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      type: json['type'],
      message: json['message'],
      status: json['data']['status'],
      userId: json['data']['userId'],
      requestId: json['data']['request_id'],
    );
  }
}

class VerifyOtpResponse {
  String type;
  String message;
  String token;

  VerifyOtpResponse(
      {required this.type, required this.message, required this.token});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      type: json['type'],
      message: json['message'],
      token: json['data']['token'],
    );
  }
}
