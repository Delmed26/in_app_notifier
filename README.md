# In_app_notifier

A plugin made to show notification inside the app easly.

The in_app_notifier package is a simple and customizable solution for displaying notifications within your Flutter application. It allows you to display a child widget, such as a text message or an image, in any location on the screen. You can also customize the _alignment_ and _width_ of the notification. The package makes use of the Overlay widget, which allows for the notifications to be displayed on top of your current screen without blocking user interactions with the underlying widgets.

<p>
  <img src="https://github.com/Delmed26/in_app_notifier/blob/main/doc/iOS_example.gif?raw=true"
    alt="An animated image of the plugin In_app_notifier" height="400"/>
</p>

## Getting started
In your pubspec.yaml file, add the following dependency:
```dart
dependencies:
  in_app_notifier: <latest-version>
```
or execute the command:
```
flutter pub add in_app_notifier
```

## Features

Use this package if you need to:
* Display notifications anywhere on the screen using Alignment.
* Show a custom widget on a notification inside the app.

## Usage
The package uses an OverlayEntry to display the notification and it will automatically remove it from the overlay at the end of a timer, so you don't have to worry about dismissing it manually.

To use the package, import _in_app_notifier.dart_ and execute _InAppNotifier.show()_ anywhere on the app.

```dart
import 'package:in_app_notifier/in_app_notifier.dart';

void showNotification () {
  InAppNotifier.show(
    context: context,
    alignment: Alignment.topCenter
    child: const YourNotificationWidget(),
  );
}
```

Here is an example if you want to delete all or just the first or all the notifications in the queue.
```dart
Notifications.removeAllNotifications();
// or
InAppNotifier.removeNotification();
```

If you want to change the _displayTime_ and _maxListLength_ you can modify the static properties.
```dart
void changeProperties() {
  InAppNotifier.displayTime = const Duration(seconds: 20);
  InAppNotifier.maxListLength = 10;
}
```

## Contributing to this plugin

If you have any ideas or have found a bug, please open an issue on the [repository](https://github.com/Delmed26/in_app_notifier)

Let's make this plugin better together!