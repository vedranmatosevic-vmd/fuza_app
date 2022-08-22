import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuza_app/screens/games/games_screen.dart';
import 'package:fuza_app/screens/member_fee/member_fee_screen.dart';
import 'package:fuza_app/screens/players/players_screen.dart';

import '../../size_config.dart';
import '../../style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.colorBlue,
        centerTitle: true,
        title: Text(
          "Futsal škola Zagi",
          style: Style.getTextStyle(context, StyleText.bodyTwoMedium, StyleColor.white),
        ),
      ),
      backgroundColor: Style.colorLightGray,
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          iconPath: "assets/icons/ic_fees.svg",
          title: Text('Članarine'),
        ),
        BottomNavyBarItem(
          iconPath: "assets/icons/ic_players.svg",
          title: Text('Igrači'),
        ),
        BottomNavyBarItem(
          iconPath: "assets/icons/ic_games.svg",
          title: Text(
            'Utakmice ',
          ),
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> screens = [
      MemberFeeScreen(),
      PlayersScreen(),
      GamesScreen(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: screens,
    );
  }
}


class CustomAnimatedBottomBar extends StatelessWidget {
  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 28,
    this.itemCornerRadius = 60,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 200),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  }) : super(key: key);

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Style.colorWhite,
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? getProportionateScreenWidth(130.0) : getProportionateScreenWidth(50.0),
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
          isSelected ? Style.colorLightGray : null,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? getProportionateScreenWidth(130.0) : getProportionateScreenWidth(50.0),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  item.iconPath,
                  width: iconSize,
                  height: iconSize,
                  color: isSelected
                      ? Style.colorBlue
                      : Style.colorDarkGray,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: Style.getTextStyle(context, StyleText.bodyFiveBold, StyleColor.blue),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {

  BottomNavyBarItem({
    required this.iconPath,
    required this.title,
  });

  final String iconPath;
  final Widget title;
}