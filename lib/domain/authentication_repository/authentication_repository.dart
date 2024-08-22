import 'dart:async';

import 'package:crm_system/data/models/auth/login_request.dart';
import 'package:crm_system/data/models/auth/register_request.dart';
import 'package:crm_system/data/services/authentication/authentication_service.dart';
import 'package:crm_system/data/services/authentication/local_authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationServiceInterface _authenticationService;
  final LocalAuthenticationService _localAuthenticationService;

  AuthenticationRepository({
    required AuthenticationServiceInterface authenticationService,
    required LocalAuthenticationService localAuthenticationService,
  })  : _authenticationService = authenticationService,
        _localAuthenticationService = localAuthenticationService;

  Future<void> login(LoginRequest request) async {
    final response = await _authenticationService.login(request);
    await _localAuthenticationService.saveAuth(response);
  }

  Future<void> register(RegisterRequest request) async {
    final response = await _authenticationService.register(request);
    await _localAuthenticationService.saveAuth(response);
  }

  Future<void> logout() async {
    await _authenticationService.logout();
    await _localAuthenticationService.deleteAuth();
  }

  Future<bool> checkAuthStatus() async {
    final auth = await _localAuthenticationService.getAuth();
    return auth != null;
  }
}