import 'package:cog_screen/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
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
              Icons.person_sharp, // Outlined person icon
              size: 100, // Large icon size
              color: Theme.of(context).primaryColor, // Icon color
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                labelStyle: TextStyle(
                  color: Colors.black45,
                ),
              ),
              //initialValue: 'gmtfrombc@gmail.com',
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
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
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () async {
                email = 'gmtfrombc@gmail.com';
                password = 'password1';
                if (_formKey.currentState!.validate()) {
                  try {
                    await authProvider.signInWithEmailAndPassword(
                        email, password);
                    if (mounted) {
                      Navigator.pushNamed(context, '/start');
                    }
                  } catch (e) {
                    if (mounted) {
                      setState(() => error = 'Failed to sign in');
                    }
                  }
                }
              },
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: () async {
                if (email.isNotEmpty) {
                  try {
                    await authProvider.resetPassword(email);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset email sent to $email'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to reset password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text('Forgot Password?'),
            ),
            Text(error, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
