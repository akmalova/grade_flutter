import 'package:grade/domain/model/page_model.dart';

abstract class PageRepository {
  Future<List<PageModel>> fetchPages();
  Future<void> savePage(PageModel page);
  Future<void> deletePage(int index);
}