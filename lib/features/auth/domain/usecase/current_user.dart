import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/core/common/entities/user.dart';
import 'package:to_do_machine_test/features/auth/domain/repositories/auth_repository.dart';

class CurrentUser {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  Future<Either<Failure, User?>> call() async {
    return await authRepository.currentUser();
  }
}
