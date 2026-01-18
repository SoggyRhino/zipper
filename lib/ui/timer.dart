import 'package:flutter/cupertino.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

// Widget code remains mostly the same, but added dispose for safety
class TimerWidget extends StatelessWidget {
  final StopWatchTimer timer;

  const TimerWidget({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>(
          stream: timer.rawTime,
          initialData: 0,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime = StopWatchTimer.getDisplayTime(
              value!,
              hours: false,
            );
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                displayTime,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
