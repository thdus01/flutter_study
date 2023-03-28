import 'package:deliveryapp/common/const/data.dart';
import 'package:deliveryapp/product/component/product_card.dart';
import 'package:deliveryapp/restaurant/component/restaurant_card.dart';
import 'package:deliveryapp/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/layout/default_layout.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final res = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return res.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<Map<String, dynamic>>(
          future: getRestaurantDetail(),
          builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData) {
              // 데이터가 없을 경우
              return Center(
                child: CircularProgressIndicator(),  // 로딩 스크린 보이기
              );
            }

            final item = RestaurantDetailModel.fromJson(
                json: snapshot.data!); // 데이터가 있을 경우

            return CustomScrollView(
              slivers: [
                renderTop(model: item),
                renderLabel(),
                renderProducts(
                  products: item.products,
                ),
              ],
            );
          },
        ));
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
  required List<RestaurantProductModel> products,
}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(
                  model: model
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
