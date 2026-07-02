import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../constants/api_constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['SUPABASE_URL'] ?? '',
        connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          'apikey': dotenv.env['SUPABASE_ANON_KEY'] ?? '',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Dio get dio => _dio;
}
