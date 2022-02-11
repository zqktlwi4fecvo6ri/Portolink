part of 'services.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference uCollection = FirebaseFirestore.instance.collection('Users');
  static String convertToTitleCase(String text) {
    final List<String> words = text.split(' ');
    final cap = words.map((word) {
      final String first = word.trim().substring(0, 1).toUpperCase();
      final String remain = word.trim().substring(1).toLowerCase();
      return '$first$remain';
    });
    return cap.join(' ');
  }
  static Future<String> signUp(Users users) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    String msg = '';
    final String token;
    final String uid;
    try {
      final UserCredential uCredential = await auth.createUserWithEmailAndPassword(email: users.email, password: users.password);
      uid = uCredential.user!.uid;
      token = (await FirebaseMessaging.instance.getToken())!;
      await uCollection.doc(uid).set({
        'UID': uid,
        'Photo': '-',
        'Name': convertToTitleCase(users.name),
        'Phone': users.phone.replaceAll(' ', ''),
        'Email': users.email.replaceAll(' ', '').toLowerCase(),
        'Password': sha512.convert(utf8.encode(sha512.convert(utf8.encode(users.password)).toString())).toString(),
        'Token': token,
        'Administrator': false,
        'Created': dateNow,
        'Updated': '-',
        'Entered': '-',
        'Left': '-'
      }).then((value) => msg = 'Signed');
      await auth.currentUser!.updatePhotoURL(users.photo);
      await auth.currentUser!.updateDisplayName(convertToTitleCase(users.name));
      return msg;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        msg = 'Existed';
      }
      else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
      }
      else if (e.code == 'weak-password') {
        msg = 'Invalid Pass';
      }
      else if (e.code == 'operation-not-allowed') {
        msg = 'Disabled';
      }
    }
    return msg;
  }
  static Future<String> signIn(String email, String password) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    String msg = '';
    final String token;
    final String uid;
    try {
      final UserCredential uCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      uid = uCredential.user!.uid;
      token = (await FirebaseMessaging.instance.getToken())!;
      await uCollection.doc(uid).update({
        'Is On': true,
        'Token': token,
        'Entered': dateNow
      }).then((value) => msg = 'Granted');
      return msg;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        msg = 'None';
      }
      else if (e.code == 'wrong-password') {
        msg = 'Hacker';
      }
      else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
      }
      else if (e.code == 'user-disabled') {
        msg = 'Disabled';
      }
      else if (e.code == 'not-found') {
        msg = 'Denied';
      }
    }
    return msg;
  }
  static Future<dynamic> getUser() async {
    final String uid = auth.currentUser!.uid;
    return await uCollection.doc(uid).get().then((DocumentSnapshot doc) async {
      final Users users = Users(
        doc['Photo'],
        doc['Name'],
        doc['Phone'],
        doc['Email'],
        doc['Password']
      );
      return users;
    });
  }
  static Future<String> updateAccount(Users users) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    String msg = '';
    final String uid = auth.currentUser!.uid;
    try {
      await auth.currentUser!.updateDisplayName(convertToTitleCase(users.name));
      await auth.currentUser!.updateEmail(users.email.replaceAll(' ', '').toLowerCase());
      await uCollection.doc(uid).update({
        'Name': convertToTitleCase(users.name),
        'Phone': users.phone.replaceAll(' ', ''),
        'Email': users.email.replaceAll(' ', '').toLowerCase(),
        'Updated': dateNow
      }).then((value) => msg = 'Granted');
      return msg;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        msg = 'Existed';
      }
      else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
      }
      else if (e.code == 'requires-recent-login') {
        msg = 'Relog';
      }
    }
    return msg;
  }
  static Future<bool> signOut() async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    final String uid = auth.currentUser!.uid;
    await auth.signOut().whenComplete(() {
      uCollection.doc(uid).update({
        'Is On': false,
        'Token': '-',
        'Left': dateNow
      });
    });
    return true;
  }
  static Future<bool> deleteAccount() async {
    await Firebase.initializeApp();
    final String uid = auth.currentUser!.uid;
    uCollection.doc(uid).delete();
    auth.currentUser!.delete();
    return true;
  }
}