






import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:videomanipulator/components/custom_textfield.dart';

import 'package:videomanipulator/providers/extract_progress_provider.dart';


import 'package:videomanipulator/providers/progress_provider.dart';
import 'package:videomanipulator/providers/list_videos_provider.dart';

import 'package:videomanipulator/utils/path_utils.dart';
import 'package:videomanipulator/video_player_widget.dart';
import '../components/download_bottom_sheet.dart';
import '../components/setting_dialog.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});
  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  bool isSearch = false;

  List videos = ["Video 1", "Video 2", "Video 3"];

  bool isTapped = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.download, color: Colors.white, size: 35,),
          onPressed: () {
            showBottomDownloadSheet();
          },
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        title: Consumer<ListVidProvider>(
          builder:(_,list,child) => Visibility(
              visible: isSearch,
              replacement: Text("Videos ${list.sortedVideos.isNotEmpty? "(${list.sortedVideos.length})":""}"),
              child: CustomTextField(hintText: "Search",),
          ),
        ),
        centerTitle: true,
        actions: [
          // Show search bar
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
            ),
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            child: isSearch == false? const Icon(Icons.search) : Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Text("Run"),
            ),
          )
        ],
      ),
      body:  Stack (
        children: [
          Container(
            color: Colors.black,
            child: Consumer2<ListVidProvider, ExtractProgressProvider> (
              builder:(_, list, extract, child) {
                return Visibility(
                  visible: extract.extractProgress == 100,
                  replacement: const Center(child: Text("No videos available!", style: TextStyle(color: Colors.white),),),
                  child: PageView.builder(
                      itemCount: list.sortedVideos.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        final video = list.sortedVideos[index];
                        return Center(
                          child: VideoPlayerWidget(video: video, isPlayed: true),
                      );
                    }
                  ),
                );
              }
            ),
            ),
          GestureDetector(
            onDoubleTap: () {
              isTapped = !isTapped;
              debugPrint("$isTapped");
              if(isTapped) showSetting();
              isTapped = false;
            },
          )
        ]
      ),

    );

  }


  void showBottomDownloadSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
            )
        ),
        useRootNavigator: true,

        isScrollControlled: true,

        context: context,

        builder: (_) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  border: Border.all(color: Colors.white, )
              ),
              child: const DownloadBottomSheet()
          );
        }
    );
  }

  void showSetting() {
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) {
          return SettingDialog();
        }
    );
  }



}
