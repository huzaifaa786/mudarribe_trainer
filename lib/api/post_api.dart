import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';
import 'package:mudarribe_trainer/models/trainer_story.dart';

class PostApi {
  static final _firestore = FirebaseFirestore.instance;
  final CollectionReference _trainerPostCollection =
      _firestore.collection("trainer_posts");
  final CollectionReference _trainerStoryCollection =
      _firestore.collection("trainer_stories");

  Future<void> createPost(TrainerPost post) async {
    try {
      await _trainerPostCollection.doc(post.id).set(post.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create post',
        message: e.message,
      );
    }
  }
  Future<void> createStory(TrainerStory story) async {
    try {
      await _trainerStoryCollection.doc(story.id).set(story.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create post',
        message: e.message,
      );
    }
  }

  Future<List<TrainerPost>> getTrainerPosts(trainerId) async {
    try {
      final result = await _trainerPostCollection.get();

      final posts = result.docs
          .map(
            (e) => TrainerPost.fromJson(e.data()! as Map<String, dynamic>),
          )
          .where((item) => item.trainerId == trainerId)
          .toList();

      return posts;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create post',
        message: e.message,
      );
    }
  }
}
