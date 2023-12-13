import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:videomanipulator/providers/progress_provider.dart';

import 'package:path/path.dart' as p;
class DownloadProgressProvider extends ChangeNotifier implements ProgressProvider{

  double dowloadProgress = 0;

  download() async {
      const String urlCon2 = "192.168.31.32";
      final Uri uri = Uri.parse("http://$urlCon2:8080/api/v1/videos");
      final Client httpClient = Client();
      final Request request = Request('GET', uri);
      final Future<StreamedResponse> response = httpClient.send(request);
      final List<List<int>> chunks = [];
      int download = 0;
      response.asStream().listen((StreamedResponse rStream) {
        double progress;
        rStream.stream.listen((List<int> chunk) {
          progress = download/rStream.contentLength!.toInt() * 100;
          updateProgress(progress);
          chunks.add(chunk);
          download += chunk.length;
          debugPrint('DownloadPercentage: ${progress.toInt()}%');
          debugPrint('DownloadSize: $download');
          debugPrint('List chunks length: ${chunks.length}');
          debugPrint('A chunk length: ${chunk.length}');
          debugPrint('Content length: ${rStream.contentLength!.bitLength}');
        },
            onDone: () async {
              progress = download/rStream.contentLength!.toInt() * 100;
              updateProgress(progress);
              Directory? directory = await getExternalStorageDirectory();
              final String filePath = "${directory!.path}/1MinVids.zip";
              File zipFile = File(filePath);
              final Uint8List bytes = Uint8List(rStream.contentLength!);
              int offset = 0;
              for(List<int> chunk in chunks) {
                bytes.setRange(offset, offset + chunk.length, chunk);
                offset += chunk.length;
              }
              await zipFile.writeAsBytes(bytes);
              debugPrint('DownloadPercentageOnDone: ${progress.toInt()}%');
              debugPrint('Download Finished at ${DateTime.now()}');
              debugPrint('File length: ${bytes.length}');
              debugPrint('Bytes length: ${bytes.length}');
              debugPrint('downloadSizeAsBytes: $download');
              debugPrint('Chunks length: ${chunks.length}');
              return;
            });
      });
  }

  @override
  updateProgress(double progress) {
    dowloadProgress = progress;
    notifyListeners();
  }

}