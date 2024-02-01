import 'trial_type.dart';

/// Serves as the design contract between the different implementations of
/// the databases.
abstract class DB {
  void addSessionMetadata({
    required String sessionID,
    required String participantId,
    required DateTime timeStart,
    required DateTime timeEnd,
  }) {}

  void addDevice({
    required String sessionID,
    required String participantId,
  }) {}

  void addTrial({
    required String sessionID,
    required String participantId,
    required String stim,
    required String resp,
    required TrialType trialType,
  }) {}

  void initDB() {}
}