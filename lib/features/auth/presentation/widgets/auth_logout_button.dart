import 'package:drip_society/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLogoutAction {
  const AuthLogoutAction._();

  static Future<void> logout(BuildContext context) async {
    await context.read<AuthCubit>().logout();
  }
}

class AuthLogoutButton extends StatelessWidget {
  const AuthLogoutButton({super.key, this.onLoggedOut, this.expand = false});

  final VoidCallback? onLoggedOut;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton.icon(
      onPressed: () => _logout(context),
      icon: const Icon(Icons.logout_rounded, size: 18),
      label: const Text('Logout'),
    );

    if (!expand) {
      return button;
    }

    return SizedBox(width: double.infinity, child: button);
  }

  Future<void> _logout(BuildContext context) async {
    await AuthLogoutAction.logout(context);
    if (!context.mounted) return;
    onLoggedOut?.call();
  }
}
