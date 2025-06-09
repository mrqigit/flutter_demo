import 'dart:ui' as ui;

import 'package:demo/utils/result.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class CutRespository {
  /// 获取裁剪数据源
  Future<Result<ui.Image>> getCutData() async {
    ByteData data = await rootBundle.load('assets/images/header.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return Result.succ(frameInfo.image);
  }

  /// 分割图片
  Future<Result<List<ui.Image>>> cutImage({
    required ui.Image image,
    int rows = 25,
    int columns = 25,
  }) async {
    int width = image.width;
    int height = image.height;
    int splitWidth = (width / rows).ceil(); // 每个小图片的宽度
    int splitHeight = (height / columns).ceil(); // 每个小图片的高度

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
          image,
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
        await newImage.toByteData(format: ui.ImageByteFormat.png);
        // 这里可以对分割后的图片进行保存或其他操作
        // 示例中只是将分割后的图片添加到列表中
        images.add(newImage);
      }
    }
    return Result.succ(images);
  }
}
