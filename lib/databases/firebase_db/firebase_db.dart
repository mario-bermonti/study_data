import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cognitive_data/models/db_base.dart';
import 'package:cognitive_data/models/trial.dart';
import 'package:cognitive_data/models/session.dart';
import 'package:cognitive_data/models/device.dart';

/// DB used to store data in Firebase.
/// Requires passing a [FirebaseFirestore] instance at instantiation.
class FirebaseDB implements DB {
  final FirebaseFirestore _db;
  final String participantID;
  final String sessionID;
  String taskName;

  FirebaseDB(
    this._db, {
    required this.participantID,
    required this.sessionID,
    required this.taskName,
  });

  /// Initializes the db with data required by all methods.
  /// Behaves as a constructor to facilitate [FirebaseDB] usage. The params
  /// [participantID], [sessionID], and [taskName] are used by methods to
  /// interact with the db since data is structured hierarchically.
  static FirebaseDB init({
    required participantID,
    required sessionID,
    required taskName,
  }) {
    final FirebaseDB db = FirebaseDB(
      FirebaseFirestore.instance,
      participantID: participantID,
      sessionID: sessionID,
      taskName: taskName,
    );
    return db;
  }

  @override
  void addDevice({required Device device}) {
    // TODO: implement addDevice
  }

  @override
  void addSession({required Session session}) {
    // TODO: implement addSession
  }

  @override
  void addTrial({required Trial trial}) {
    // TODO: implement addTrial
  }

  @override
  void addTrials({required List<Trial> trials}) {
    // TODO: implement addTrials
  }
}
