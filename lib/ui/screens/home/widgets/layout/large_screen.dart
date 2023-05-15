import 'package:flutter/material.dart';
import 'package:grade/ui/screens/home/bloc/home/home_bloc.dart';
import 'package:grade/ui/screens/home/widgets/home_widget.dart';
import 'package:grade/ui/screens/home/widgets/side_menu.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

class LargeScreen extends StatefulWidget {
  const LargeScreen({super.key});

  @override
  State<LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = true;
  double _menuWidth = 290;

  void _updateSize() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      _menuWidth = _isMenuOpen ? 290 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocSideEffectListener<HomeBloc, HomeCommand>(
      listener: (context, command) {
        if (command is HomeChangeMenuCommand) {
          _updateSize();
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
            child: SideMenu(
              width: _menuWidth,
            ),
          ),
          const Expanded(
            flex: 8,
            child: HomeWidget(),
          ),
        ],
      ),
    );
  }
}
