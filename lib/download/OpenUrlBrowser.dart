import 'dart:io';

import 'package:budget_mobile/global/globalVar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrlBrowser {
  OpenUrlBrowser({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;
  final String urlPath = 'http://$ipAddSrv/$Budget_Site/Follow/doc/';

  Future<void> launchURL(String? urlStr, String fileName) async {
    if (fileName.isEmpty) {
      throw 'ไม่พบชื่อไฟล์แนบ';
    }

    final base = (urlStr != null && urlStr.isNotEmpty) ? urlStr : urlPath;
    final encodedName = Uri.encodeComponent(fileName);
    final remoteUrl = '$base$encodedName';
    final sanitizedName = _sanitizeFileName(fileName);

    try {
      final tempDir = await getTemporaryDirectory();
      final savePath = '${tempDir.path}/$sanitizedName';

      final response = await _dio.download(
        remoteUrl,
        savePath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );

      final statusCode = response.statusCode ?? HttpStatus.ok;
      if (statusCode != HttpStatus.ok) {
        throw 'ดาวน์โหลดไฟล์ไม่สำเร็จ (HTTP $statusCode)';
      }

      final result = await OpenFilex.open(savePath);
      if (result.type == ResultType.done) {
        return;
      }

      final detail = result.message.trim();
      if (detail.toLowerCase().contains('no app found')) {
        final openedInBrowser = await _openInBrowser(remoteUrl);
        if (!openedInBrowser) {
          throw 'ไม่พบแอปสำหรับเปิดไฟล์ และไม่สามารถเปิดผ่านเบราว์เซอร์ได้';
        }
        return;
      }

      final prefix = 'ไม่สามารถเปิดไฟล์ได้';
      throw detail.isNotEmpty ? '$prefix: $detail' : prefix;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('Download error: ${e.message}');
      }
      throw 'ดาวน์โหลดไฟล์ไม่สำเร็จ';
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Open file error: $e');
      }
      rethrow;
    }
  }

  String _sanitizeFileName(String fileName) {
    final invalidChars = RegExp(r'[\\/:*?"<>|]');
    final cleaned = fileName.replaceAll(invalidChars, '_');
    return cleaned.isEmpty ? 'downloaded_file' : cleaned;
  }

  Future<bool> _openInBrowser(String url) async {
    final uri = Uri.parse(url);
    return launchUrl(uri);
  }
}
