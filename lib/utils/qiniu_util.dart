import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:demo/utils/file_util.dart';
import 'package:qiniu_sdk_base/qiniu_sdk_base.dart';

abstract class QiniuUtil {
  static String accessKey = 'PgTfK9vCEBCDBUcYkDbzqyER5i625Av2zqnc7HYJ';
  static String secretKey = 'Q78qny33eNf_iI3eTI7Rizn4IaaGyUe3hNd-0Uw2';

  /// 生成Token
  static Future<String> getToken(String name) async {
    final encodedPutPolicy = await getUploadPolicy(name);
    return Auth(
      accessKey: accessKey,
      secretKey: secretKey,
    ).generateUploadToken(putPolicy: encodedPutPolicy);
  }

  /// 获取上传策略参数
  static Future<PutPolicy> getUploadPolicy(String name) async {
    final returnBody = {'name': name};
    return PutPolicy(
      scope: 'mrqilibary',
      deadline: DateTime.now().millisecondsSinceEpoch + 3600 * 24 * 365,
      returnBody: JsonEncoder().convert(returnBody),
    );
  }

  /// HMAC-SHA1加密
  static String hmacSha1(String message) {
    Hmac hmac = Hmac(sha1, secretKey.codeUnits);
    Digest digest = hmac.convert(message.codeUnits);
    return digest.toString();
  }

  /// 上传文件
  static Future<PutResponse> uploadFile({
    required File file,
    void Function(double percent)? addProgressListener,
    void Function(StorageStatus status)? addStatusListener,
  }) async {
    // 创建 storage 对象
    final storage = Storage();
    // 创建 Controller 对象
    final putController = PutController();
    if (addProgressListener != null) {
      putController.addProgressListener(addProgressListener);
    }
    if (addStatusListener != null) {
      putController.addStatusListener(addStatusListener);
    }

    final token = await QiniuUtil.getToken(file.name);

    return await storage.putFile(
      file,
      token,
      options: PutOptions(
        controller: putController,
        mimeType: 'image/png',
        key: 'mrqilibary',
        partSize: 1,
      ),
    );
  }
}
