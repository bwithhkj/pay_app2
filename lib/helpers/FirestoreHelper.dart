

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pay_app/models/User.dart';


class FirestoreHelper {
  static final String KEY_USERS = 'Users';
  static final String QUERY_EMAIL = 'email';
  static final String QUERY_PHONE = 'phone';

  // to check user already existance
  static void checkUserAlreadyExist(User user, Function callback, String query) async {
    Firestore firestore = Firestore.instance;

    CollectionReference USERS_COLLECTION = firestore.collection(KEY_USERS);

    Query q = USERS_COLLECTION.where(query, isEqualTo: query == QUERY_EMAIL ? user.email : user.phone);

    QuerySnapshot qs = await q.getDocuments();
    debugPrint('${qs.documents.length}');

    callback.call((qs.documents != null && qs.documents.length > 0));
  }

  static void clearData(User user) async {
    Firestore.instance.collection(KEY_USERS).document(user.email).delete();
  }

  static void updateName(User user, Function callback) async {
    Firestore.instance.collection(KEY_USERS).document(user.email).updateData(user.toMap()).whenComplete(() => callback.call());
  }


  // insert user to firestore database
  static void createUserInDatabase(User user, Function onCompleteCallback, {bool merge}) async {
    Firestore firestore = Firestore.instance;

    CollectionReference USERS_COLLECTION = firestore.collection(KEY_USERS);

    DocumentReference USER = USERS_COLLECTION.document(user.email);

    USER.setData(user.toMap(), merge: merge).whenComplete(() => onCompleteCallback.call());

 //   Common.signedInUser = user;
  }

  static void insertInterestsToUserAccount(User user, Function onComplete) async {
    Firestore firestore = Firestore.instance;
    firestore.collection(KEY_USERS).document(user.email).setData(user.toMap(), merge: true).whenComplete(() => onComplete.call());
  }

  // read user from firestore database
  static Future<User> getUserFromData(FirebaseUser user) async {
    Firestore firestore = Firestore.instance;

    CollectionReference USERS_COLLECTION = firestore.collection(KEY_USERS);

    DocumentReference USER = USERS_COLLECTION.document((user.email != null && user.email.length > 0) ? user.email : user.phoneNumber);

    DocumentSnapshot userData = await USER.get();

    User signedInUser = User.fromMap(userData.data);

  //  Common.signedInUser = signedInUser;

    return signedInUser;
  }


}