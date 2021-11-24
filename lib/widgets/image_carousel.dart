import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final bool? isLoading;
  final List<dynamic> imageList;

  const ImageCarousel({Key? key, this.isLoading, required this.imageList})
      : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.isLoading ?? false
          ? [
              const CircularProgressIndicator(),
            ]
          : widget.imageList
              .map(
                (e) => Card(
                  child: Image.network(
                    e,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              )
              .toList(),
    );
  }
}
