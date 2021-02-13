import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_school/src/utility/constants.dart';

class DownloadService {
  static download(String path) async {
    if (await Permission.storage.isGranted) {
      String urlSt = kDomainUrl + path;
      var dir = await getExternalStorageDirectory();
      var folderDir = Directory(dir.path + '/Smart School');
      if (!folderDir.existsSync()) {
        folderDir.create(recursive: true);
      }
      final taskId = await FlutterDownloader.enqueue(
        url: urlSt,
        savedDir: folderDir.path,
        showNotification: true,
        openFileFromNotification: true,
      );
      print(taskId);
    } else if (await Permission.storage.isPermanentlyDenied) {
      await openAppSettings();
      download(path);
    } else {
      await Permission.storage.request();
      download(path);
    }
  }
}
