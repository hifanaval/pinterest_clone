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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    Future.delayed(Duration.zero, () {
      ImageDataProvider imageDataProvider =
          Provider.of<ImageDataProvider>(context, listen: false);
      imageDataProvider.fetchImageList(context);
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
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
      body: _renderBody(isDark),
    );
  }

  Widget _renderBody(bool isDark) {
    return Column(
      children: [
        kHeight(20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: isDark ? AppColors.black : AppColors.white,
            unselectedLabelColor: isDark
                ? AppColors.white.withOpacity(0.5)
                : AppColors.black.withOpacity(0.5),
            indicator: BoxDecoration(
              color: isDark ? AppColors.white : AppColors.black,
              borderRadius: BorderRadius.circular(25),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyleClass.primaryFont500(
                14, isDark ? AppColors.black : AppColors.black),
            tabs: const [
              Tab(text: 'Activity'),
              Tab(text: 'Community'),
              Tab(text: 'Shop'),
            ],
            dividerColor: Colors.transparent,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildActivityTab(isDark),
              _buildEmptyTab('Community', isDark),
              _buildEmptyTab('Shop', isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTab(bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.lightBackground : AppColors.darkBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
        child: Consumer<ImageDataProvider>(
          builder: (context, imageDataProvider, _) {
            var image = imageDataProvider.imageModel;
            if (imageDataProvider.isDataLoading) {
              return const ShimmerScreen();
            }
            if (imageDataProvider.imageModel.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(35.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.asset(ImageClass.noDatFound),
                ),
              );
            }
            return MasonryGridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: image.length + 1,
              itemBuilder: (context, index) {
                if (index == imageDataProvider.imageModel.length) {
                  return imageDataProvider.isLoadingMore
                      ? const Center(child: CupertinoActivityIndicator())
                      : kHeight(0);
                }
                return PinterestCard(
                  index: index,
                  image: image,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyTab(String tabName, bool isDark) {
    return Center(
      child: Text(
        tabName,
        style: TextStyleClass.primaryFont400(
            14, isDark ? AppColors.white : AppColors.black),
      ),
    );
  }

  AppBar _appBar(bool isDark) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      leading: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: isDark ? AppColors.white : AppColors.black,
        size: 18,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                color: isDark ? AppColors.white : AppColors.black,
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                  radius: 24, child: Image.asset(ImageClass.lightLogo)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            width: size.width / 5,
            height: size.height * 0.05,
            decoration: BoxDecoration(
                color: AppColors.red, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                "Follow",
                style: TextStyleClass.primaryFont400(14, AppColors.white),
              ),
            ),
          ),
        )
      ],
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      surfaceTintColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
    );
  }
}
