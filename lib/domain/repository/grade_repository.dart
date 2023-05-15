import 'package:grade/domain/model/teacher_model.dart';

abstract class GradeRepository {
  Future<void> connect({
    required String host,
    required int port,
    required String databaseName,
    required String username,
    required String password,
  });
  Future<int> unlockDiscipline(String id);
  Future<List<TeacherModel>> getTeachers(
    String lastName,
    String firstName,
    String secondName,
  );
  Future<int> changeAccess(int id, String userRole);
  Future<dynamic> request(
    String functionName,
    List<String> parameters,
    List<String> values,
  );
  Future<int> transferTeacherData(String idFrom, String idTo);
}
