import 'dart:async';

import 'package:flutter/material.dart';

class InAppNotifier {
  
  /// This is the [OverlayEntry] to show the notifications when are needed
  static OverlayEntry? _overlayEntry;

  /// These are messages to show when a notification appears
  static final List<Widget> _messages = [];

  ///Max number of notifications being displayed at the same time
  static int maxListLength = 4;

  ///The length of time which a notification is shown for
  static Duration displayTime = const Duration(seconds: 7);

  ///The list of snackbars' timers
  ///each timer holds the amount of time each notification will be dispalyed for
  ///when a timer expires it dismissed the first element on the list
  static final List<Timer> _timersList = <Timer>[];

  ///A boolean which holds the state of the parent notification
  ///false => parent notification is not being displayed
  ///true => parent notification is being displayed
  static bool _isShowingSnackBar = false;

  /// [AnimatedListState] is used to controll the items inside the [AnimatedList]
  static final _animatedListKey = GlobalKey<AnimatedListState>();

  /// [_init] will be only called once to initialize [_overlayEntry]
  static void _init(
    BuildContext context,
    {
      required Widget child,
      required Alignment alignment,
      required double width
    }
  ) {
    _messages.add(child);
    _overlayEntry ??= OverlayEntry(
      builder: (context) => Align(
        alignment: alignment,
        child: SizedBox(
          width: width,
          child: AnimatedList(
            key: _animatedListKey,
            shrinkWrap: true,
            initialItemCount: _messages.length,
            itemBuilder: (context, index, animation) => SlideTransition(
              position: animation.drive(Tween(
                begin: const Offset(0, -1),
                end: const Offset(0, 0)
              )),
              child: Material(
                color: Colors.transparent,
                child: _messages[index],
              )
            ),
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
    _isShowingSnackBar = true;
    _timersList.add(
      Timer(
        displayTime,
        removeNotification
      )
    );
  }

  /// [show] will be called each time you need to show a message/notification
  /// on the screen
  /// the correct use could be have only one instance of this class
  static void show({
    required BuildContext context,
    required Widget child,
    double width = double.infinity,
    Alignment alignment = Alignment.topCenter

  }) {
    if (!_isShowingSnackBar) {
      _init(
        context,
        child: child,
        width: width,
        alignment: alignment
      );
    } else {
      if (_messages.length >= maxListLength) return;

      _messages.add(child);
      _animatedListKey.currentState?.insertItem(_messages.length - 1);
      _timersList.add(
        Timer(
          displayTime,
          removeNotification
        )
      );
    }
  }

  /// [removeNotification] is called when a notification disappears
  /// if the notification is the last one it will also remove [_overlayEntry]
  static void removeNotification() {
    if (_messages.isNotEmpty) {
      _messages.removeAt(0);
      _animatedListKey.currentState?.removeItem(0, (context, animation) => const SizedBox.shrink());
      _timersList.removeAt(0);

      if (_timersList.isEmpty) {
        _isShowingSnackBar = false;
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    }
  }

  /// [removeAllNotifications] is called when you want to remove all notifications
  /// from the screen
  static void removeAllNotifications() {
    _messages.clear();
    for (var timer in _timersList) {
      timer.cancel();
    }
    _timersList.clear();
    _isShowingSnackBar = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
