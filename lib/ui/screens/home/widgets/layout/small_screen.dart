import 'package:flutter/material.dart';
import 'package:grade/ui/screens/home/bloc/home/home_bloc.dart';
import 'package:grade/ui/screens/home/widgets/home_widget.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

class SmallScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SmallScreen({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return BlocSideEffectListener<HomeBloc, HomeCommand>(
      listener: (context, command) {
        if (command is HomeChangeMenuCommand) {
          scaffoldKey.currentState?.openDrawer();
        }
      },
      child: const HomeWidget(),
    );
  }
}
