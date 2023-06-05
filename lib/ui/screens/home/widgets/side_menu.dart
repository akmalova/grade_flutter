import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/page_model.dart';
import 'package:grade/ui/screens/home/bloc/home/home_bloc.dart';
import 'package:grade/ui/screens/home/bloc/pages/pages_bloc.dart';
import 'package:grade/domain/model/page_types.dart';
import 'package:grade/ui/screens/home/widgets/side_menu_item.dart';
import 'package:grade/ui/screens/home/widgets/side_menu_subitem.dart';
import 'package:grade/ui/common_widgets/grade_text_button.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';

class SideMenu extends StatefulWidget {
  final double width;

  const SideMenu({
    super.key,
    required this.width,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final List<PageModel> _pages = [];
  final List<List<PageModel>> _reports = [[], [], []];
  final List<List<PageModel>> _tasks = [[], [], []];

  @override
  void initState() {
    context.read<PagesBloc>().add(PagesGetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PagesBloc, PagesState>(
      listener: (context, state) {
        if (state is PagesGetDataSuccessState) {
          setState(() {
            _pages.clear();
            _reports.clear();
            _tasks.clear();
            _pages.addAll(state.pages);
            _reports.addAll(state.reports);
            _tasks.addAll(state.tasks);
          });
        }
      },
      child: Container(
        color: AppColors.white,
        width: widget.width,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Администрирование системы "Сервис БРС"',
                    style: TextStyle(
                      color: AppColors.grey2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Отчёты',
                style: TextStyle(color: AppColors.grey2),
              ),
            ),
            const Divider(),
            SideMenuItem(
              icon: const Icon(
                Icons.people,
              ),
              title: PageSections.students,
              children: [
                SideMenuSubitem(
                  title: 'Рабочие планы студента',
                  onTap: () {
                    context.read<HomeBloc>().add(HomeStudyPlansEvent());
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _reports[0].length,
                  itemBuilder: (context, index) {
                    PageModel page = _reports[0][index];
                    return SideMenuSubitem(
                      title: page.pageName,
                      onTap: () {
                        context.read<HomeBloc>().add(HomePatternEvent(page));
                      },
                    );
                  },
                ),
              ],
            ),
            SideMenuItem(
              icon: const Icon(
                Icons.people_alt_outlined,
              ),
              title: PageSections.teachers,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _reports[1].length,
                  itemBuilder: (context, index) {
                    PageModel page = _reports[1][index];
                    return SideMenuSubitem(
                      title: page.pageName,
                      onTap: () {
                        context.read<HomeBloc>().add(HomePatternEvent(page));
                      },
                    );
                  },
                ),
              ],
            ),
            SideMenuItem(
              icon: const Icon(
                Icons.collections_bookmark_outlined,
              ),
              title: PageSections.disciplines,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _reports[2].length,
                  itemBuilder: (context, index) {
                    PageModel page = _reports[2][index];
                    return SideMenuSubitem(
                      title: page.pageName,
                      onTap: () {
                        context.read<HomeBloc>().add(HomePatternEvent(page));
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Задачи',
                style: TextStyle(color: AppColors.grey2),
              ),
            ),
            const Divider(),
            SideMenuItem(
              icon: const Icon(
                Icons.people,
              ),
              title: PageSections.students,
              children: [
                SideMenuSubitem(
                  title: 'Редактировать рабочий план студента',
                  onTap: () {
                    context.read<HomeBloc>().add(HomeEditStudyPlanEvent());
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tasks[0].length,
                  itemBuilder: (context, index) {
                    PageModel page = _tasks[0][index];
                    return SideMenuSubitem(
                      title: page.pageName,
                      onTap: () {
                        context.read<HomeBloc>().add(HomePatternEvent(page));
                      },
                    );
                  },
                ),
              ],
            ),
            SideMenuItem(
              icon: const Icon(
                Icons.people_alt_outlined,
              ),
              title: PageSections.teachers,
              children: [
                SideMenuSubitem(
                  title: 'Изменить право доступа преподавателя',
                  onTap: () {
                    context.read<HomeBloc>().add(HomeChangeAccessEvent());
                  },
                ),
                SideMenuSubitem(
                  title: 'Объединить аккаунты преподавателя',
                  onTap: () {
                    context
                        .read<HomeBloc>()
                        .add(HomeTransferTeacherDataEvent());
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tasks[1].length,
                  itemBuilder: (context, index) {
                    PageModel page = _tasks[1][index];
                    return SideMenuSubitem(
                      title: page.pageName,
                      onTap: () {
                        context.read<HomeBloc>().add(HomePatternEvent(page));
                      },
                    );
                  },
                ),
              ],
            ),
            SideMenuItem(
              icon: const Icon(
                Icons.collections_bookmark_outlined,
              ),
              title: PageSections.disciplines,
              children: [
                SideMenuSubitem(
                  title: 'Разблокировать дисциплину',
                  onTap: () {
                    context.read<HomeBloc>().add(HomeUnlockDisciplineEvent());
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tasks[2].length,
                  itemBuilder: (context, index) {
                    PageModel page = _tasks[2][index];
                    return SideMenuSubitem(
                      title: page.pageName,
                      onTap: () {
                        context.read<HomeBloc>().add(HomePatternEvent(page));
                      },
                    );
                  },
                ),
              ],
            ),
            const Divider(
              height: 40,
            ),
            GradeTextButton(
              title: 'Добавить задачу',
              icon: Icons.add,
              onTap: () {
                context.read<HomeBloc>().add(HomeAddPageEvent());
              },
            ),
            const SizedBox(height: 20),
            GradeTextButton(
              title: 'Удалить задачу',
              icon: Icons.delete,
              onTap: () {
                context.read<HomeBloc>().add(HomeDeletePageEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
