import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/history_model.dart';

class FirestoreProvider {
  final movies = FirebaseFirestore.instance.collection('history');

  Future<void> newProgress({required HistoryModel history}) async {
    try {
      await movies.doc(history.key).set(history.newToDocument());
    } catch (e) {
      log('Erro 21 ${e.toString()}');
    }
  }

  Future<bool> getProgressExistance({required String key}) async {
    var doc = await movies.doc(key).get();
    return doc.exists;
  }

  Future<void> updateProgress({required HistoryModel history}) async {
    try {
      bool exists = await getProgressExistance(key: history.key);
      if(exists) {
        await movies.doc(history.key).update(history.updateToDocument());
      } else {
        await movies.doc(history.key).set(history.newToDocument());
      }
    } catch (e) {
      log('Erro 12 ${e.toString()}');
    }
  }

  Stream<List<HistoryModel>> getHistoryStream() {
    return movies.orderBy('updatedAt', descending: true).snapshots().map(
        (docs) => docs.docs.map((e) => HistoryModel.fromSnapshot(e)).toList());
  }
}
