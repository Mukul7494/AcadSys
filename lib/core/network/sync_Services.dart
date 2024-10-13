import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box _userBox = Hive.box('userBox');

  // void initialize() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result != ConnectivityResult.none) {
  //       _syncData();
  //     }
  //   });
  // }

  Future<void> _syncData() async {
    final String? userId = _userBox.get('userId');
    if (userId != null) {
      // Sync user data
      final userData = _userBox.get('userData');
      if (userData != null) {
        await _firestore.collection('users').doc(userId).update(userData);
      }

      // Sync other data (e.g., assignments, grades)
      // Implement your sync logic here
    }
  }
}
