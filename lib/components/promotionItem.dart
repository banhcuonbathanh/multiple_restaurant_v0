import 'package:flutter/material.dart';

import '../size_config.dart';

class PromotionItem extends StatelessWidget {
  const PromotionItem({
    Key? key,
    required this.promotionList,
    required this.picture,
    required this.pictureWith,
    required this.pictureHeight,
    this.padding,
  }) : super(key: key);

  // final RestaurantModel promotionRestaurant;
  final List<int?> promotionList;
  final String picture;
  final double pictureWith;
  final double pictureHeight;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    // final promotionList = promotionRestaurant.promotionList!;
    promotionList.sort();

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              getProportionateScreenWidth(padding == null ? 10 : padding!)),
      child: Stack(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(pictureWith),
            height: getProportionateScreenHeight(pictureHeight),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (promotionList.length > 0)
            Positioned(
              right: getProportionateScreenWidth(0),
              top: getProportionateScreenHeight(0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(17)),
                child: Text(promotionList.last.toString() + ' %',
                    style: TextStyle(
                      backgroundColor: Colors.orange.withOpacity(0.7),
                      fontSize: 15,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 7.0,
                          color: Colors.white,
                          offset: Offset(0, 0),
                        ),
                      ],
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
