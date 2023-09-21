
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/login_request_params.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/login_user.dart';
import 'package:movie_app/domain/usecases/logout_user.dart';
import 'package:movie_app/presentation/translation_constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  LoginBloc({
    required this.loginUser,
    required this.logoutUser,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginInitiateEvent) {
        final Either<AppError, bool> eitherResponse = await loginUser(
          LoginRequestParams(
            userName: event.username,
            password: event.password,
          ),
        );

        eitherResponse.fold(
              (l) {
            var message = getErrorMessage(l.appErrorType);
            print(message);
            emit(LoginError(message));
          },
              (r) => emit(LoginSuccess()),
        );
      } else if (event is LogoutEvent) {
        await logoutUser(NoParams());
        emit(LogoutSuccess());
      }
    });
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
