import 'package:appgestaoditalia/core/app_colors.dart';
import 'package:appgestaoditalia/core/app_icons.dart';
import 'package:flutter/material.dart';

class BottomNavigatorComponent extends StatelessWidget {
  final List<BottomNavigatorItemComponent> items;
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigatorComponent(
      {Key key,
      @required this.items,
      this.currentIndex = 0,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container( height: 59,alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: AppColors.white,
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: AppColors.white,
        //   width: 15,
        // ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,           
             children: items
                  .map((e) => e.copyWith(
                        isActive: items.indexOf(e) == currentIndex,
                        onTap: () => onTap(items.indexOf(e)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigatorItemComponent extends StatelessWidget {
  final String label;
  final String activeIcon;
  final String icon;
  final bool isActive;
  final Function onTap;

  BottomNavigatorItemComponent copyWith(
      {String label,
      String activeIcon,
      String icon,
      bool isActive,
      Function onTap}) {
    return BottomNavigatorItemComponent(
      label: label ?? this.label,
      activeIcon: activeIcon ?? this.activeIcon,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.activeIcon,
      onTap: onTap ?? this.onTap,
    );
  }

  const BottomNavigatorItemComponent(
      {Key key,
      @required this.label,
      @required this.activeIcon,
      @required this.icon,
      this.isActive = false,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
        child: Column(
          children: [
            AppIcon(isActive ? activeIcon : icon),
            Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal),

            ),
          ],
        ),
      ),
    );
  }
}
