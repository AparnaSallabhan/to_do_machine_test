import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/core/network/connection_checker.dart';
import 'package:to_do_machine_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:to_do_machine_test/core/common/entities/user.dart';
import 'package:to_do_machine_test/features/auth/data/models/user_model.dart';
import 'package:to_do_machine_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User?>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(
          UserModel(id: session.user.id, email: session.user.email??''),
        );
      }

      final user = await remoteDataSource.getCurrentUserData();

      return right(user);
    } catch (e) {
      return left(Failure('User not logged in!'));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String email,
    required String passWord,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No internet connection!'));
      }

      final user = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: passWord,
      );

      return right(user);
    } catch (e) {
      return left(Failure(e));
    }
  }
}
