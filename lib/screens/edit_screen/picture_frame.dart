import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureFrame extends StatelessWidget {
  const PictureFrame({
    Key? key,
    required this.frameHeight,
    required this.frameWith,
    required this.borderCircular,
    required this.textContent,
    required this.onPress,
    required this.imageServer,
    required this.imageFile,
    required this.restaurantId,
  }) : super(key: key);

  final ValueNotifier<File?>? imageFile;
  final double frameHeight;
  final double frameWith;
  final double borderCircular;
  final String textContent;
  final String restaurantId;
  final Function() onPress;
  final String? imageServer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imageFile!.value != null)
            SizedBox(
              width: frameWith,
              height: frameHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderCircular),
                child: Image.file(
                  imageFile!.value!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (imageServer != null && imageFile!.value == null)
            SizedBox(
              width: frameWith,
              height: frameHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderCircular),
                child: Image.network(
                  imageServer!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (imageFile!.value == null && imageServer == null)
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(borderCircular),
              ),
              alignment: Alignment.center,
              width: frameWith,
              height: frameHeight,
              child: Text(textContent),
            ),
        ],
      ),
    );
  }
}
