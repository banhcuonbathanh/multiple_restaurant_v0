import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/size_config.dart';
import '../picture_frame.dart';

class PictureFrameWithInfomation extends HookConsumerWidget {
  final Function() onPressImageFile;
  final ValueNotifier<File?> imageFileRestaurant;
  final String imageServer;
  PictureFrameWithInfomation(
      {required this.imageServer,
      required this.imageFileRestaurant,
      required this.onPressImageFile})
      : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var imageFileRestaurant = useState<File?>(null);
    return PictureFrame(
      frameHeight: getProportionateScreenHeight(250),
      frameWith: double.infinity,
      borderCircular: 20,
      textContent: 'Chọn Ảnh',
      onPress: onPressImageFile,
      imageFile: imageFileRestaurant,
      imageServer: imageServer,
      restaurantId: '',
    );
  }
}

class PictureFrame1 extends StatelessWidget {
  const PictureFrame1({
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