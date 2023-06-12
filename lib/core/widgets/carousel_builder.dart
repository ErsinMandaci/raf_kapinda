import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/enums/image_enums.dart';
import 'package:kartal/kartal.dart';

class PageBuilder extends StatefulWidget {
  const PageBuilder({super.key});

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  late PageController _pageController;
  int activePage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> indicators(int imagesLength, int currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color:
              currentIndex == index ? ColorConst.primaryColor : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }

  List<String> images = [
    ImageEnum.banner.toPng,
    ImageEnum.banner1.toJpg,
    ImageEnum.banner2.toJpg,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: context.dynamicHeight(0.2),
          child: PageView.builder(
            itemCount: images.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, pagePosition) {
              return SizedBox(
                child: Image.asset(images[pagePosition], fit: BoxFit.fill),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(images.length, activePage),
        ),
      ],
    );
  }
}
