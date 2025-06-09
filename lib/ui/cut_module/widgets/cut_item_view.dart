import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageItem extends StatefulWidget {
  const ImageItem({super.key, required this.image});

  final ui.Image image;

  @override
  State<StatefulWidget> createState() {
    return _ImageItemState();
  }
}

class _ImageItemState extends State<ImageItem> {
  Uint8List _imageBytes = Uint8List(0);

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  loadImage() async {
    final res = await widget.image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List? buffer = res?.buffer.asUint8List();
    if (buffer != null && buffer.isNotEmpty && mounted) {
      setState(() {
        _imageBytes = buffer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageBytes.isEmpty) {
      return AspectRatio(
        aspectRatio: 1,
        child: ColoredBox(color: Colors.red, child: SizedBox()),
      );
    }
    return AspectRatio(aspectRatio: 1.0, child: Image.memory(_imageBytes));
  }
}
