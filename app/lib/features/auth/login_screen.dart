import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import 'auth_repository.dart';

String? requiredEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Informe seu e-mail.';
  if (!value.contains('@')) return 'Informe um e-mail valido.';
  return null;
}

String? _requiredPassword(String? value) {
  if (value == null || value.isEmpty) return 'Informe sua senha.';
  return null;
}

String _authErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    return error.message ?? 'Nao foi possivel entrar.';
  }
  return 'Nao foi possivel entrar.';
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_authErrorMessage(error))));
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_authErrorMessage(error))));
      }
    } finally {
      if (mounted) setState(() => _isGoogleSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = _isSubmitting || _isGoogleSubmitting;

    return AppScaffold(
      title: 'Dyana',
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Entrar',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: requiredEmail,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              decoration: const InputDecoration(labelText: 'Senha'),
              validator: _requiredPassword,
              onFieldSubmitted: (_) => isBusy ? null : _submit(),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: _isSubmitting ? 'Entrando...' : 'Entrar',
              onPressed: isBusy ? null : _submit,
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: isBusy ? null : _signInWithGoogle,
              icon: const Icon(Icons.login),
              label: Text(
                _isGoogleSubmitting ? 'Entrando...' : 'Entrar com Google',
              ),
            ),
            TextButton(
              onPressed: isBusy ? null : () => context.go('/signup'),
              child: const Text('Criar conta'),
            ),
            TextButton(
              onPressed: isBusy ? null : () => context.go('/reset-password'),
              child: const Text('Esqueci minha senha'),
            ),
          ],
        ),
      ),
    );
  }
}
