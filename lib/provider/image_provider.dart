// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_app/constants/api_urls.dart';
import 'package:machine_test_app/model/image_list_model.dart';
import 'package:machine_test_app/utils/app_utils.dart';
import 'package:machine_test_app/utils/get_service.dart';
import 'package:path_provider/path_provider.dart';
// import 'dart:html' as html;

import 'package:share_plus/share_plus.dart';

class ImageDataProvider extends ChangeNotifier {
  bool isDataLoading = false;
  bool isLoadingMore = false;
  bool isDownloading = false;
  int? downloadingImageIndex;
  List<ImageModelDart> imageModel = [];
  int currentPage = 1;
  bool hasMoreData = true;
   final Dio _dio = Dio();


  //------Image get method--------------//
  Future<void> fetchImageList(BuildContext context,
      {bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoadingMore || !hasMoreData) return;
      setLoadingMore(true);
    } else {
      if (isDataLoading) return;
      imageModel.clear();
      currentPage = 1;
      hasMoreData = true;
      setDataLoading(true);
    }

    try {
      final jsonData = await GetServiceUtils.fetchData(
          ApiUrls.getImageList(page: currentPage), context);

      final newImages = imageModelDartFromJson(jsonData);

      if (newImages.isEmpty) {
        hasMoreData = false;
      } else {
        imageModel.addAll(newImages);
        currentPage++;
      }

      debugPrint("Images fetched successfully for page $currentPage");
      debugPrint("Number of new images: ${newImages.length}");
    } catch (e, stackTrace) {
      debugPrint('Image data Error: $e');
      debugPrint('Stack trace: $stackTrace');
    } finally {
      if (isLoadMore) {
        setLoadingMore(false);
      } else {
        setDataLoading(false);
      }
      notifyListeners();
    }
  }

  // ------ Image Download Method --------------
 Future<void> downloadImage(BuildContext context, String imageUrl, int index) async {
    if (isDownloading) return;

    try {
      setDownloading(true);
      downloadingImageIndex = index;
      notifyListeners();

      if (kIsWeb) {
        // await _downloadForWeb(imageUrl);
      } else {
        await _downloadForMobile(context, imageUrl);
      }

      AppUtils.showToast(
        context, 
        "Success", 
        "Image saved successfully!", 
        true
      );
    } catch (e) {
      debugPrint("Failed to download image: $e");
      AppUtils.showToast(
        context, 
        "Failed to save image", 
        "Error: ${e.toString()}", 
        false
      );
    } finally {
      setDownloading(false);
      downloadingImageIndex = null;
      notifyListeners();
    }
  }

  // Future<void> _downloadForWeb(String imageUrl) async {
  //   final anchor = html.AnchorElement(href: imageUrl)
  //     ..setAttribute("download", "image_${DateTime.now().millisecondsSinceEpoch}.jpg")
  //     ..style.display = 'none';
    
  //   html.document.body?.children.add(anchor);
  //   anchor.click();
  //   html.document.body?.children.remove(anchor);
  // }

  Future<void> _downloadForMobile(BuildContext context, String imageUrl) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';

      // Download file with progress
      await _dio.download(
        imageUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            debugPrint('Download Progress: $progress%');
          }
        },
      );

      final file = File(filePath);
      if (await file.exists()) {
        // Share the file which allows saving to gallery
        final xFile = XFile(filePath);
        await Share.shareXFiles(
          [xFile],
          text: 'Save Image',
        );

        // Clean up temporary file after a delay
        Future.delayed(const Duration(seconds: 1), () async {
          if (await file.exists()) {
            await file.delete();
          }
        });
      } else {
        throw Exception('Downloaded file not found');
      }

    } catch (e) {
      debugPrint('Download error: $e');
      throw e;
    }
  }

  
  void setDataLoading(bool loading) {
    isDataLoading = loading;
    notifyListeners();
  }

  void setDownloading(bool loading) {
    isDownloading = loading;
    notifyListeners();
  }

  void setLoadingMore(bool loading) {
    isLoadingMore = loading;
    notifyListeners();
  }

  bool get canLoadMore => !isLoadingMore && hasMoreData && !isDataLoading;
}
