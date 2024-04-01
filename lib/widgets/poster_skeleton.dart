import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PosterSkeletonWidget extends StatelessWidget {
  const PosterSkeletonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Skeletonizer(
              containersColor: Colors.grey,
              enabled: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.replace(
                    width: 200,
                    height: 300,
                    child: Container(
                      width: 200,
                      height: 300,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("text"),
                ],
              ),
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
