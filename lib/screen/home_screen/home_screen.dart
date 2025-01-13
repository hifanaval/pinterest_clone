// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:machine_test_app/components/sized_box.dart';
import 'package:machine_test_app/constants/color_class.dart';
import 'package:machine_test_app/constants/image_class.dart';
import 'package:machine_test_app/constants/textstyle_class.dart';
import 'package:machine_test_app/provider/image_provider.dart';
import 'package:machine_test_app/screen/home_screen/widgets/shimmer.dart';
import 'package:provider/provider.dart';
import 'widgets/pinterest_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ImageDataProvider imageDataProvider =
          Provider.of<ImageDataProvider>(context, listen: false);
      imageDataProvider.fetchImageList(context);
    });

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final imageDataProvider =
        Provider.of<ImageDataProvider>(context, listen: false);

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      if (imageDataProvider.canLoadMore) {
        imageDataProvider.fetchImageList(context, isLoadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: _appBar(isDark),
      body: _renderBody(),
    );
  }

 _renderBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
      child: Consumer<ImageDataProvider>(
          builder: (context, imageDataProvider, _) {
        var image = imageDataProvider.imageModel;
        return imageDataProvider.isDataLoading
            ? const ShimmerScreen()
            : imageDataProvider.imageModel.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Image.asset(ImageClass.noDatFound)),
                  )
                : MasonryGridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: image.length + 1,
                    itemBuilder: (context, index) {
                      if (index == imageDataProvider.imageModel.length) {
                        return imageDataProvider.isLoadingMore
                            ? const Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : kHeight(0);
                      }
                      return PinterestCard(
                        index: index,
                        image: image,
                      );
                    },
                  );
      }),
    );
  }

  AppBar _appBar(bool isDark) {
    return AppBar(
      title: Text(
        'Pinterest Layout',
        style: TextStyleClass.primaryFont600(
          22,
          isDark ? AppColors.white : AppColors.black,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(47),
          child: Image.asset(
            ImageClass.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
    );
  }
}
