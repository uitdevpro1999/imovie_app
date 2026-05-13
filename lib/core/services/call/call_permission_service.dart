import 'dart:io';

import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:permission_handler/permission_handler.dart';

abstract interface class CallPermissionService {
  Future<void> ensureCallPermissions(CallType type);
}

class RuntimeCallPermissionService implements CallPermissionService {
  const RuntimeCallPermissionService();

  static const _logName = 'CallPermission';

  @override
  Future<void> ensureCallPermissions(CallType type) async {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      return;
    }

    final permissions = <Permission>[Permission.microphone];
    if (type == CallType.video) {
      permissions.add(Permission.camera);
    }

    final statuses = await permissions.request();
    final denied = statuses.entries
        .where((entry) => !entry.value.isGranted)
        .map((entry) => entry.key)
        .toList(growable: false);

    AppLogger.info(
      'Requested call permissions type=${type.name} '
      'statuses=${statuses.map((key, value) => MapEntry(key.toString(), value.name))}',
      name: _logName,
    );

    if (denied.isEmpty) {
      return;
    }

    final permanentlyDenied = statuses.values.any(
      (status) => status.isPermanentlyDenied || status.isRestricted,
    );
    final message = type == CallType.video
        ? 'Vui lòng cấp quyền camera và micro để gọi video.'
        : 'Vui lòng cấp quyền micro để gọi thoại.';

    throw AppException(
      AppFailure.unauthorized(
        permanentlyDenied
            ? '$message Hãy mở phần Cài đặt của thiết bị để bật lại quyền.'
            : message,
      ),
    );
  }
}
