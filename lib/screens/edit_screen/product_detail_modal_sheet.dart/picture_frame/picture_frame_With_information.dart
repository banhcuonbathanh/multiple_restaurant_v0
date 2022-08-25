import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/size_config.dart';
import '../../picture_frame.dart';

class PictureFrameProductDetailWithInfomation extends StatelessWidget {
  final Function() onPressImageFile;
  final ValueNotifier<File?> imageFileRestaurant;
  final String imageServer;
  final Function() longPressToDelete;
  PictureFrameProductDetailWithInfomation(
      {required this.onPressImageFile,
      required this.imageServer,
      required this.imageFileRestaurant,
      required this.longPressToDelete})
      : super();

  @override
  Widget build(BuildContext context) {
    // var imageFileRestaurant = useState<File?>(null);
    return GestureDetector(
      onLongPress: longPressToDelete,
      child: PictureFrame(
        frameHeight: getProportionateScreenHeight(100),
        frameWith: getProportionateScreenWidth(90),
        borderCircular: 20,
        textContent: 'chon anh',
        onPress: onPressImageFile,
        imageFile: imageFileRestaurant,
        imageServer: imageServer,
        restaurantId: '',
      ),
    );
  }
}






 // PictureFrame(
            //   frameHeight: getProportionateScreenHeight(250),
            //   frameWith: double.infinity,
            //   borderCircular: 20,
            //   textContent: 'chon anh',
            //   onPress: () async {
            //     final image =
            //         await ImagePicker().pickImage(source: ImageSource.gallery);

            //     if (image != null) {
            //       imageFileRestaurant.value = File(image.path);
            //     }
            //   },
            //   imageFile: imageFileRestaurant,
            //   imageServer: null,
            //   restaurantId: '',
            // ),
            // restaurant picture