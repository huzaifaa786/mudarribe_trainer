import 'package:mudarribe_trainer/api/promocode.dart';
import 'package:mudarribe_trainer/models/promocode.dart';
import 'package:mudarribe_trainer/views/promocode/promoCode_view.dart';

class PromoCodeService {
  final _promocodeApi = PromoCodeApi();


  Future<void> createpromocode({required PromoCode promocode}) async {
    await _promocodeApi.createpromocode(promocode);
  }

}