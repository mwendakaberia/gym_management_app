
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_bar_gym/models/exercise.dart';

class FirestoreService{

  late String _currentUserId;
  late DocumentReference exerciseRef;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreService(){
    _currentUserId = FirebaseAuth.instance.currentUser!.uid;
    exerciseRef = _firestore.collection('excercise').doc(_currentUserId);
  }

  Future<void> add(Exercise exercise) async {
    await exerciseRef.set(exercise.toMap());
  }

  Future<void> update(Exercise exercise) async {
    await exerciseRef.update(exercise.toMap());
  }

  Future<void> delete() async {
    await exerciseRef.delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllbyDate(DateTime date) {
    //return FirebaseFirestore.instance.collection('excercise').where('date', isEqualTo: date).snapshots();
    return _firestore.collection('excercise').snapshots();
  }

}
