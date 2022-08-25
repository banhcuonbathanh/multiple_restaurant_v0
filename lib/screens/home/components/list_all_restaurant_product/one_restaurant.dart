import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/model/restaurant_model.dart';

class OneRestaurant extends StatelessWidget {
  final RestaurantModel restaurantData;
  OneRestaurant({
    required this.restaurantData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('build OneRestaurant ');
    // print(restaurantData);
    return restaurantData == null
        ? Text('khong co nha hang')
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    restaurantData.restaurantImage!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // Text(' Nhà Hàng : ${restaurantData.restaurantName!}'),
              Text(' Địa Chỉ : ${restaurantData.restaurantAdrress!}'),
              Text(
                  'thoi gian phuc vu: ${restaurantData.restaurantStartTime} - ${restaurantData.restaurantEndingTime}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RatingBar.builder(
                      minRating: 1,
                      itemSize: 17,
                      updateOnDrag: true,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Colors.yellowAccent,
                        );
                      },
                      onRatingUpdate: (rating) {}),
                  Text('binh luan 20'),
                  Text('|'),
                  Icon(Icons.punch_clock),
                  Text('${restaurantData.restaurantMealPreparation} phut'),
                ],
              ),
            ],
          );
  }
}
