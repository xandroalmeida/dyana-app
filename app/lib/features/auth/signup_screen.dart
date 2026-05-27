import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import 'auth_repository.dart';
import 'login_screen.dart';

String? _requiredName(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  return null;
}

String? _requiredSignupPassword(String? value) {
  if (value == null || value.isEmpty) return 'Informe uma senha.';
  if (value.length < 6) return 'Use pelo menos 6 caracteres.';
  return null;
}

String _authErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    return error.message ?? 'Nao foi possivel criar sua conta.';
  }
  return 'Nao foi possivel criar sua conta.';
}

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final credential = await ref
          .read(authRepositoryProvider)
          .createWithEmail(_emailController.text, _passwordController.text);
      final name = _nameController.text.trim();
      if (name.isNotEmpty) {
        await credential.user?.updateDisplayName(name);
      }
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Dyana',
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Criar conta',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: _requiredName,
            ),
            const SizedBox(height: 12),
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
              autofillHints: const [AutofillHints.newPassword],
              decoration: const InputDecoration(labelText: 'Senha'),
              validator: _requiredSignupPassword,
              onFieldSubmitted: (_) => _isSubmitting ? null : _submit(),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: _isSubmitting ? 'Criando...' : 'Criar conta',
              onPressed: _isSubmitting ? null : _submit,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _isSubmitting ? null : () => context.go('/login'),
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
