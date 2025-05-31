import 'package:flutter/material.dart';
import 'package:medical_sales/features/5-profile/presentation/views/profile_view.dart';
import 'package:medical_sales/features/main/presentation/views/widgets/custom_bottom_navigation_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const routeName = '/main';
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        itemIndex: (int value) {
          selectedIndex = value;
          setState(() {});
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // selectedIndex == 0
            //     ? const CustomAppBarHomeView()
            //     : customAppBar(context, title: 'title'),
            Expanded(child: screens()),
          ],
        ),
      ),
    );
  }

  Widget screens() {
    return [
      Container(),
      Container(),
      Container(),
      ProfileView(),
    ][selectedIndex];
  }
}
