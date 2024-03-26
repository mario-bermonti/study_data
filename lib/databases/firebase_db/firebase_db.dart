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
  /// [participantID], [sessionID], and [taskID] are used by methods to
  /// interact with the db since data is structured hierarchically.
  /// [firebaseFirestore] has to be an instance of [FirebaseFirestore],
  /// e.g., FirebaseFirestore.instance.
  static FirebaseDB init(
    FirebaseFirestore firebaseFirestore, {
    required participantID,
    required sessionID,
    required taskID,
  }) {
    final FirebaseDB db = FirebaseDB(
      firebaseFirestore,
      participantID: participantID,
      sessionID: sessionID,
      taskName: taskID,
    );
    return db;
  }

  /// Adds [device] metadata to [FirebaseFirestore].
  /// Stores the [device] metadata in an independent doc inside a collection
  /// named `deviceMetadata`. It will override previous [device] metadata for
  /// the session.
  @override
  Future<void> addDevice({required Device device}) async {
    final Map<String, dynamic> deviceData = {
      'participantID': device.participantID,
      'sessionID': device.sessionID,
      'height': device.height,
      'width': device.width,
      'aspectRatio': device.aspectRatio,
      'platform': device.platform,
    };

    final CollectionReference deviceRef = _db.collection(
        'participants/$participantID/cognitive_tasks/$taskName/sessions/$sessionID/deviceMetadata');

    await deviceRef.doc('deviceMetadata').set(deviceData);
  }

  /// Adds metadata for the [session] to [FirebaseFirestore].
  ///
  /// It will override any data previously saved for the current session. The
  /// current session is determined based on the [participantID], [sessionID],
  /// and [taskName] specified when the [FirebaseDB] was instantiated, and not
  /// from the values in [session].
  @override
  Future<void> addSession({required Session session}) async {
    final Map<String, dynamic> sessionData = {
      'participantID': session.participantID,
      'sessionID': session.sessionID,
      'startTime': session.startTime.toString(),
      'endTime': session.endTime.toString(),
    };

    final CollectionReference sessionRef = _db.collection(
        'participants/$participantID/cognitive_tasks/$taskName/sessions/$sessionID/sessionMetadata');

    await sessionRef.add(sessionData);
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
