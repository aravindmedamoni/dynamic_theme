
import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier{
  ThemeData _themeData;
  bool _newValue = false;
  String _mode = 'Day Mode';
  ThemeChanger(this._themeData);

  getTheme() => _themeData;
  getMode() => _mode;
  getValue() => _newValue;
  setValue(){
    _newValue = !_newValue;
     notifyListeners();
    if(_newValue == false){
      setTheme(ThemeData.light());
      _mode = 'Day Mode';

    }else{
      setTheme(ThemeData.dark());
      _mode = 'Night Mode';
    }
  }
  setTheme(ThemeData theme){
    _themeData = theme;
    notifyListeners();
  }
}