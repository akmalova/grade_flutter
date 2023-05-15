import 'package:grade/data/datasource/page_local_data_source.dart';
import 'package:grade/domain/model/page_model.dart';
import 'package:grade/domain/repository/page_repository.dart';

class PageRepositoryImpl extends PageRepository {
  final PageLocalDataSource pageLocalDataSource;

  PageRepositoryImpl(this.pageLocalDataSource);

  @override
  Future<void> deletePage(int index) async {
    pageLocalDataSource.deletePage(index);
  }

  @override
  Future<List<PageModel>> fetchPages() async {
    return await pageLocalDataSource.fetchPages();
  }

  @override
  Future<void> savePage(PageModel page) async {
    pageLocalDataSource.savePage(page);
  }
}
