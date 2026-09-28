import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<Duration> {
  TimerCubit() : super(Duration.zero);

  Timer? _timer;

  void start(Duration duration) {
    emit(Duration(seconds: duration.inSeconds));
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final duration = state + const Duration(seconds: 1);
        emit(duration);
      },
    );
  }

  void stop() async {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    stop();
    return super.close();
  }
}
