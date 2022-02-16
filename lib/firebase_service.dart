import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCat =
      FirebaseFirestore.instance.collection('mainCategories');

  Future<void> saveCategory(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).set(data);
  }
}
