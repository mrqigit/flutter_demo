import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:crypto/crypto.dart';

abstract class QiniuUtil {
  static String accessKey = 'PgTfK9vCEBCDBUcYkDbzqyER5i625Av2zqnc7HYJ';
  static String secretKey = 'Q78qny33eNf_iI3eTI7Rizn4IaaGyUe3hNd-0Uw2';

  /// 生成Token
  static Future<String> getToken(Image image, String name) async {
    final encodedPutPolicy = await getUploadPolicy(image, name);
    final sign = hmacSha1(encodedPutPolicy);
    final encodedSign = base64UrlEncode(sign.codeUnits);
    return '$accessKey:$encodedSign:$encodedPutPolicy';
  }

  /// 获取上传策略参数
  static Future<String> getUploadPolicy(Image image, String name) async {
    ByteData? byteData = await image.toByteData();
    final returnBody = {
      'name': name,
      'size': byteData?.buffer.asUint8List().length,
      'w': image.width,
      'h': image.height,
    };
    final policy = {
      'scope': 'mrqilibary',
      'deadline': 1451491200,
      'returnBody': JsonEncoder().convert(returnBody),
    };
    return base64UrlEncode(utf8.encode(JsonEncoder().convert(policy)));
  }

  /// HMAC-SHA1加密
  static String hmacSha1(String message) {
    Hmac hmac = Hmac(sha1, secretKey.codeUnits);
    Digest digest = hmac.convert(message.codeUnits);
    return digest.toString();
  }
}
