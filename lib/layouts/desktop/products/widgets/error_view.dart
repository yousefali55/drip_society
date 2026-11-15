import 'package:flutter/material.dart';
import 'package:drip_society/core/network/api_error_handler.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorType, required this.onRetry});

  final AppErrorType errorType;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final message = switch (errorType) {
      AppErrorType.network => l10n.errorSecureConnection,
      AppErrorType.timeout => l10n.errorConnection,
      AppErrorType.notFound => l10n.errorNotFound,
      AppErrorType.validation => l10n.errorValidation,
      AppErrorType.server => l10n.errorServer,
      AppErrorType.cancelled => l10n.errorCancelled,
      AppErrorType.unknown => l10n.errorUnknown,
    };

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded, size: 48, color: colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            l10n.unableLoadProducts,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
