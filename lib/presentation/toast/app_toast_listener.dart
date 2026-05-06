import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_toast_event.dart';
import 'package:imovie_app/presentation/toast/imovie_toast.dart';

class AppToastListener extends StatefulWidget {
  const AppToastListener({super.key, required this.child});

  final Widget child;

  @override
  State<AppToastListener> createState() => _AppToastListenerState();
}

class _AppToastListenerState extends State<AppToastListener> {
  late final StreamSubscription<AppToastEvent> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = appEventBus.toastStream.listen(IMovieToast.show);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
