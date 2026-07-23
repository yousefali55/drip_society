import 'package:drip_society/features/auth/cubit/auth_cubit.dart';
import 'package:drip_society/features/auth/cubit/auth_state.dart';
import 'package:drip_society/features/auth/data/validation/auth_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFormDialog extends StatefulWidget {
  const AuthFormDialog({super.key, required this.mode});

  final AuthMode mode;

  @override
  State<AuthFormDialog> createState() => _AuthFormDialogState();
}

enum AuthMode { login, register }

class _AuthFormDialogState extends State<AuthFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();

  bool _showPassword = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.successMessage ?? 'Signed in successfully')),
                );
              }
              if (state.status == AuthStatus.failure && state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.mode == AuthMode.login ? 'Welcome back' : 'Create account',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.mode == AuthMode.login
                            ? 'Sign in to continue your coffee journey.'
                            : 'Register to order your favorite blends.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      if (widget.mode == AuthMode.register) ...[
                        Row(
                          children: [
                            Expanded(child: _buildTextField(_firstNameController, 'First Name', AuthValidation.validateFirstName)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildTextField(_lastNameController, 'Last Name', AuthValidation.validateLastName)),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      _buildTextField(_emailController, 'Email', AuthValidation.validateEmail),
                      const SizedBox(height: 12),
                      if (widget.mode == AuthMode.register) ...[
                        _buildTextField(_phoneController, 'Phone Number', AuthValidation.validatePhone),
                        const SizedBox(height: 12),
                      ],
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        validator: AuthValidation.validatePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => _showPassword = !_showPassword),
                            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (widget.mode == AuthMode.register) ...[
                        Row(
                          children: [
                            Expanded(child: _buildTextField(_cityController, 'City', AuthValidation.validateCity)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildTextField(_postalCodeController, 'Postal Code', AuthValidation.validatePostalCode)),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                      FilledButton.icon(
                        onPressed: state.isSubmitting ? null : _submit,
                        icon: state.isSubmitting
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : Icon(widget.mode == AuthMode.login ? Icons.login_rounded : Icons.person_add_alt_1_rounded),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(widget.mode == AuthMode.login ? 'Sign In' : 'Create Account'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: state.isSubmitting ? null : () => Navigator.of(context).pop(),
                        child: Text(widget.mode == AuthMode.login ? 'Cancel' : 'Maybe later'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final trimmedEmail = _emailController.text.trim();
    final password = _passwordController.text;

    print('Email before calling login(): $trimmedEmail');
    print('Password before calling login(): $password');

    final authCubit = context.read<AuthCubit>();
    if (widget.mode == AuthMode.login) {
      await authCubit.login(email: trimmedEmail, password: password);
    } else {
      await authCubit.register(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: trimmedEmail,
        phoneNumber: _phoneController.text,
        password: password,
        city: _cityController.text,
        postalCode: _postalCodeController.text,
      );
    }
  }
}
