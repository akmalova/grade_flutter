import 'package:grade/domain/model/page_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageLocalDataSource {
  Future<List<PageModel>> fetchPages() async {
    final box = await Hive.openBox('tasks');
    final List<PageModel> pages = [];
    pages.addAll(box.values.cast());
    return pages;
  }

  Future<List<PageModel>> savePage(PageModel page) async {
    var box = await Hive.openBox('tasks');
    final List<PageModel> pages = [];
    pages.addAll(box.values.cast());
    box.add(page);
    page.save();
    return pages;
  }

  Future<List<PageModel>> deletePage(int index) async {
    final box = await Hive.openBox('tasks');
    final List<PageModel> pages = [];
    pages.addAll(box.values.cast());
    box.delete(box.keyAt(index));
    return pages;
  }
}
