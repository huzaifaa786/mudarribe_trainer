

class AddPackageApi {


 Future<void> addpackage() async {
    if (areFieldsFilled.value) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        DocumentReference promoCodeRef = firestore.collection('packages').doc();

        Map<String, dynamic> data = {
          'id': currentUser!.id,
          'packagename': packagenameController.text,
          'price': priceController.text,
          'duration': durationController.text,
          'discription': discriptionController.text,
          'categary': categary
        };
        await promoCodeRef.set(data);
        packagenameController.clear();
        priceController.clear();
        durationController.clear();
        discriptionController.clear();
      } catch (error) {
        print('Error storing promo code: $error');
      }
    }
  }
}