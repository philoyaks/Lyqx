import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx/core/constants/app_route_paths.dart';
import 'package:lyqx/features/home/presentation/bloc/product_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GoRouter router;
  final ProductsBloc productsBloc; // Add ProductsBloc dependency

  AuthBloc({
    required this.loginUseCase,
    required this.router,
    required this.productsBloc, // Inject through DI
  }) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final users = await loginUseCase.execute(
        event.username,
        event.password,
      );

      final User? user = users
          .where(
            (e) =>
                e.username.toLowerCase() == event.username.toLowerCase() &&
                e.password == event.password,
          )
          .firstOrNull;

      if (user == null) {
        emit(AuthFailure('Invalid User Credential, Please Try again'));
        return;
      }

      emit(AuthSuccess(user));

      router.go(AppRoutePaths.homeRoute);

      // Then trigger products fetch
      productsBloc.add(FetchProducts());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
