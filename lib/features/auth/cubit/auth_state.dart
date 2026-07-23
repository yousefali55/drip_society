import 'package:drip_society/features/auth/data/models/customer_model.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.customer,
    this.token,
    this.errorMessage,
    this.successMessage,
    this.isSubmitting = false,
  });

  final AuthStatus status;
  final CustomerModel? customer;
  final String? token;
  final String? errorMessage;
  final String? successMessage;
  final bool isSubmitting;

  bool get isAuthenticated => status == AuthStatus.authenticated && customer != null;

  AuthState copyWith({
    AuthStatus? status,
    CustomerModel? customer,
    String? token,
    String? errorMessage,
    String? successMessage,
    bool? isSubmitting,
  }) {
    return AuthState(
      status: status ?? this.status,
      customer: customer ?? this.customer,
      token: token ?? this.token,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, customer, token, errorMessage, successMessage, isSubmitting];
}
