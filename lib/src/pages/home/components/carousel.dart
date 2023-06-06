import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  final String drugType;

  const ImageCarousel({
    super.key,
    required this.drugType,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    CarouselController controller = CarouselController();

    return CarouselSlider(
      items: [
        1,
        2,
        3,
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image(
              image: AssetImage(
                'assets/images/${widget.drugType}$i.jpg',
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 240.0,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        enableInfiniteScroll: true,
        viewportFraction: 0.88,
        autoPlay: true,
      ),
      carouselController: controller,
    );
  }
}
