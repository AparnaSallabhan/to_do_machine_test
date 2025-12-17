import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_machine_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:to_do_machine_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:to_do_machine_test/features/auth/presentation/pages/auth_page.dart';
import 'package:to_do_machine_test/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do_machine_test/features/todo/presentation/pages/home_page.dart';
import 'package:to_do_machine_test/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<TodoBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
       BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedin) {
          if (isLoggedin) {
            return HomePage();
          }
          return AuthPage();
        },
      ),
    );
  }
}
