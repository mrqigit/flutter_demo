import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

abstract class ImageUtil {
  static String getImg(String name) {
    return 'assets/images/$name.png';
  }

  static Future<File?> getFilePath(Image? image) async {
    if (image == null) {
      return null;
    }
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    File file =
        await File(
          '${(await getTemporaryDirectory()).path}/$fileName',
        ).create();
    final ByteData? byteData = await image.toByteData(
      format: ImageByteFormat.png,
    );
    if (byteData == null) {
      return null;
    }
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }
}
