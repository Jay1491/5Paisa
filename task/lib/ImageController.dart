import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageGalleryController extends GetxController {
  var images = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var page = 1;
  final int limit = 10;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchImages();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !isLoading.value) {
        fetchImages();
      }
    });
  }

  Future<void> fetchImages() async {
    isLoading.value = true;
    final url = Uri.https('picsum.photos', '/v2/list', {'page': '$page', 'limit': '$limit'});
    log("Url:$url");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        images.addAll(data.map((e) => e as Map<String, dynamic>).toList());
        page++;
      } else {
        Get.snackbar('Error', 'Failed to load images: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load images: $e');
    } finally {
      isLoading.value = false;
    }
  }
}