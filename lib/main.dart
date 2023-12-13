import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videomanipulator/pages/home_page.dart';
import 'package:videomanipulator/providers/download_progress_provider.dart';

import 'package:videomanipulator/providers/extract_progress_provider.dart';
import 'package:videomanipulator/providers/progress_provider.dart';
import 'package:videomanipulator/providers/list_videos_provider.dart';


void main(List<String> args) {
  runApp(
    const VidsManipulatorApp(),
  );
}
class VidsManipulatorApp extends StatelessWidget {
  const VidsManipulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExtractProgressProvider()),
        ChangeNotifierProvider(create: (_) => DownloadProgressProvider()),
        ChangeNotifierProvider(create: (_) => ListVidProvider())
      ],
      child: const MaterialApp(
          home: HomePage(),
      ),
    );
  }
}
