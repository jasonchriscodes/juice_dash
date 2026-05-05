import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final topPadding = MediaQuery.of(context).padding.top;

    final navHeight = (size.height * 0.075).clamp(58.0, 72.0);
    final buttonSize = (size.width * 0.12).clamp(40.0, 50.0);

    return SafeArea(
      top: false,
      child: Container(
        height: navHeight,
        margin: EdgeInsets.only(
          left: size.width * 0.06,
          right: size.width * 0.06,
          bottom: bottomPadding > 0 ? 8 : 12,
          top: topPadding > 0 ? 8 : 12,
        ),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
        decoration: BoxDecoration(
          color: const Color(0xffb7d97a),
          border: Border.all(
            color: Colors.black.withOpacity(0.7),
            width: 2,
          ),

          // changed here
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navButton(
              index: 0,
              icon: Icons.home_rounded,
              size: buttonSize,
            ),
            _navButton(
              index: 1,
              icon: Icons.shopping_bag_rounded,
              size: buttonSize,
            ),
            _navButton(
              index: 2,
              icon: Icons.history_rounded,
              size: buttonSize,
            ),
            _navButton(
              index: 3,
              icon: Icons.person_rounded,
              size: buttonSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton({
    required int index,
    required IconData icon,
    required double size,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffff7f8a) : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: size * 0.5,
          color: Colors.black87,
        ),
      ),
    );
  }
}
