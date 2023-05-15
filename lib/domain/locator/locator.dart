import 'package:get_it/get_it.dart';
import 'package:grade/data/datasource/grade_remote_data_source.dart';
import 'package:grade/data/datasource/page_local_data_source.dart';
import 'package:grade/data/repository/grade_repository_impl.dart';
import 'package:grade/data/repository/page_repository_impl.dart';
import 'package:grade/domain/model/page_adapter.dart';
import 'package:grade/domain/repository/grade_repository.dart';
import 'package:grade/domain/repository/page_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initGradeRepository();
  await _initPageRepository();
  _initHive();
}

Future<void> _initGradeRepository() async {
  GradeRemoteDataSource gradeRemoteDataSource = GradeRemoteDataSource();
  GradeRepositoryImpl gradeRepository = GradeRepositoryImpl(gradeRemoteDataSource);
  getIt.registerSingleton<GradeRepository>(gradeRepository);
}

Future<void> _initPageRepository() async {
  PageLocalDataSource pageLocalDataSource = PageLocalDataSource();
  PageRepositoryImpl pageRepository = PageRepositoryImpl(pageLocalDataSource);
  getIt.registerSingleton<PageRepository>(pageRepository);
}

Future<void> _initHive() async {
  Hive.init('./');
  Hive.registerAdapter(PageAdapter());
}
