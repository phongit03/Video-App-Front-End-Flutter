import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:videomanipulator/providers/progress_provider.dart';

class ExtractProgressProvider extends ChangeNotifier implements ProgressProvider {

  double extractProgress = 0;

  extractZipFileInDevice(BuildContext context) async {
    debugPrint("=====Picking file from device...===================================================================");

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if(result == null) return;
    PlatformFile zipRawFile = result.files.single;

    debugPrint("=====Picked a file from device!!!===================================================================");

    debugPrint("=====Extracting file from device...===================================================================");

    File zipFile = File(zipRawFile.path!);
    Directory? appDir = await getExternalStorageDirectory();

    Directory destineDir = await Directory("${appDir!.path}/unZip").create();

    ZipFile.extractToDirectory(

      zipFile: zipFile,

      destinationDir: destineDir,

      onExtracting:  (zipEntry, progress) {

        progress.toInt() <= 100? updateProgress(progress) : null;
        debugPrint(progress.toString());
        return ZipFileOperation.includeItem;
      },
    );
    debugPrint("=====Finished extracting a file from device!!!===================================================================");

    debugPrint("File extracted from device: ${zipRawFile.name}");
    debugPrint("File path: ${zipRawFile.path}");
    debugPrint("Extension: ${zipRawFile.extension}");
    debugPrint("Size: ${zipRawFile.size} bytes");
    debugPrint("Extract finished at ${DateTime.now()}");
  }

  @override
  updateProgress(double progress) {
    extractProgress = progress;
    notifyListeners();
  }

}