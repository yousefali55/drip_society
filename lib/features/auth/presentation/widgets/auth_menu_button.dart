import 'package:drip_society/features/auth/cubit/auth_cubit.dart';
import 'package:drip_society/features/auth/cubit/auth_state.dart';
import 'package:drip_society/features/auth/presentation/widgets/auth_form_dialog.dart';
import 'package:drip_society/features/auth/presentation/widgets/auth_logout_button.dart';
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
          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: Text(
                        state.customer!.firstName.isNotEmpty
                            ? state.customer!.firstName[0].toUpperCase()
                            : 'U',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 180),
                      child: Text(
                        state.customer!.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AuthLogoutButton(
                  onLoggedOut: () => Navigator.of(context).maybePop(),
                ),
              ],
            );
          }

          return Row(
            children: [
              PopupMenuButton<_AuthMenuAction>(
                tooltip: 'Profile menu',
                onSelected: (action) async {
                  if (action == _AuthMenuAction.logout) {
                    await AuthLogoutAction.logout(context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<_AuthMenuAction>(
                    enabled: false,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          child: Text(
                            state.customer!.firstName.isNotEmpty
                                ? state.customer!.firstName[0].toUpperCase()
                                : 'U',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            state.customer!.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<_AuthMenuAction>(
                    value: _AuthMenuAction.logout,
                    child: Row(
                      children: [
                        Icon(Icons.logout_rounded, size: 20),
                        SizedBox(width: 12),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: Text(
                        state.customer!.firstName.isNotEmpty
                            ? state.customer!.firstName[0].toUpperCase()
                            : 'U',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 180),
                      child: Text(
                        state.customer!.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
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

enum _AuthMenuAction { logout }
