import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/sneaker.dart';
import '../../domain/repo/sneakers_repo.dart';

part 'sneakers_state.dart';

class SneakersCubit extends Cubit<SneakersState> {
  final SneakersRepo sneakersRepo;
  final List<Sneaker> sneakers;
  bool isLoadingMore = false;

  get canLoadMore {
    return sneakersRepo.canLoadMore && !isLoadingMore;
  }

  SneakersCubit({
    required this.sneakersRepo,
  })  : sneakers = <Sneaker>[],
        super(
          InitialSneakersState(),
        );

  Future<void> fetchSneakers() async {
    emit(FetchingSneakersState());
    List<Sneaker> newSneakers = await sneakersRepo.retrieveSneakers();
    sneakers.addAll(newSneakers);
    emit(
      SneakersNormalState(
        sneakersList: sneakers,
      ),
    );
  }

  Future loadMoreSneakers() async {
    isLoadingMore = true;
    emit(
      LoadingMoreSneakersState(
        sneakersList: sneakers,
      ),
    );
    List<Sneaker> newSneakers = await sneakersRepo.retrieveSneakers();
    sneakers.addAll(newSneakers);
    emit(
      SneakersNormalState(
        sneakersList: sneakers,
      ),
    );
    isLoadingMore = false;
  }

  Future<void> likeSneaker(String sneakerId) async {
    emit(
      LikingDislikingSneakerState(
        sneakersList: sneakers,
      ),
    );
    await sneakersRepo.likeSneaker(sneakerId);
    emit(
      SneakersNormalState(
        sneakersList: sneakers,
      ),
    );
  }

  Future<void> searchSneakers(
    String newSearchKeyword,
    void Function(List<Sneaker>) setNewFoundValues,
  ) async {
    emit(
      SneakersSearchingState(
        sneakersList: sneakers,
      ),
    );
    setNewFoundValues(await sneakersRepo.searchSneakers(newSearchKeyword));
    emit(
      SneakersNormalState(
        sneakersList: sneakers,
      ),
    );
  }

  void cancelSearch() {
    emit(
      SneakersNormalState(
        sneakersList: sneakers,
      ),
    );
  }

  Future<void> dislikeSneaker(String sneakerId) async {
    emit(
      LikingDislikingSneakerState(
        sneakersList: sneakers,
      ),
    );
    await sneakersRepo.dislikeSneaker(sneakerId);
    emit(
      SneakersNormalState(
        sneakersList: sneakers,
      ),
    );
  }
}
