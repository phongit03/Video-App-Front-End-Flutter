import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:videomanipulator/entities/video_order.dart';
import 'package:videomanipulator/providers/extract_progress_provider.dart';
import 'package:videomanipulator/providers/progress_provider.dart';
import 'package:path/path.dart' as p;
import 'package:open_file/open_file.dart';
import 'package:videomanipulator/utils/path_utils.dart';
class ListVidProvider extends ChangeNotifier {

  List<FileSystemEntity> sortedVideos = [];

  List<FileSystemEntity> videos = [];

  List<VideoOrder> videoOrders = [];

  clearAllVideos() {
    sortedVideos.clear();
    notifyListeners();
  }

  sortVideosByOrder() async {
    sortedVideos.clear();
    Directory? appDir = await getExternalStorageDirectory();
    Directory destineDir = Directory("${appDir!.path}/unZip");
    List<FileSystemEntity> rawFileList = destineDir.listSync();
    videos = rawFileList.where((file) => p.extension(file.path) == ".mp4").toList();
    FileSystemEntity? jsonRawFile = rawFileList.singleWhere((file) => p.extension(file.path) == ".json");
    _jsonHandler(jsonRawFile);
    videoOrders.sort((a,b) =>  a.order!.compareTo(b.order!));
    debugPrint("=====Sorting videos by order...===================================================================");
    for(VideoOrder videoOrder in videoOrders) {
        String? id = videoOrder.videoId;
        int? order = videoOrder.order;
        debugPrint("$order");
        debugPrint("$id");
        for(FileSystemEntity video in videos) {
          String videoId = PathUtils().getId(video.path);
          if(id == videoId) {
            sortedVideos.add(video);
          }
        }
    }
    debugPrint("=====Finished sorting videos by order!!!===========================================================");
    notifyListeners();
  }
//  Private
  _jsonHandler(FileSystemEntity jsonRawFile) {
    File jsonFile = File(jsonRawFile.path);
    List rawVideoList = jsonDecode(jsonFile.readAsStringSync()) as List;
    videoOrders = rawVideoList.map((e) => VideoOrder.fromJson(e)).toList();
  }

}