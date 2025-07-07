part of 'sneakers_cubit.dart';

@immutable
sealed class SneakersState {}

final class InitialSneakersState extends SneakersState {}

final class FetchingSneakersState extends SneakersState {}

final class NoInternetState extends SneakersState {}

final class SneakersNormalState extends SneakersState {
  final List<Sneaker> sneakersList;

  SneakersNormalState({
    required this.sneakersList,
  });
}

final class SneakersSearchingState extends SneakersNormalState {
  SneakersSearchingState({
    required super.sneakersList,
  });
}

final class LoadingMoreSneakersState extends SneakersNormalState {
  LoadingMoreSneakersState({
    required super.sneakersList,
  });
}

final class LoadingMoreSneakersNoInternetConnection extends SneakersNormalState {
  LoadingMoreSneakersNoInternetConnection({
    required super.sneakersList,
  });
}

final class LikingDislikingSneakerState extends SneakersNormalState {
  LikingDislikingSneakerState({
    required super.sneakersList,
  });
}
