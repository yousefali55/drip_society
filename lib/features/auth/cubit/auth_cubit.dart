import 'package:drip_society/features/auth/cubit/auth_state.dart';
import 'package:drip_society/features/auth/data/models/customer_model.dart';
import 'package:drip_society/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({AuthRepository? repository})
    : _repository = repository ?? AuthRepository(),
      super(const AuthState()) {
    _bootstrap();
  }

  final AuthRepository _repository;

  Future<void> _bootstrap() async {
    final session = await _repository.loadSession();
    if (session != null) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          customer: session.customer,
          token: session.token,
          successMessage: 'Welcome back!',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  Future<void> login({required String email, required String password}) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
        successMessage: null,
        isSubmitting: true,
      ),
    );

    print('AuthCubit login email: $email');
    print('AuthCubit login password: $password');

    final result = await _repository.login(email: email, password: password);

    if (result.success && result.customer != null) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          customer: result.customer,
          token: result.token,
          successMessage: result.message,
          errorMessage: null,
          isSubmitting: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.failure,
        errorMessage: result.message,
        successMessage: null,
        isSubmitting: false,
      ),
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String city,
    required String postalCode,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
        successMessage: null,
        isSubmitting: true,
      ),
    );

    final result = await _repository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      city: city,
      postalCode: postalCode,
    );

    if (result.success && result.customer != null) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          customer: result.customer,
          token: result.token,
          successMessage: result.message,
          errorMessage: null,
          isSubmitting: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.failure,
        errorMessage: result.message,
        successMessage: null,
        isSubmitting: false,
      ),
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        customer: null,
        token: null,
        errorMessage: null,
        successMessage: 'Signed out successfully',
        isSubmitting: false,
      ),
    );
  }

  Future<CustomerModel?> getCustomer() async => _repository.getCustomer();

  Future<String?> getToken() async => _repository.getToken();

  Future<void> saveToken(String token) async => _repository.saveToken(token);

  Future<void> saveCustomer(CustomerModel customer) async =>
      _repository.saveCustomer(customer);

  Future<bool> isLoggedIn() async => _repository.isLoggedIn();
}
