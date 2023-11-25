import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';
import 'package:mudarribe_trainer/services/post_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  final _postService = PostService();

  List<TrainerPost> posts = [];

  RxList<String> gridItems = [
    'assets/images/post1.png',
    'assets/images/post2.png',
    'assets/images/post3.png',
    'assets/images/post4.png',
    'assets/images/post5.png',
    'assets/images/post6.png',
    'assets/images/post1.png',
    'assets/images/post2.png',
    'assets/images/post3.png',
    'assets/images/post4.png',
    'assets/images/post5.png',
    'assets/images/post6.png',
    'assets/images/post4.png',
    'assets/images/post5.png',
    'assets/images/post6.png',
  ].obs;
  String selected = '';
  ontap() {
    print(selected);
    selected = 'click';
    update();
  }

  onclick() {
    print(selected);
    selected = 'click';
    update();
  }

  final _userService = UserService();
  AppUser? currentUser;

  @override
  void onInit() {
    getAppUser();
   
    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
       getTrainerPosts();
    }
    update();
  }

  Future getTrainerPosts() async {
    posts = await _postService.getTrainerPosts(trainerId: currentUser!.id);
    print(posts);
    update();
  }
}
