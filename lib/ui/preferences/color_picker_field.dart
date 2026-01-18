import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerField extends StatefulWidget {
  final ColorPickerController controller;

  const ColorPickerField({super.key, required this.controller});

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.controller.hexString);
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    final newHex = widget.controller.hexString;
    if (_textController.text != newHex) {
      _textController.text = newHex;
      _textController.selection = TextSelection.collapsed(
        offset: newHex.length,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: _openColorPicker,
        child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: widget.controller.color,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: widget.controller.color,
              enableAlpha: false,
              hexInputBar: true,
              portraitOnly: true,

              onColorChanged: (color) {
                widget.controller.setColor(color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Apply'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class ColorPickerController extends ChangeNotifier {
  Color _color;
  ColorPickerController({required Color initialColor}) : _color = initialColor;

  Color get color => _color;

  void setColor(Color newColor) {
    if (_color == newColor) return;
    _color = newColor;
    notifyListeners();
  }

  void setHex(String hex) {
    final newColor = _hexToColor(hex);
    // Only update if the hex is valid and different
    if (newColor != null && _color != newColor) {
      _color = newColor;
      notifyListeners();
    }
  }

  String get hexString => _colorToHex(_color);

  String _colorToHex(Color color) {
    String hex =
        '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    return hex.startsWith('#FF') ? '#${hex.substring(3)}' : hex;
  }

  Color? _hexToColor(String hex) {
    String cleanHex = hex.replaceAll('#', '');
    if (cleanHex.length == 6) cleanHex = 'FF$cleanHex';

    if (cleanHex.length == 8) {
      try {
        return Color(int.parse(cleanHex, radix: 16));
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
