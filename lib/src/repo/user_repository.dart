import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  static Future<UserModel?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (data.size == 0) {
      return null;
    }
    return UserModel.fromJson(data.docs.first.data());
  }
}
