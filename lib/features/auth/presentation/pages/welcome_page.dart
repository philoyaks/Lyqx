import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx/core/constants/app_assets.dart';
import 'package:lyqx/core/di/injection.config.dart';
import 'package:lyqx/core/constants/app_route_paths.dart';
import 'package:lyqx/shared/widgets/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(AppAssets.bgHomeImg),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                width: 58,
                height: 58,
                AppAssets.logoImg,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Fake Store',
                style: TextStyle(
                  color: const Color(0xFF252425),
                  fontSize: 28,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: AppButton(
                    label: 'Login',
                    onPressed: () {
                      getIt<GoRouter>().push(AppRoutePaths.loginRoute);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.28,
              )
            ],
          )
        ],
      ),
    );
  }
}
