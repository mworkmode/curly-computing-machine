import 'package:crypto_app/View/accounts/accounts_screen.dart';
import 'package:crypto_app/View/home/nav_bar_controller.dart';
import 'package:crypto_app/View/home/new_home.dart';
import 'package:crypto_app/View/options/options_screen.dart';
import 'package:crypto_app/View/portfolio/portfolio_screen.dart';
import 'package:crypto_app/View/profile/profile_screen.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    // const Profile(),
    TradingViewChartPage(),
    OptionsScreen(),
    const PortfolioScreen(),
    const AccountsScreen(),
    ProfileScreen(),
  ];

  NavBarController controller = Get.put(NavBarController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: AppColor.kAppDarkGray,
            selectedLabelStyle: const TextStyle(color: Colors.white),
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: ((value) {
              setState(() {
                _currentIndex = value;
              });
            }),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/1.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  label: 'Home',
                  activeIcon: Image.asset(
                    'assets/icons/1.2.png',
                    height: myHeight * 0.03,
                    color: const Color(0xffFBC700),
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/2.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  label: 'Overview',
                  activeIcon: Image.asset(
                    'assets/icons/2.2.png',
                    height: myHeight * 0.03,
                    color: const Color(0xffFBC700),
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/3.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  label: 'Portfolio',
                  activeIcon: Image.asset(
                    'assets/icons/3.2.png',
                    height: myHeight * 0.03,
                    color: const Color(0xffFBC700),
                  )),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.grey,
                  ),
                  label: 'Account',
                  activeIcon: Icon(
                    Icons.account_balance_wallet,
                    color: Color(0xffFBC700),
                  )),
               BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/4.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  label: 'Profile',
                  activeIcon: Image.asset(
                    'assets/icons/4.2.png',
                    height: myHeight * 0.03,
                    color: const Color(0xffFBC700),
                  )),
            ]),
      ),
    );
  }
}
