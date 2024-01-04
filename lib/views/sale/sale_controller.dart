import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/models/order.dart';
import 'package:table_calendar/table_calendar.dart';

class SaleController extends GetxController {
  static SaleController instance = Get.find();
  CalendarFormat format = CalendarFormat.month;
  var format1 = 'month';
  DateTime ourdate = DateTime.now();
  DateTime today = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;

  void onFormatChanged(DateTime date) {
    today = date;
    ourdate = date;
    getsale();
    update();
  }

  void onDaySelected(DateTime day, DateTime foucsedDay) async {
    today = day;
    ourdate = day;
    getsale();
    update();
  }

  void onRangeSelected(start, end, focusedDay) {
    rangeStart = start;
    rangeEnd = end;
    today = focusedDay;
    ourdate = focusedDay;
    if (end == null) {
      getsale();
    } else {
      getSalesBySelectedRange(start, end);
    }
    update();
  }

  List<TrainerOrder> orders = <TrainerOrder>[].obs;

  Future<void> fetchSale(id) async {
    try {
      // LoadingHelper.show();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('trainerId', isEqualTo: id)
          // .where('status', isEqualTo: 3)
          .get();

      List<TrainerOrder> fetchSale = querySnapshot.docs.map((doc) {
        print('List<TrainerOrder>');
        return TrainerOrder.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      orders = <TrainerOrder>[].obs;
      orders = fetchSale;
      getsale();
      update();
      // LoadingHelper.dismiss();
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  int sum = 0;

  int getsale() {
    List<TrainerOrder> fetchSales;
    fetchSales = orders;
    sum = 0;
    for (var sale in fetchSales) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(sale.id));
      DateTime formattedDate =
          DateTime.utc(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0);
      DateTime formattedTodate =
          DateTime.utc(today.year, today.month, today.day, 0, 0, 0, 0);
      if (formattedDate.toUtc() == formattedTodate.toUtc()) {
        sum += sale.amount!;
      }
    }
    update();
    return sum;
  }

  int getSalesBySelectedRange(DateTime startDate, DateTime endDate) {
    List<TrainerOrder> fetchSales = orders;
    // print(fetchSales);
    sum = 0;
    DateTime formattedStartDate = DateTime.utc(
        startDate.year, startDate.month, startDate.day, 0, 0, 0, 0);
    DateTime formattedEndDate =
        DateTime.utc(endDate.year, endDate.month, endDate.day, 0, 0, 0, 0);
    for (var sale in fetchSales) {
      DateTime saleDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(sale.id));
      DateTime formattedSaleDate =
          DateTime.utc(saleDate.year, saleDate.month, saleDate.day, 0, 0, 0, 0);
      if ((formattedSaleDate.isAfter(formattedStartDate) ||
              formattedSaleDate.isAtSameMomentAs(formattedStartDate)) &&
          (formattedSaleDate.isBefore(formattedEndDate) ||
              formattedSaleDate.isAtSameMomentAs(formattedEndDate))) {
        sum += sale.amount!;
      }
    }
    update();
    print(sum);
    return sum;
  }

  clear() {
    ourdate = DateTime.now();
    today = DateTime.now();
    sum = 0;
    rangeStart = null;
    rangeEnd = null;
    orders = [];
    update();
  }
}
