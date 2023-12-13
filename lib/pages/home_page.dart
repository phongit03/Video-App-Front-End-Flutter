
import 'package:flutter/material.dart';

import 'videos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: const VideosPage(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white))
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.white,

          selectedItemColor: Colors.redAccent,

          backgroundColor: Colors.black,

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.video_library_sharp), label: ""),

            BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined, size: 30,), label: ""),

            BottomNavigationBarItem(icon: Icon(Icons.adb), label: ""),
          ],
        ),
      ),
    );
  }
}
