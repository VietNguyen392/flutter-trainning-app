import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';

class Gallery extends StatefulWidget {
  final ScrollController? scrollCtr;
  const Gallery({Key? key,this.scrollCtr}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<Widget> _photoList = [];
  int currPage = 0;
  int? lastPage;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }
_handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currPage != lastPage) {
        _fetchImage();
      }
    }
  }
  _fetchImage() async {
    lastPage = currPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      List<AssetEntity> media = await albums[1]
          .getAssetListPaged(size: 60, page: currPage); //preloading files

      List<Widget> temp = [];
      for (var assets in media) {
        temp.add(FutureBuilder(
          future: assets.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(children: <Widget>[
                Positioned.fill(
                    child: Image.memory(snapshot.data!, fit: BoxFit.cover))
              ]);
            }
            return Container();
          },
        ));
      }
      setState(() {
        _photoList.addAll(temp);
        currPage++;
      });
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll){
        _handleScrollEvent(scroll);
        return false;
      },
      child: GridView.builder(
          controller: widget.scrollCtr,
          itemCount: _photoList.length,
          gridDelegate:
             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return _photoList[index];
          }),
    );
  }
}
