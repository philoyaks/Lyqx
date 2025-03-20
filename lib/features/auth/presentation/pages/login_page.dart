import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx/core/di/injection.config.dart';
import 'package:lyqx/core/constants/app_route_paths.dart';
import 'package:lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lyqx/shared/widgets/app_button.dart';
import 'package:lyqx/shared/widgets/app_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  getIt<GoRouter>().push(AppRoutePaths.welcomeRoute);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 41,
                    height: 41,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFE8ECF4),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xff1E232C),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Text(
                'Welcome back! Glad\nto see you, Again!',
                style: TextStyle(
                  color: const Color(0xFF1E232C),
                  fontSize: 30,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  height: 1.30,
                  letterSpacing: -0.30,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              AppTextField(
                controller: usernameController,
                labelText: 'Enter your username',
              ),
              SizedBox(
                height: 15,
              ),
              AppTextField(
                controller: passwordController,
                labelText: 'Enter your password',
                isPassword: true,
              ),
              SizedBox(
                height: 30,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: AppButton(
                      label: 'Login',
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginSubmitted(
                                username: usernameController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
