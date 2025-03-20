import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx/core/constants/app_assets.dart';
import 'package:lyqx/core/di/injection.config.dart';
import 'package:lyqx/core/constants/app_route_paths.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF252425),
            fontSize: 24,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
        ),
        GestureDetector(
          onTap: () {
            getIt<GoRouter>().go(AppRoutePaths.loginRoute);
          },
          child: Column(
            children: [
              SvgPicture.asset(AppAssets.logOutIcon),
              Text(
                'Log out',
                style: TextStyle(
                  color: const Color(0xFF3A3A3A),
                  fontSize: 12,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  height: 1.33,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
