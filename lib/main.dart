import 'package:exploring_photos_api/pages/exploring_photos_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Exploring Photos Api',
      home: const ExploringPhotosApi(),
    );
  }
}
