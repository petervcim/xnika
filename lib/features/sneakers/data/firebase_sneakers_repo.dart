import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xnika/features/sneakers/domain/entities/sneaker.dart';

import '../domain/constants/sneaker_constants.dart';
import '../domain/entities/sneaker_color.dart';
import '../domain/entities/sneaker_image.dart';
import '../domain/repo/sneakers_repo.dart';

// ignore: camel_case_types
typedef string = String;

class FirebaseSneakersRepo implements SneakersRepo {
  @override
  bool canLoadMore = true;

  FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;

  Future<List<Sneaker>> _createSneakerListFromDocumentSnapshots(List<QueryDocumentSnapshot<Map<String, dynamic>>> sneakerDocumentSnapshots) async {
    List<Sneaker> sneakers = [];

    List<Future> getSneakerTasks = <Future>[];

    for (DocumentSnapshot<Map<String, dynamic>> sneakerDocumentSnapshot in sneakerDocumentSnapshots) {
      Map<String, dynamic> sneakerProperties = sneakerDocumentSnapshot.data()!;

      getSneakerTasks.add(
        Future(
          () async => sneakers.add(
            await generateSneakerFromDocumentSnapshot(
              sneakerProperties,
              sneakerDocumentSnapshot.id,
            ),
          ),
        ),
      );
    }

    await Future.wait(getSneakerTasks);

    return sneakers;
  }

  static Future<Sneaker> generateSneakerFromDocumentSnapshot(Map<String, dynamic> sneakerProperties, String sneakerDocumentReferenceId) async {
    Sneaker newSneaker = Sneaker.fromMap(
      sneakerProperties,
      sneakerDocumentReferenceId,
    );

    List<Future> tasksToComplete = <Future>[];

    List<dynamic> sneakerColorDocumentIds = (sneakerProperties[kSneakerColorsFieldName] as List<dynamic>);

    for (String sneakerColorDocumentId in sneakerColorDocumentIds) {
      DocumentReference<Map<String, dynamic>> sneakerColorDocumentReference = FirebaseFirestore.instance.collection(kSneakerColorsCollectionName).doc(sneakerColorDocumentId);
      DocumentSnapshot<Map<String, dynamic>> sneakerColorDocumentSnapshot = await sneakerColorDocumentReference.get();

      Map<String, dynamic> sneakerColorProperties = sneakerColorDocumentSnapshot.data()!;

      SneakerColor newSneakerColor = SneakerColor.fromMap(
        sneakerColorDocumentSnapshot.id,
        sneakerColorProperties,
      );

      List<dynamic> sneakerColorImageIds = (sneakerProperties[kSneakerColorImagesFieldName] as List<dynamic>);

      for (int index = 0; index < sneakerColorImageIds.length; index++) {
        if (index == 0) {
          newSneakerColor.sneakerImages.add(
            await getSneakerImage(
              sneakerColorImageIds[index],
            ),
          );
          continue;
        }
        tasksToComplete.add(
          Future(
            () async => newSneakerColor.sneakerImages.add(
              await getSneakerImage(
                sneakerColorImageIds[index],
              ),
            ),
          ),
        );
      }
    }

    await Future.wait(tasksToComplete);

    return newSneaker;
  }

  static Future<SneakerImage> getSneakerImage(String sneakerImageDocumentReferenceId) async {
    CollectionReference<Map<String, dynamic>> sneakerImagesCollectionReference = FirebaseFirestore.instance.collection(kSneakersImagesCollectionName);
    DocumentReference<Map<String, dynamic>> sneakerImagesDocumentReference = sneakerImagesCollectionReference.doc(sneakerImageDocumentReferenceId);

    DocumentSnapshot<Map<String, dynamic>> sneakerImageDocumentSnapshot = await sneakerImagesDocumentReference.get();
    Map<String, dynamic> sneakerImageProperties = sneakerImageDocumentSnapshot.data()!;

    return SneakerImage(
      height: sneakerImageProperties[kSneakerImageHeightFieldName],
      width: sneakerImageProperties[kSneakerImageWidthFieldName],
      url: sneakerImageProperties[kSneakerImageUrlFieldName],
    );
  }

  DocumentSnapshot<Map<String, dynamic>>? lastFetchedDocument;

  @override
  Future<List<Sneaker>> retrieveSneakers() async {
    Query<Map<String, dynamic>> sneakersFetchingQuery = firebaseFirestoreInstance
        .collection(
          kSneakersFirestoreCollectionName,
        )
        .orderBy(
          kSneakerCreatedOnFieldName,
        )
        .limit(
          kSneakersFetchingLimit,
        );

    // start after the last document
    if (lastFetchedDocument != null) {
      sneakersFetchingQuery = sneakersFetchingQuery.startAfterDocument(
        lastFetchedDocument!,
      );
    }

    QuerySnapshot<Map<String, dynamic>> sneakersQuerySnapshot = await sneakersFetchingQuery.get();

    if (sneakersQuerySnapshot.docs.isNotEmpty) {
      lastFetchedDocument = sneakersQuerySnapshot.docs.last;
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> sneakerDocumentSnapshots = sneakersQuerySnapshot.docs;
    canLoadMore = sneakersQuerySnapshot.docs.length >= kSneakersFetchingLimit;

    return _createSneakerListFromDocumentSnapshots(sneakerDocumentSnapshots);
  }

  @override
  Future<List<Sneaker>> retrieveTenSneakers() async {
    List<Sneaker> sneakers = [];
    return sneakers;
  }

  @override
  Future<void> dislikeSneaker(String sneakerId) async {
    DocumentReference sneakerDocumentReference = firebaseFirestoreInstance.collection(kSneakersFirestoreCollectionName).doc(sneakerId);
    await sneakerDocumentReference.update(<String, dynamic>{
      kSneakerLikesFieldName: FieldValue.increment(
        kSneakerLikesDecrementValue,
      ),
    });
  }

  @override
  Future<void> likeSneaker(String sneakerId) async {
    DocumentReference sneakerDocumentReference = firebaseFirestoreInstance.collection(kSneakersFirestoreCollectionName).doc(sneakerId);
    await sneakerDocumentReference.update(<String, dynamic>{
      kSneakerLikesFieldName: FieldValue.increment(
        kSneakerLikesIncrementValue,
      ),
    });
  }

  @override
  Future<List<Sneaker>> searchSneakers(String searchKeyword) async {
    List<Sneaker> foundSneakers = <Sneaker>[];

    if (searchKeyword.isEmpty) {
      return [];
    }

    CollectionReference<Map<String, dynamic>> sneakersCollectionReference = firebaseFirestoreInstance.collection(
      kSneakersFirestoreCollectionName,
    );
    QuerySnapshot<Map<String, dynamic>> foundSneakersQuerySnapshot = await sneakersCollectionReference
        .where(
          kSneakersSearchKeywords,
          arrayContains: searchKeyword,
        )
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot in foundSneakersQuerySnapshot.docs) {
      foundSneakers.add(
        await generateSneakerFromDocumentSnapshot(
          documentSnapshot.data(),
          documentSnapshot.id,
        ),
      );
    }

    return foundSneakers;
  }
}
