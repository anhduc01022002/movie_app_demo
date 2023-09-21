import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/data/core/unauthorised_exception.dart';
import 'package:movie_app/data/data_sources/authentication_local_data_source.dart';
import 'package:movie_app/data/data_sources/authentication_remote_data_source.dart';
import 'package:movie_app/data/models/request_data_model.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._authenticationLocalDataSource,
  );

  Future<Either<AppError, RequestTokenModel>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> params) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final token1 = requestTokenEitherResponse.fold(
          (l) => null,
          (r) => r.requestToken,
    ) ?? '';

    try {
      params.putIfAbsent('request_token', () => token1);
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(params);
      final sessionId = await _authenticationRemoteDataSource
          .createSession(validateWithLoginToken.toJson());
      await _authenticationLocalDataSource.saveSessionId(sessionId);
      return const Right(true);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();

    if (sessionId == null) {
      return const Left(AppError(AppErrorType.api));
    }

    try {
      await Future.wait([
        _authenticationRemoteDataSource.deleteSession(sessionId),
        _authenticationLocalDataSource.deleteSessionId(),
      ]);
      print(await _authenticationLocalDataSource.getSessionId());
      return const Right(Unit);
    } catch (e) {
      // Handle other errors as you see fit
      return const Left(AppError(AppErrorType.api));
    }
  }
}
