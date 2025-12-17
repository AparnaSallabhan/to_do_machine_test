import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/core/common/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String email,
    required String passWord,
  });

  Future<Either<Failure,User?>>currentUser();
}
