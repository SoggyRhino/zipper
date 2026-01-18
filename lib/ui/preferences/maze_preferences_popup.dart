import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zipper/state/maze_preferences_notifier.dart';
import 'package:zipper/ui/preferences/color_picker_field.dart';

class MazePreferencesPopup extends ConsumerStatefulWidget {
  final VoidCallback onClose;

  const MazePreferencesPopup({super.key, required this.onClose});

  @override
  ConsumerState<MazePreferencesPopup> createState() =>
      _MazePreferencesPopupState();
}

class _MazePreferencesPopupState extends ConsumerState<MazePreferencesPopup> {
  late final ColorPickerController pathColorController;

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(mazePreferencesProvider);

    pathColorController = ColorPickerController(initialColor: prefs.pathColor);
    pathColorController.addListener(_onColorChange);
  }

  @override
  void dispose() {
    pathColorController.addListener(_onColorChange);
    pathColorController.dispose();

    super.dispose();
  }

  void _onColorChange() {
    ref
        .read(mazePreferencesProvider.notifier)
        .set(pathColor: pathColorController.color);
  }

  void _onReset() {
    ref.read(mazePreferencesProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final MazePreferencesNotifierState prefs = ref.watch(
      mazePreferencesProvider,
    );

    return TapRegion(
      onTapOutside: (_) => widget.onClose(),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                //header
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Maze Preferences",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: widget.onClose,
                        icon: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                //settings
                Expanded(
                  child: ListView(
                    children: [
                      _buildSlider(
                        "Width",
                        "${prefs.width}",
                        Slider(
                          value: prefs.width.toDouble(),
                          min: prefs.widthFloor.toDouble(),
                          max: prefs.widthCeil.toDouble(),
                          divisions: prefs.widthCeil - prefs.widthFloor,
                          onChanged: (value) => ref
                              .read(mazePreferencesProvider.notifier)
                              .set(width: value.toInt()),
                        ),
                      ),
                      const Divider(),
                      _buildSlider(
                        "Height",
                        "${prefs.height}",
                        Slider(
                          value: prefs.height.toDouble(),
                          min: prefs.heightFloor.toDouble(),
                          max: prefs.heightCeil.toDouble(),
                          divisions: prefs.heightCeil - prefs.heightFloor,
                          onChanged: (value) => ref
                              .read(mazePreferencesProvider.notifier)
                              .set(height: value.toInt()),
                        ),
                      ),
                      const Divider(),
                      _buildSlider(
                        "CheckPoints",
                        "${prefs.minCheckpoints} - ${prefs.maxCheckpoints}",
                        RangeSlider(
                          values: RangeValues(
                            prefs.minCheckpoints.toDouble(),
                            prefs.maxCheckpoints.toDouble(),
                          ),
                          min: prefs.checkPointFloor.toDouble(),
                          max: prefs.checkPointCeil.toDouble(),
                          divisions:
                              prefs.checkPointCeil - prefs.checkPointFloor,

                          onChanged: (RangeValues values) {
                            ref
                                .read(mazePreferencesProvider.notifier)
                                .set(
                                  minCheckpoints: values.start.toInt(),
                                  maxCheckpoints: values.end.toInt(),
                                );
                          },
                        ),
                      ),
                      const Divider(),
                      _buildSlider(
                        "Walls",
                        "${prefs.minCheckpoints} - ${prefs.maxCheckpoints}",
                        RangeSlider(
                          values: RangeValues(
                            prefs.minWalls.toDouble(),
                            prefs.maxWalls.toDouble(),
                          ),
                          min: prefs.wallFloor.toDouble(),
                          max: prefs.wallCeil.toDouble(),
                          divisions: prefs.wallCeil - prefs.wallFloor,

                          onChanged: (RangeValues values) {
                            ref
                                .read(mazePreferencesProvider.notifier)
                                .set(
                                  minWalls: values.start.toInt(),
                                  maxWalls: values.end.toInt(),
                                );
                          },
                        ),
                      ),
                      const Divider(),
                      _buildPathColorPicker(),
                      const Divider(),
                    ],
                  ),
                ),
                _buildResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(String title, String valueDisplay, Widget slider) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  valueDisplay,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(flex: 5, child: slider),
      ],
    );
  }

  Widget _buildPathColorPicker() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Path Color",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: ColorPickerField(controller: pathColorController),
          ),
        ),
      ],
    );
  }

  Widget _buildResetButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _onReset,
          child: Text(
            "Reset to Defaults",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
