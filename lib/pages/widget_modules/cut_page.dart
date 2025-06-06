import 'dart:io';

import 'package:demo/utils/file_util.dart';
import 'package:demo/utils/image_util.dart';
import 'package:demo/utils/qiniu_util.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

class CutPage extends StatefulWidget {
  const CutPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CutPageState();
  }
}

class _CutPageState extends State<CutPage> {
  late ui.Image _originalImage;
  bool _isImageLoaded = false;
  List<ui.Image> _splitImages = [];

  // 加载图片
  Future<void> _loadImage() async {
    ByteData data = await rootBundle.load('assets/images/header.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    setState(() {
      _originalImage = frameInfo.image;
      _isImageLoaded = true;
    });
  }

  // 分割图片
  void _splitImage() async {
    if (_isImageLoaded) {
      int width = _originalImage.width;
      int height = _originalImage.height;
      int splitWidth = (width / 25).ceil(); // 每个小图片的宽度
      int splitHeight = (height / 25).ceil(); // 每个小图片的高度

      int numColumns = (width / splitWidth).ceil();
      int numRows = (height / splitHeight).ceil();

      List<ui.Image> images = [];
      for (int y = 0; y < numRows; y++) {
        for (int x = 0; x < numColumns; x++) {
          int startX = x * splitWidth;
          int startY = y * splitHeight;
          int endX = startX + splitWidth;
          int endY = startY + splitHeight;

          endX = endX > width ? width : endX;
          endY = endY > height ? height : endY;

          ui.PictureRecorder recorder = ui.PictureRecorder();
          Canvas canvas = Canvas(recorder);
          canvas.drawImageRect(
            _originalImage,
            Rect.fromLTWH(
              startX.toDouble(),
              startY.toDouble(),
              (endX - startX).toDouble(),
              (endY - startY).toDouble(),
            ),
            Rect.fromLTWH(
              0,
              0,
              (endX - startX).toDouble(),
              (endY - startY).toDouble(),
            ),
            Paint(),
          );
          ui.Image newImage = await recorder.endRecording().toImage(
            (endX - startX),
            (endY - startY),
          );
          newImage.toByteData(format: ui.ImageByteFormat.png).then((byteData) {
            // 这里可以对分割后的图片进行保存或其他操作
            // 示例中只是将分割后的图片添加到列表中
            setState(() {
              images.add(newImage);
            });
          });
        }
      }
      setState(() {
        _splitImages = images;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 25,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: _splitImages.length,
              itemBuilder: (context, index) {
                if (index > _splitImages.length - 1) {
                  return AspectRatio(
                    aspectRatio: 1,
                    child: ColoredBox(color: Colors.red, child: SizedBox()),
                  );
                }
                return ImageItem(image: _splitImages[index]);
              },
            ),
          ),
          const SizedBox(height: 30),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _splitImage();
                  },
                  child: const Text("Cut"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // 创建 storage 对象
                    final storage = Storage();
                    // 创建 Controller 对象
                    final putController = PutController();
                    // 添加任务进度监听
                    putController.addProgressListener((progress) {
                      print('任务进度变化：已发送：$progress');
                    });

                    // 添加任务状态监听
                    putController.addStatusListener((StorageStatus status) {
                      print('状态变化: 当前任务状态：$status');
                    });

                    // 使用 storage 的 putFile 对象进行文件上传
                    final file = await ImageUtil.getFilePath(
                      _splitImages.first,
                    );
                    if (file == null) {
                      return;
                    }
                    final token = await QiniuUtil.getToken(
                      _splitImages.first,
                      file.name,
                    );

                    print(token);

                    storage.putFile(
                      file,
                      token,
                      options: PutOptions(
                        controller: putController,
                        key: 'mrqilibary',
                      ),
                    );
                  },
                  child: const Text("Copy"),
                ),
                ElevatedButton(onPressed: () {}, child: const Text("Paste")),
                ElevatedButton(onPressed: () {}, child: const Text("Delete")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
