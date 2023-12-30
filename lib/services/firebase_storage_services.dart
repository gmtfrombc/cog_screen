// firebase_storage_services.dart
import 'package:cog_screen/data/image_names.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<Map<String, String>> getImageUrls() async {
    Map<String, String> urls = {};

    for (String imageName in imageNames.keys) {
      String fileFormat = imageNames[imageName]!;
      String filePath = '$imageName.$fileFormat';
      String url = await _getImageUrl(filePath);
      urls[imageName] = url;
    }

    return urls;
  }

Future<String> _getImageUrl(String path) async {
    try {
      String downloadUrl = await storage.ref(path).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Error fetching URL for $path: $e');
      rethrow;
    }
  }

}
