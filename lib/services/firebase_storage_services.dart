// firebase_storage_services.dart

import 'package:cog_screen/data/firestore_images/brain_health_images.dart';
import 'package:cog_screen/data/firestore_images/home_images.dart';
import 'package:cog_screen/data/firestore_images/sleep_images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<Map<String, String>> getModuleImageUrls(String moduleName) async {
    Map<String, String> urls = {};
    //debugPrint('Fetching image URLs for module: $moduleName');

    List<MapEntry<String, String>> moduleImageEntries =
        getModuleImageEntries(moduleName);
    for (var entry in moduleImageEntries) {
      String imageName = entry.key;
      String extension = entry.value;
      String filePath = '$moduleName/$imageName.$extension';
      //debugPrint('Constructed filepath: $filePath');
      try {
        String url = await storage.ref(filePath).getDownloadURL();
        urls[imageName] = url;
        //debugPrint('Fetched URL for $imageName: $url');
      } catch (e) {
        debugPrint('Error fetching URL for $filePath: $e');
      }
    }

    return urls;
  }

  List<MapEntry<String, String>> getModuleImageEntries(String moduleName) {
    switch (moduleName) {
      case 'BrainHealth':
       // debugPrint(
       //     'BrainHealth Image Entries: ${brainHealthImageNames.entries.toList()}');
        return brainHealthImageNames.entries.toList();
      case 'Sleep':
        //debugPrint('Sleep Image Entries: ${sleepImageNames.entries.toList()}');
        return sleepImageNames.entries.toList();
      case 'Home':
        //debugPrint('Home Image Entries: ${homeImageNames.entries.toList()}');
        return homeImageNames.entries.toList();
      // ... other cases
      default:
        debugPrint('No entries found for module: $moduleName');
        return []; // Default case for unknown modules
    }
  }
}
