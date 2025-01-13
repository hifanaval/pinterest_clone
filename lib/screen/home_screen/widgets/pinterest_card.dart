import 'package:flutter/material.dart';
import 'package:machine_test_app/constants/color_class.dart';
import 'package:machine_test_app/model/image_list_model.dart';
import 'package:machine_test_app/provider/image_provider.dart';
import 'package:machine_test_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

class PinterestCard extends StatelessWidget {
  final int index;
  final List<ImageModelDart> image;

  const PinterestCard({super.key, required this.index, required this.image});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imageProvider = Provider.of<ImageDataProvider>(context);
    final isDownloading = imageProvider.isDownloading &&
        imageProvider.downloadingImageIndex == index;

    return InkWell(
      onTap: isDownloading
          ? null
          : () => imageProvider.downloadImage(
                context,
                image[index].urls?.regular ?? "",
                index,
              ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            isDark ? AppColors.darkShadow : AppColors.lightShadow,
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.7 + (index % 2) * 0.1,
                child: Image.network(
                  image[index % image.length].urls?.regular ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: isDownloading
                      ? AppUtils.loadingWidget(context)
                      : const Icon(
                          Icons.save_alt,
                          color: AppColors.white,
                          size: 20,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
