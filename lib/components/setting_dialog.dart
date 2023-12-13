
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:videomanipulator/components/progress_view_screen.dart';
import 'package:videomanipulator/providers/download_progress_provider.dart';
import 'package:videomanipulator/providers/list_videos_provider.dart';
class SettingDialog extends StatefulWidget {
  const SettingDialog({super.key});

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 600
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
                ),
                onPressed: reFresh,
                icon: const Icon(Icons.refresh, color: Colors.white,),
                label: const Text("Refresh",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  void reFresh() {
    showDialog(
        context: context,
        builder: (_) => const ProgressScreen(progressType: "download"),
        barrierDismissible: true
    );
  }
}
