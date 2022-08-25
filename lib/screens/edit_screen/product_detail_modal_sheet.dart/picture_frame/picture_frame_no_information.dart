import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/size_config.dart';
import '../../picture_frame.dart';

class PictureFrameProductDetailWithNoInfomation extends StatelessWidget {
  final Function() onPressImageFile;
  final ValueNotifier<File?> imageFileRestaurant;
  PictureFrameProductDetailWithNoInfomation(
      {required this.imageFileRestaurant, required this.onPressImageFile})
      : super();

  @override
  Widget build(BuildContext context) {
    // var imageFileRestaurant = useState<File?>(null);
    return PictureFrame(
      frameHeight: getProportionateScreenHeight(100),
      frameWith: getProportionateScreenWidth(90),
      borderCircular: 20,
      textContent: 'chon anh',
      onPress: onPressImageFile,
      imageFile: imageFileRestaurant,
      imageServer: null,
      restaurantId: '',
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