import 'package:deliveryapp/common/const/data.dart';
import 'package:deliveryapp/restaurant/component/restaurant_card.dart';
import 'package:deliveryapp/restaurant/model/restaurant_model.dart';
import 'package:deliveryapp/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get('http://$ip/restaurant',
    options: Options(
      headers: {
        'authorization': 'Bearer $accessToken',
      }
    ),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding (
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List> (
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if(!snapshot.hasData) {  // 데이터가 있으면
                return Center(
                  child: CircularProgressIndicator(),  // 로딩 창 띄우기
                );
              }
              return ListView.separated(
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    final pItem = RestaurantModel.fromJson(
                        json: item,
                    );
                    // item을 한번 더 parsing 해준다.

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => RestaurantDetailScreen(
                                id: pItem.id,
                              ),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(
                        model: pItem,
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 16.0);
                  },
                  itemCount: snapshot.data!.length,    // 아이템의 갯수
              );

            },
          ),
        ),
      ),
    );
  }
}
