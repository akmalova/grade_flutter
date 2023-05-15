import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/ui/screens/home/bloc/home/home_bloc.dart';
import 'package:grade/ui/screens/home/widgets/layout/large_screen.dart';
import 'package:grade/ui/screens/home/widgets/layout/small_screen.dart';
import 'package:grade/ui/screens/home/widgets/side_menu.dart';
import 'package:grade/ui/utils/responsiveness.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitialState || state is HomeInProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            key: _scaffoldKey,
            drawer: const Drawer(
              child: SideMenu(width: 290),
            ),
            body: ResponsiveWidget(
              largeScreen: const LargeScreen(),
              smallScreen: SmallScreen(scaffoldKey: _scaffoldKey),
            ),
          );
        }
      },
    );
  }
}
