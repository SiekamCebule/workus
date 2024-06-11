import 'package:flutter/material.dart';
import 'package:workus/ui/layouts/main_scaffold/widgets/small/main_page_view.dart';
import 'package:workus/ui/layouts/main_scaffold/widgets/small/main_scaffold_navbar.dart';

class PageViewScaffold extends StatelessWidget {
  const PageViewScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainPageView(),
      bottomNavigationBar: MainScaffoldNavbar(),
    );
  }
}
