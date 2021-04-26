import 'dart:async';

import 'package:flutter/material.dart';

class BottomSheetService {
  Function(Widget, bool, bool, Color) _showDismissibleBottomSheetListener;
  Function(Widget, bool, bool) _showNonDismissibleBottomSheetListener;
  Function _closeBottomSheetListener;
  Function _closeAllOpenBottomSheets;
  Completer<dynamic> _bottomSheetCompleter;

  void registerBottomSheetListener(
      Function(Widget, bool, bool , Color) showDismissibleBottomSheetListener,
      Function(Widget, bool, bool) showNonDismissibleBottomSheetListener,
      Function closeBottomSheetListener,
      Function closeAllOpenBottomSheets) {
    _showDismissibleBottomSheetListener = showDismissibleBottomSheetListener;
    _showNonDismissibleBottomSheetListener = showNonDismissibleBottomSheetListener;
    _closeBottomSheetListener = closeBottomSheetListener;
    _closeAllOpenBottomSheets = closeAllOpenBottomSheets;
  }

  Future<dynamic> showDismissibleBottomSheet<ReturnType>(
      {Widget child, bool dismissible, bool isScrollControlled = true,Color bgColor}) async {
    _bottomSheetCompleter = Completer<dynamic>();
    ///Prevents crashing of 'Flutter Crash' bottom sheet.
    await Future.delayed(Duration(milliseconds: 1));
    await _showDismissibleBottomSheetListener(child, dismissible, isScrollControlled,bgColor);
    return _bottomSheetCompleter.future;
  }

  Future<dynamic> showNonDismissibleBottomSheet(
      {Widget child, bool dismissible, bool isScrollControlled = true}) async {
    ///Prevents crashing of 'Flutter Crash' bottom sheet.
    await Future.delayed(Duration(milliseconds: 1));
    await _showNonDismissibleBottomSheetListener(child, dismissible, isScrollControlled);
    return _bottomSheetCompleter.future;
  }

  void bottomSheetComplete({dynamic isSheetOpened}) {
    _bottomSheetCompleter.complete(isSheetOpened);
  }

  Future<dynamic> closeBottomSheet() async {
    resetCompleter();
    await _closeBottomSheetListener();
    return _bottomSheetCompleter.future;
  }

  void resetCompleter() {
    _bottomSheetCompleter = null;
    _bottomSheetCompleter = Completer();
  }

  void sheetOpened() {
    print('Bottom Sheet Status = SHEET OPENED!');
  }

  void sheetClosed(result) {
    print('Bottom Sheet Status = SHEET CLOSED WITH RESULT = $result');
  }

  void closeAllSheets() {
    print('Called Close All Sheets');
    _closeAllOpenBottomSheets();
  }
}