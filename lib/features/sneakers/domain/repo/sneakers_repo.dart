import '../entities/sneaker.dart';

abstract class SneakersRepo {
  bool canLoadMore = true;

  Future<List<Sneaker>> retrieveSneakers();
  Future<List<Sneaker>> retrieveTenSneakers();
  Future<void> likeSneaker(String sneakerId);
  Future<void> dislikeSneaker(String sneakerId);
  Future<List<Sneaker>> searchSneakers(String searchKeyword);
}
