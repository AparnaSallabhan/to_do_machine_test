import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_machine_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:to_do_machine_test/core/common/entities/user.dart';
import 'package:to_do_machine_test/features/auth/domain/usecase/current_user.dart';
import 'package:to_do_machine_test/features/auth/domain/usecase/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignup userSignup,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignup = userSignup,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    // on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());

      final res = await _userSignup(
        UserParams(email: event.email, passWord: event.passWord),
      );

      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });

    on<AuthIsUserLoggedIn>((event, emit) async {
      emit(AuthLoading());
      final res = await _currentUser();

      res.fold(
        (failure) {
          emit(AuthInitial());
        },
        (user) {
          if (user == null) {
            emit(AuthInitial()); 
          } else {
            _emitAuthSuccess(user, emit);
          }
        },
      );
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
