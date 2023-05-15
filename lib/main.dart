import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade/domain/locator/locator.dart';
import 'package:grade/domain/repository/page_repository.dart';
import 'package:grade/ui/screens/home/bloc/home/home_bloc.dart';
import 'package:grade/ui/screens/home/bloc/pages/pages_bloc.dart';
import 'package:grade/ui/screens/home/home_screen.dart';
import 'package:grade/ui/utils/constants/app_colors.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then(
    (value) async {
      await WindowManager.instance.setMinimumSize(const Size(500, 500));
      await WindowManager.instance.maximize();
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1536, 800),
      builder: (context, child) {
        return MaterialApp(
          title: 'Grade',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.grey,
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.mulishTextTheme(),
          ),
          home: child,
        );
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc()..add(HomePageOpenedEvent()),
          ),
          BlocProvider<PagesBloc>(
            create: (BuildContext context) => PagesBloc(getIt<PageRepository>()),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
