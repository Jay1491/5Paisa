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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Image Gallery',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Stack(
            children: [
              if (controller.errorMessage.isNotEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 40, color: Colors.red),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          controller.errorMessage.value,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            controller.fetchImages();
                          },
                          child: Text(
                            "Try Again",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                )
              else
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: GridView.builder(
                    controller: controller.scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: controller.images.length,
                    itemBuilder: (context, index) {
                      final image = controller.images[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => ZoomableImageScreen(
                            imageUrl: image['download_url'])),
                        child: Hero(
                          tag: image['download_url'],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: image['download_url'],
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  size: 40,
                                  color: Colors.red),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
