import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_machine_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:to_do_machine_test/core/network/connection_checker.dart';
import 'package:to_do_machine_test/core/secrets/app_secrets.dart';
import 'package:to_do_machine_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:to_do_machine_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:to_do_machine_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:to_do_machine_test/features/auth/domain/usecase/current_user.dart';
import 'package:to_do_machine_test/features/auth/domain/usecase/user_signup.dart';
import 'package:to_do_machine_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:to_do_machine_test/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:to_do_machine_test/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:to_do_machine_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_machine_test/features/todo/domain/usecase/get_all_todos.dart';
import 'package:to_do_machine_test/features/todo/domain/usecase/update_todo_status.dart';
import 'package:to_do_machine_test/features/todo/domain/usecase/upload_todo.dart';
import 'package:to_do_machine_test/features/todo/presentation/bloc/todo_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initTodo();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supaBaseurl,
    anonKey: AppSecrets.supaBaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  // dependency for AuthRemoteDataSourceImpl
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  // dependency for AuthRepositoryImpl
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  // dependency for UseCases
  serviceLocator.registerFactory(() => UserSignup(serviceLocator()));

  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  // dependency for AuthBloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initTodo() {
  // dependency for TodoRemoteDataSourceImpl
  serviceLocator.registerFactory<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(serviceLocator()),
  );

  // repository
  serviceLocator.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(serviceLocator()),
  );

  // dependency for UseCases
  serviceLocator.registerFactory(() => UploadTodo(serviceLocator()));

  serviceLocator.registerFactory(() => GetAllTodos(serviceLocator()));

  serviceLocator.registerFactory(() => UpdateTodoStatus(serviceLocator()));

  // dependency for todo bloc
  serviceLocator.registerLazySingleton(
    () => TodoBloc(
      uploadTodo: serviceLocator(),
      getAllTodos: serviceLocator(),
      updateTodoStatus: serviceLocator(),
    ),
  );
}
