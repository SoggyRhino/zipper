
import 'package:flutter/cupertino.dart';

class MazeController extends ChangeNotifier {
  bool active = false;


  void setActive(){
    active = true;
    notifyListeners();
  }

  void setInactive(){
    active = false;
    notifyListeners();
  }
}