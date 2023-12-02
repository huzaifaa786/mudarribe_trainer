
import 'package:mudarribe_trainer/api/package_api.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';

class PackageService {
  final _packageApi = PackageApi();

  Future<void> createPackage({required Package package}) async {
    await _packageApi.createPackage(package);
  }

  Future<List<Package>> getTrainerPackages({required trainerId}) async {
    return await _packageApi.getTrainerPackages(trainerId);
  }

  Future<Package?> getTrainerPackage({required id}) async {
    return await _packageApi.getPackageById(id);
  }
    Future<void> updatePackage({
    required id,
    required Package,
  }) async {
    await _packageApi.updatePackage(id,Package);
  }

   Future<void> deletePackage({
    required id,
  
  }) async {
    await _packageApi.deletePackage(id);
  }
}
