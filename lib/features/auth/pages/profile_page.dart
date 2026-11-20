import 'package:flutter/material.dart';

import '../../../core/widgets/page_header.dart';
import '../../../core/widgets/vw_app_bar.dart';

enum DemoAccount {
  seller('Individual seller', 'Greenbank Seller'),
  buyer('Company buyer', 'Circular Materials Co.'),
  admin('Admin', 'ValuWaste Admin');

  const DemoAccount(this.role, this.displayName);
  final String role;
  final String displayName;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.onSessionChanged});
  final ValueChanged<DemoAccount?>? onSessionChanged;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _form = GlobalKey<FormState>();
  DemoAccount? _profile;
  String? _error;

  void _signIn() {
    if (!_form.currentState!.validate()) return;
    final username = _username.text.trim().toLowerCase();
    final account = DemoAccount.values.asNameMap()[username];
    if (account == null || _password.text != 'demo123') {
      setState(() => _error = 'Check the demo username and password.');
      return;
    }
    _password.clear();
    setState(() {
      _error = null;
      _profile = account;
    });
    widget.onSessionChanged?.call(account);
  }

  void _signOut() {
    _username.clear();
    setState(() => _profile = null);
    widget.onSessionChanged?.call(null);
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final account = _profile;
    return Scaffold(
      appBar: const VwAppBar(),
      body: ListView(
        padding: VwSpacing.page,
        children: [
          PageHeader(
            title: 'Profile',
            subtitle: account == null
                ? 'Demo usernames: seller, buyer, or admin. Password: demo123.'
                : account.displayName,
          ),
          const SizedBox(height: VwSpacing.gap),
          if (_error != null)
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          if (account == null)
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _username,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Enter your username.'
                        : null,
                  ),
                  const SizedBox(height: VwSpacing.gap),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Enter your password.' : null,
                  ),
                  const SizedBox(height: VwSpacing.gap),
                  FilledButton(
                    onPressed: _signIn,
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            )
          else ...[
            for (final field in {
              'Username': account.name,
              'Account type': account.role,
              'Verification': 'Verified (demo)',
            }.entries)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(field.key),
                subtitle: Text(field.value),
              ),
            OutlinedButton(onPressed: _signOut, child: const Text('Sign out')),
          ],
        ],
      ),
    );
  }
}
