import '../constants/sneaker_constants.dart';
import 'sneaker_color.dart';

class Sneaker {
  int likes;
  int yearOfRelease;
  double price;
  String? id;
  String name;
  String companyName;
  String description;
  List<String> sizes;
  List<SneakerColor> colors;

  Sneaker({
    required this.likes,
    required this.yearOfRelease,
    required this.description,
    required this.price,
    required this.name,
    required this.companyName,
    this.id,
  })  : sizes = <String>[],
        colors = <SneakerColor>[];

  factory Sneaker.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    Sneaker newSneaker = Sneaker(
      yearOfRelease: map[kSneakerYearOfReleaseFieldName],
      likes: map[kSneakerLikesFieldName],
      description: map[kSneakerDescriptionFieldName],
      price: map[kSneakerPriceFieldName],
      name: map[kSneakerNameFieldName],
      companyName: map[kSneakerCompanyNameFieldName],
      id: id,
    );

    for (dynamic size in (map[kSizesFieldName] as List<dynamic>)) {
      newSneaker.sizes.add(size as String);
    }

    return newSneaker;
  }
}
