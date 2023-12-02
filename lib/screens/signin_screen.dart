import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
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
  bool _passwordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Initially password is obscure
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CustomProgressIndicator(),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: _buildSigninForm(),
          );
  }

  Widget _buildSigninForm() {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    return Form(
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
            validator: (val) => val!.isEmpty ? 'Enter an email' : null,
            onChanged: (val) {
              setState(() => email = val);
            },
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              prefixIcon: const Icon(Icons.password_outlined),
              labelStyle: const TextStyle(
                color: Colors.black45,
              ),
            ),
            obscureText: !_passwordVisible,
            validator: (val) =>
                val!.length < 6 ? 'Enter a password 6+ chars long' : null,
            onChanged: (val) {
              setState(() => password = val);
            },
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                signUserIn();
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
    );
  }

  void signUserIn() async {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      await authProvider.signInWithEmailAndPassword(
        email,
        password,
      );
      if (mounted) {
        Navigator.pushNamed(context, '/start');
      }
    } catch (e) {
      if (mounted) {
        setState(() => error = 'Failed to sign in');
      }
    } finally {
      if (mounted) {
        setState(
          () {
            isLoading = false;
          },
        );
      }
    }
  }
}
