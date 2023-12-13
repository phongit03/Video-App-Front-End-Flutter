import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:videomanipulator/providers/download_progress_provider.dart';
import 'package:videomanipulator/providers/extract_progress_provider.dart';
import 'package:videomanipulator/providers/progress_provider.dart';

import 'custom_progress_bar.dart';
import '../providers/list_videos_provider.dart';

class ProgressScreen extends StatefulWidget {
  final String progressType;
  const ProgressScreen({
    super.key,
    required this.progressType
  });

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final type = widget.progressType;

    if(type == "download") {
      var provider = Provider.of<DownloadProgressProvider>(context, listen: false);
      deleteFile();
      provider.dowloadProgress = 0;
      provider.download();
    }
    else {
      var provider = Provider.of<ExtractProgressProvider>(context, listen: false);
      provider.extractProgress = 0;
      provider.extractZipFileInDevice(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<ExtractProgressProvider, DownloadProgressProvider>(
        builder: (_, extract, download, child) {
          final type = widget.progressType;
          final statusType = type == "extract"? "Unzipping...":"Downloading...";
          double progress = type == "extract"? extract.extractProgress:download.dowloadProgress;
          if(progress == 100.0) {
            type == "extract"? playVideosByOrder(context) : popAfterSomeTime(context);
          }
          return Visibility(
            visible: progress == 100,
            replacement: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(statusType, style: const TextStyle(color: Colors.white)),
                Text("${progress.toInt()}%", style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20,),
                CustomProgressBar(
                    width: 200,
                    height: 20,
                    progress: progress / 100)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(type == "extract"? "Unzip finished!":"Download finished!", style: const TextStyle(color: Colors.white)),
                const Icon(Icons.download_done_outlined, color: Colors.white,)
              ],
            ),
          );
        }

    );
  }
  void popAfterSomeTime(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    if(mounted) Navigator.pop(context);
  }

  void playVideosByOrder(BuildContext context) async {
    final list = Provider.of<ListVidProvider>(context, listen: false);
    list.sortVideosByOrder();
    await Future.delayed(const Duration(seconds: 1));
    if(mounted) Navigator.pop(context);
  }

  void deleteFile() async {
    final list = Provider.of<ListVidProvider>(context, listen: false);
    var baseDir = await getExternalStorageDirectory();
    final String filePath = "${baseDir!.path}/1MinVids.zip";
    File zipFile = File(filePath);
    Directory destineDir = Directory("${baseDir.path}/unZip");
    if(zipFile.existsSync() && destineDir.existsSync()) {
      list.clearAllVideos();
      baseDir.deleteSync(recursive: true);
      debugPrint("Deleted successfully!!!!!");
    }
  }
}
