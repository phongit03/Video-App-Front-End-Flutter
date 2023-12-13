





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:videomanipulator/components/progress_view_screen.dart';
import 'package:videomanipulator/providers/download_progress_provider.dart';
import 'package:videomanipulator/providers/extract_progress_provider.dart';

import 'package:videomanipulator/providers/progress_provider.dart';


import '../providers/list_videos_provider.dart';


class DownloadBottomSheet extends StatefulWidget {
  const DownloadBottomSheet({super.key});

  @override
  State<DownloadBottomSheet> createState() => _DownloadBottomSheetState();
}

class _DownloadBottomSheetState extends State<DownloadBottomSheet> {

  @override
  Widget build(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Download", style: TextStyle(color: Colors.white, fontSize: 35),),
              ),
              Consumer<DownloadProgressProvider>(
                builder:(_, download, child) => ElevatedButton(
                    onPressed:() {
                      download.download();
                      showProgressScreen(context, "download");
                      },
                    child: const Icon(Icons.download)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: Consumer<ExtractProgressProvider>(
                    builder: (_, extract, child) => TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                            side: const BorderSide(color: Colors.white)
                          ))
                        ),
                        onPressed: ()  {
                          extract.extractProgress = 0;
                          Navigator.pop(context);
                          extract.extractZipFileInDevice(context);
                          showProgressScreen(context, "extract");
                        },
                        child: const Center(child: Text("Upload from device", style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
              )
            ],
          ),
      );
  }

  void showProgressScreen(BuildContext context, String type) {
    showDialog(
        context: context,
        builder: (_) => ProgressScreen(progressType: type),
        barrierDismissible: false
    );
  }


}
