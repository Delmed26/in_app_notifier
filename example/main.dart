import 'package:flutter/material.dart';
import 'package:in_app_notifier/in_app_notifier.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Example',
      home: MainScreen()
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In_app_notifier'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          // Notifications.removeAllNotifications();
          InAppNotifier.removeNotification();
        },
        child: const Icon(Icons.delete_forever_rounded),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                InAppNotifier.show(
                  context: context,
                  child: const CustomNotification(
                    message: 'Hello World',
                  ),
                  alignment: Alignment.topCenter
                );
              },
              child: const Text('Show notification')
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                InAppNotifier.show(
                  width: 350,
                  context: context,
                  child: const CustomNotification(
                    title: 'Title',
                    message: 'Deserunt dolore id nostrud culpa.',
                  ),
                  alignment: Alignment.topCenter
                );
              },
              child: const Text('Show notification 2')
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                InAppNotifier.displayTime = const Duration(seconds: 20);
              },
              child: const Text('Change display time')
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                InAppNotifier.maxListLength = 10;
              },
              child: const Text('Change max list length')
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNotification extends StatelessWidget {
  const CustomNotification({
    super.key,
    required this.message,
    this.title
  });

  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headline4,
                ),
              Text(message),
            ],
          ),
          TextButton(
            onPressed: () {
              
            },
            child: Text('Click')
          )
        ],
      )
    );
  }
}