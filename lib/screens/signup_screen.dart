import 'package:cog_screen/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
 State <SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.person_add_alt_1_sharp, // Outlined person icon
              size: 100, // Large icon size
              color: Theme.of(context).primaryColor, // Icon color
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(
                  color: Colors.black45,
                ),
              ),
              validator: (val) => val!.isEmpty ? 'Enter your first name' : null,
              onChanged: (val) => setState(() => firstName = val),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(
                  color: Colors.black45,
                ),
              ),
              validator: (val) => val!.isEmpty ? 'Enter your last name' : null,
              onChanged: (val) => setState(() => lastName = val),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                labelStyle: TextStyle(
                  color: Colors.black45,
                ),
              ),
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) => setState(() => email = val),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password_outlined),
                labelStyle: TextStyle(
                  color: Colors.black45,
                ),
              ),
              obscureText: true,
              validator: (val) =>
                  val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) => setState(() => password = val),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.password_outlined),
                labelStyle: TextStyle(
                  color: Colors.black45,
                ),
              ),
              obscureText: true,
              validator: (val) =>
                  val != password ? 'Passwords do not match' : null,
              onChanged: (val) => setState(() => confirmPassword = val),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await authProvider.signUpWithEmailAndPassword(
                      email,
                      password,
                    );
                    User? user = authProvider.currentUser;
                    if (user != null) {
                      await user.updateDisplayName("$firstName $lastName");
                      await user.reload();
                    }

                    if (mounted) {
                      Navigator.pushNamed(context, '/start');
                    }
                  } catch (e) {
                    if (mounted) {
                      setState(() => error = 'Failed to sign up');
                    }
                  }
                }
              },
              child: const Text('Sign Up'),
            ),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
