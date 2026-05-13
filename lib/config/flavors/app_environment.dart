import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_environment.freezed.dart';

@freezed
abstract class AppEnvironment with _$AppEnvironment {
  const AppEnvironment._();

  const factory AppEnvironment({
    required String supabaseUrl,
    required String supabaseAnonKey,
    required String ophimApiBaseUrl,
  }) = _AppEnvironment;

  factory AppEnvironment.fromDefines() {
    return const AppEnvironment(
      supabaseUrl: 'https://zlmmymxdivxkenfpqdxy.supabase.co',
      supabaseAnonKey: 'sb_publishable_c5XN15s7OiBzenu8V4XG6A_Tsa4sHTd',
      ophimApiBaseUrl: 'https://ophim1.com/v1/api/',
    );
  }

  bool get isSupabaseConfigured {
    return supabaseUrl.trim().isNotEmpty && supabaseAnonKey.trim().isNotEmpty;
  }

  String get supabaseHost {
    if (!isSupabaseConfigured) {
      return 'Not configured';
    }

    final uri = Uri.tryParse(supabaseUrl);
    return uri?.host.isNotEmpty == true ? uri!.host : supabaseUrl;
  }
}
