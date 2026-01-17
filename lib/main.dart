import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zipper/state/maze_notifier.dart';
import 'package:zipper/utils/maze_solver.dart';

import 'ui/maze/maze.dart';
import 'ui/maze/maze_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late ConfettiController _confettiController;
  final MazeController mazeController = MazeController();
  late Future<void> mazeReady;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    mazeReady = Future.microtask(() => _randomizeMaze());
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mazeProvider.select((state) => state.isWin()), (_, isWin) {
      if (isWin) {
        _confettiController.play();
        mazeController.setInactive();
      } else {
        _confettiController.stop();
      }
    });

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                    future: mazeReady,
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          return Maze(controller: mazeController);
                        },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _randomizeMaze(),
                    child: Text(
                      "Random Maze",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                shouldLoop: false,
                blastDirection: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _randomizeMaze() async {
    return Future.microtask(() async {
      final Random random = Random();

      int n = random.nextInt(5) + 3;
      int m = random.nextInt(5) + 3;
      List<(int, int)> checkpoints = MazeSolver().generateCheckPoints(n, m);

      ref.read(mazeProvider.notifier).set(n: n, m: m, checkpoints: checkpoints);
      mazeController.setActive();
    });
  }
}
