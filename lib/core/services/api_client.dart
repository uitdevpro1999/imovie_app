import 'package:dio/dio.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract interface class ApiClient {
  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });
}

class DioApiClient implements ApiClient {
  DioApiClient({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 15),
  }) : _dio =
           Dio(
               BaseOptions(
                 baseUrl: baseUrl,
                 connectTimeout: timeout,
                 receiveTimeout: timeout,
                 sendTimeout: timeout,
                 headers: const {'accept': 'application/json'},
               ),
             )
             ..interceptors.addAll([
               PrettyDioLogger(
                 requestHeader: true,
                 requestBody: true,
                 responseHeader: false,
                 responseBody: true,
                 error: true,
                 compact: true,
                 maxWidth: 120,
               ),
             ]);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: headers == null ? null : Options(headers: headers),
      );

      final payload = response.data;
      if (payload == null) {
        throw AppException(
          AppFailure.unknown('Unexpected empty API response.'),
        );
      }

      return payload;
    } on DioException catch (error) {
      throw AppException(_mapDioError(error));
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(
        AppFailure.unknown(
          'Unexpected API error occurred.',
          details: error.toString(),
        ),
      );
    }
  }

  AppFailure _mapDioError(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => AppFailure.network(
        'Request timeout while loading data.',
        details: error.message,
      ),
      DioExceptionType.connectionError => AppFailure.network(
        'Network connection failed.',
        details: error.message,
      ),
      DioExceptionType.cancel => AppFailure.network(
        'Request was cancelled.',
        details: error.message,
      ),
      DioExceptionType.badResponse => _mapBadResponse(error.response),
      DioExceptionType.badCertificate => AppFailure.network(
        'Bad certificate while connecting to server.',
        details: error.message,
      ),
      DioExceptionType.unknown => AppFailure.unknown(
        'Unexpected API error occurred.',
        details: error.message ?? error.error.toString(),
      ),
    };
  }

  AppFailure _mapBadResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode ?? 0;
    final message = _extractMessage(response?.data);

    return switch (statusCode) {
      401 => AppFailure.unauthorized(
        message ?? 'Unauthorized request.',
        details: 'HTTP 401',
      ),
      404 => AppFailure.notFound(
        message ?? 'Requested resource was not found.',
        details: 'HTTP 404',
      ),
      _ => AppFailure.server(
        message ?? 'Server returned an unexpected error.',
        details: 'HTTP $statusCode',
      ),
    };
  }

  String? _extractMessage(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      final directMessage = payload['message'];
      if (directMessage is String && directMessage.trim().isNotEmpty) {
        return directMessage;
      }

      final data = payload['data'];
      if (data is Map<String, dynamic>) {
        final nestedMessage = data['message'];
        if (nestedMessage is String && nestedMessage.trim().isNotEmpty) {
          return nestedMessage;
        }
      }
    }

    return null;
  }
}
