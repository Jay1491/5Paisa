import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/ImageController.dart';
import 'package:task/ZoomableImage.dart';

class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageGalleryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: Obx(() => Stack(
            children: [
              GridView.builder(
                controller: controller.scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  final image = controller.images[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => ZoomableImageScreen(imageUrl: image['download_url'])),
                    child: CachedNetworkImage(
                      imageUrl: image['download_url'],
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              if (controller.isLoading.value)
                const Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          )),
    );
  }
}