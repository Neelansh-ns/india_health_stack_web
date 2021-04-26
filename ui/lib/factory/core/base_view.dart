import 'package:flutter/material.dart';
import 'base_view_out_state.dart';
import 'base_view_state.dart';

abstract class BaseView<T extends BaseViewState, S extends BaseViewOutState> {
  T state;
  S outState;

  @protected
  @mustCallSuper
  BaseView() {
    state = initializeState();
    outState = initializeOutState();
    initialise();
  }

  initialise() {}

  T initializeState();

  S initializeOutState();
}