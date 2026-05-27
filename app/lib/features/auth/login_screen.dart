import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_l10n.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import 'auth_error_message.dart';
import 'auth_repository.dart';

String? requiredEmail(String? value, String requiredMessage, String invalid) {
  if (value == null || value.trim().isEmpty) return requiredMessage;
  if (!value.contains('@')) return invalid;
  return null;
}

String? _requiredPassword(String? value, String requiredMessage) {
  if (value == null || value.isEmpty) return requiredMessage;
  return null;
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isSubmitting = false;
  var _isGoogleSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmail(_emailController.text, _passwordController.text);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authErrorMessage(context.l10n, error))),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleSubmitting = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authErrorMessage(context.l10n, error))),
        );
      }
    } finally {
      if (mounted) setState(() => _isGoogleSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = _isSubmitting || _isGoogleSubmitting;
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.appTitle,
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              l10n.signIn,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(labelText: l10n.email),
              validator: (value) =>
                  requiredEmail(value, l10n.requiredEmail, l10n.invalidEmail),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(labelText: l10n.password),
              validator: (value) =>
                  _requiredPassword(value, l10n.requiredPassword),
              onFieldSubmitted: (_) => isBusy ? null : _submit(),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: _isSubmitting ? l10n.signingIn : l10n.signIn,
              onPressed: isBusy ? null : _submit,
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: isBusy ? null : _signInWithGoogle,
              icon: const Icon(Icons.login),
              label: Text(
                _isGoogleSubmitting ? l10n.signingIn : l10n.signInWithGoogle,
              ),
            ),
            TextButton(
              onPressed: isBusy ? null : () => context.go('/signup'),
              child: Text(l10n.createAccount),
            ),
            TextButton(
              onPressed: isBusy ? null : () => context.go('/reset-password'),
              child: Text(l10n.forgotPassword),
            ),
          ],
        ),
      ),
    );
  }
}
