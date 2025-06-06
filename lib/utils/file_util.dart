import 'dart:io';

extension FileUtil on File? {
  String? get name {
    return this?.path.split('/').last;
  }
}

extension FileExtension on File {
  String get name {
    return path.split('/').last;
  }
}
