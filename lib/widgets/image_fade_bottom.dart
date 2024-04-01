import 'package:flutter/material.dart';

class MaskImage extends StatelessWidget {
  final String imgUrl;
  final double? height;
  final double? width;
  const MaskImage({super.key, required this.imgUrl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Image.network(
        height: height,
        width: width,
        imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
