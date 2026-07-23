import 'package:drip_society/features/auth/cubit/auth_cubit.dart';
import 'package:drip_society/features/auth/cubit/auth_state.dart';
import 'package:drip_society/features/auth/presentation/widgets/auth_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthMenuButton extends StatelessWidget {
  const AuthMenuButton({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isAuthenticated && state.customer != null) {
          return Row(
            children: [
              CircleAvatar(
                radius: compact ? 16 : 18,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  state.customer!.firstName.isNotEmpty ? state.customer!.firstName[0].toUpperCase() : 'U',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
              const SizedBox(width: 10),
              if (!compact)
                Flexible(
                  child: Text(
                    state.customer!.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () => context.read<AuthCubit>().logout(),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: const Text('Logout'),
              ),
            ],
          );
        }

        return Row(
          children: [
            OutlinedButton(
              onPressed: () => _showAuthDialog(context, AuthMode.login),
              child: const Text('Login'),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () => _showAuthDialog(context, AuthMode.register),
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }

  void _showAuthDialog(BuildContext context, AuthMode mode) {
    showDialog<void>(
      context: context,
      builder: (_) => AuthFormDialog(mode: mode),
    );
  }
}
