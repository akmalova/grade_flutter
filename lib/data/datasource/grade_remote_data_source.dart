import 'package:grade/domain/model/teacher_model.dart';
import 'package:postgres/postgres.dart';

class GradeRemoteDataSource {
  late final PostgreSQLConnection _connection;

  Future<void> connect({
    required String host,
    required int port,
    required String databaseName,
    required String username,
    required String password,
  }) async {
    _connection = PostgreSQLConnection(
      host,
      port,
      databaseName,
      username: username,
      password: password,
    );
    await _connection.open();
  }

  Future<int> unlockDiscipline(String id) async {
    final result = await _connection.query(
      'SELECT * FROM discipline_clear(@id)',
      substitutionValues: {
        'id': id,
      },
    );
    return result[0][0];
  }

  Future<List<TeacherModel>> getTeachers(
    String lastName,
    String firstName,
    String secondName,
  ) async {
    final result = await _connection.query(
      'SELECT accountid, vt.lastname, vt.firstname, vt.secondname, facultyname, jobpositionname, '
      'email FROM view_teachers vt JOIN accounts a ON a.id = vt.accountid WHERE vt.lastname = @lastname '
      'AND vt.firstname = @firstname AND vt.secondname = @secondname ORDER BY vt.lastname',
      substitutionValues: {
        'lastname': lastName,
        'firstname': firstName,
        'secondname': secondName,
      },
    );

    List<TeacherModel> teachersList = [];
    for (var element in result) {
      teachersList.add(
        TeacherModel(
          id: element[0],
          lastName: element[1],
          firstName: element[2],
          secondName: element[3],
          facultyName: element[4],
          jobPositionName: element[5],
          email: element[6] ?? '',
        ),
      );
    }
    return teachersList;
  }

  Future<int> changeAccess(int id, String userRole) async {
    final result = await _connection.query(
      'SELECT * FROM change_user_role(@id, @userRole)',
      substitutionValues: {
        'id': id,
        'userRole': userRole,
      },
    );
    return result[0][0];
  }

  Future<dynamic> request(
      String functionName, List<String> parameters, List<String> values) async {
    String parametersString = "";
    Map<String, dynamic> valuesMap = {};
    for (int i = 0; i < parameters.length; i++) {
      parametersString += '@${parameters[i]}, ';
      valuesMap[parameters[i]] = values[i];
    }
    // Обрезаем запятую и пробел
    parametersString =
        parametersString.substring(0, parametersString.length - 2);

    final result = await _connection.query(
      'SELECT * FROM $functionName($parametersString)',
      substitutionValues: valuesMap,
    );
    return result[0][0];
  }

  Future<int> transferTeacherData(String idFrom, String idTo) async {
    final result = await _connection.query(
      'SELECT * FROM merge_accounts(@idFrom, @idTo)',
      substitutionValues: {
        'idFrom': idFrom,
        'idTo': idTo,
      },
    );
    return result[0][0];
  }
}