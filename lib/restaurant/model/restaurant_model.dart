import '../../common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // factory constructor
  // json을 넣기만 하면 자동으로 매핑해줄 수 있도록 하기 위해 만든다.
  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json,
    // json의 값과 restaurant_screen의 item 변수 값은 동일
  }) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      // RestaurantPriceRange의 값의 첫번째 값
      priceRange: RestaurantPriceRange.values.firstWhere(
        (e) => e.name == json['priceRange'], // item['priceRange']와 똑같은 값을 찾음
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
    );
  }
}
