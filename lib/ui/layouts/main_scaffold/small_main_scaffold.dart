import 'package:flutter/material.dart';
import 'package:workus/ui/main_scaffold/small/main_page_view.dart';
import 'package:workus/ui/main_scaffold/small/main_scaffold_navbar.dart';

class SmallMainScaffold extends StatelessWidget {
  const SmallMainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainPageView(),
      bottomNavigationBar: MainScaffoldNavbar(),
    );
  }
}
