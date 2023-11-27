import 'package:mudarribe_trainer/api/post_api.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';

class PostService {
  final _postApi = PostApi();

  Future<void> createPost({required TrainerPost post}) async {
    await _postApi.createPost(post);
  }

  Future<List<TrainerPost>> getTrainerPosts({required trainerId}) async {
    return await _postApi.getTrainerPosts(trainerId);
  }
}
