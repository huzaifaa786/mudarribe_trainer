
import 'package:mudarribe_trainer/api/package_api.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';

class PackageService {
  final _packageApi = PackageApi();

  Future<void> createPackage({required Package package}) async {
    await _packageApi.createPackage(package);
  }

  // Future<List<TrainerPost>> getTrainerPosts({required trainerId}) async {
  //   return await _packageApi.getTrainerPosts(trainerId);
  // }
}
