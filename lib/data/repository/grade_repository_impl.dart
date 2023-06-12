import 'package:grade/data/datasource/grade_remote_data_source.dart';
import 'package:grade/domain/model/study_plan_model.dart';
import 'package:grade/domain/model/teacher_model.dart';
import 'package:grade/domain/repository/grade_repository.dart';

class GradeRepositoryImpl extends GradeRepository {
  final GradeRemoteDataSource gradeRemoteDataSource;

  GradeRepositoryImpl(this.gradeRemoteDataSource);

  @override
  Future<int> changeAccess(int id, String userRole) async {
    return gradeRemoteDataSource.changeAccess(id, userRole);
  }

  @override
  Future<String?> connect({
    required String host,
    required int port,
    required String databaseName,
    required String username,
    required String password,
  }) async {
    return gradeRemoteDataSource.connect(
      host: host,
      port: port,
      databaseName: databaseName,
      username: username,
      password: password,
    );
  }

  @override
  Future<List<TeacherModel>> getTeachers(
    String lastName,
    String firstName,
    String secondName,
  ) async {
    return gradeRemoteDataSource.getTeachers(lastName, firstName, secondName);
  }

  @override
  Future<dynamic> request(
    String functionName,
    List<String> parameters,
    List<String> values,
  ) async {
    return gradeRemoteDataSource.request(functionName, parameters, values);
  }

  @override
  Future<int> unlockDiscipline(String id) async {
    return gradeRemoteDataSource.unlockDiscipline(id);
  }

  @override
  Future<int> transferTeacherData(String idFrom, String idTo) async {
    return gradeRemoteDataSource.transferTeacherData(idFrom, idTo);
  }

  @override
  Future<int> editStudyPlan(
    String recordBookId,
    String studyPlanIdFrom,
    String studyPlanIdTo,
    String year,
  ) {
    return gradeRemoteDataSource.editStudyPlan(
      recordBookId,
      studyPlanIdFrom,
      studyPlanIdTo,
      year,
    );
  }

  @override
  Future<List<StudyPlanModel>> getPlans(String recordBookId) {
    return gradeRemoteDataSource.getPlans(recordBookId);
  }
}
