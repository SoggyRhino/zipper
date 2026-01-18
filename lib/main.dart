import 'package:confetti/confetti.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:zipper/state/maze_notifier.dart';
import 'package:zipper/state/maze_preferences_notifier.dart';
import 'package:zipper/ui/preferences/maze_preferences_popup.dart';
import 'package:zipper/ui/timer.dart';
import 'package:zipper/utils/maze_solver.dart';

import 'ui/maze/maze.dart';
import 'ui/maze/maze_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    runApp(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: const Color(0xFFEEF2F5),
          alignment: Alignment.center,
          child: DeviceFrame(
            device: Devices.ios.iPhone13,
            orientation: Orientation.portrait,
            screen: const ProviderScope(child: MyApp()),
          ),
        ),
      ),
    );
  } else {
    runApp(const ProviderScope(child: MyApp()));
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late ConfettiController _confettiController;
  final MazeController mazeController = MazeController();
  final StopWatchTimer timer = StopWatchTimer();

  bool _isGenerating = false;
  bool _showSettings = false;
  bool _legit = true;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _randomizeMaze());
  }

  @override
  void dispose() {
    _confettiController.dispose();
    timer.dispose();
    super.dispose();
  }

  Future<void> _randomizeMaze() async {
    setState(() => _isGenerating = true);

    final pref = ref.read(mazePreferencesProvider);

    try {
      final solution = await MazeSolver.generateCheckPoints(
        pref.height,
        pref.width,
        pref.randomCheckPoints(),
        wallCount: pref.randomWalls(),
      );

      if (!mounted) return;

      ref.read(mazeProvider.notifier).set(
            n: pref.height,
            m: pref.width,
            solution: solution.solution,
            checkpoints: solution.checkpoints,
            walls: solution.walls,
          );

      mazeController.setActive();
      timer.onResetTimer();
      timer.onStartTimer();
      _confettiController.stop();
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _legit = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mazeProvider.select((state) => state.isWin()), (_, isWin) {
      if (isWin) {
        if (_legit) {
          _confettiController.play();
        }
        mazeController.setInactive();
        timer.onStopTimer();
      }
    });

    final isWin = ref.watch(mazeProvider.select((state) => state.isWin()));

    return MaterialApp(
      home: Scaffold(
        body: _buildBody(isWin),
        floatingActionButton: !_showSettings
            ? FloatingActionButton(
                onPressed: () => setState(() => _showSettings = !_showSettings),
                child: const Icon(Icons.settings),
              )
            : null,
      ),
    );
  }

  Widget _buildBody(bool isWin) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_legit) ...[
                TimerWidget(timer: timer),
                const SizedBox(height: 16),
              ],
              _isGenerating
                  ? const Center(child: CircularProgressIndicator())
                  : Maze(controller: mazeController),
              const SizedBox(height: 16),
              if (!_isGenerating)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!isWin) ...[
                        ElevatedButton(
                          onPressed: _onShowSolution,
                          child: Text(
                            "Show Solution",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _onReset,
                          child: Text(
                            "Reset",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                      ElevatedButton(
                        onPressed: _randomizeMaze,
                        child: Text(
                          "Next Maze",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
          ),
        ),
        if (_showSettings)
          Center(
            child: MazePreferencesPopup(
              onClose: () => setState(() => _showSettings = false),
            ),
          ),
      ],
    );
  }

  void _onReset() {
    ref.read(mazeProvider.notifier).reset();
  }

  void _onShowSolution() {
    setState(() => _legit = false);
    ref.read(mazeProvider.notifier).solve();
    timer.onStopTimer();
    mazeController.setInactive();
  }
}
