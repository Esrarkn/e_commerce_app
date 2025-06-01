import 'package:e_commerce_app/ui/tools/appColors.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CustomBottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: textColor2,
        indicatorColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(color: mainColor);
          }
          return TextStyle(color: textColor1);
        }),
        iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(color: mainColor);
          }
          return IconThemeData(color: textColor1);
        }),
      ),
      child: NavigationBar(
        height: 50,
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: widget.onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 23),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border, size: 23),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined, size: 23),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, size: 23),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
