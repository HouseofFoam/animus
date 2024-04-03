import 'package:animus/pages/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Animes extends StatelessWidget {
  final int? id;
  final String title;
  final String imageUrl;
  final double? height;
  final double? width;
  final double padding;
  final double borderRadiusRadial;
  final double gapBetween;
  final double? rating;
  final String type;
  const Animes({
    super.key,
    required this.title,
    required this.imageUrl,
    this.width,
    this.height,
    this.padding = 8.0,
    this.borderRadiusRadial = 0,
    this.gapBetween = 8,
    this.rating,
    this.type = "",
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadiusRadial),
            child: GestureDetector(
              onTap: () =>
                  Get.toNamed(DetailPage.route, arguments: {'animeId': id}),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),
          ),
          SizedBox(
            height: gapBetween,
          ),
          tvCheck(type, false),
          SizedBox(
            width: width,
            child: Text(
              title,
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          tvCheck(rating == 0 ? null : rating, true)
        ],
      ),
    );
  }

  tvCheck(dynamic tv, bool isRating) {
    if (tv != null) {
      if (isRating) {
        return Row(
          children: [
            const Icon(
              Icons.star,
              color: Color.fromARGB(255, 196, 118, 2),
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              tv.toString(),
              style: TextStyle(color: isRating ? Colors.black : Colors.grey),
            ),
          ],
        );
      }
      return Text(
        tv,
        style: TextStyle(color: isRating ? Colors.black : Colors.grey),
      );
    }
    return const SizedBox.shrink();
  }
}
