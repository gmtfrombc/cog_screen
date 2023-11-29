import 'package:cog_screen/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showSignIn ? 'Sign In' : 'Sign Up'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.swap_horiz, color: Colors.white),
            label: Text(
              showSignIn ? 'Sign Up' : 'Sign In',
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: toggleView,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: showSignIn
            ? SignIn(
                toggleView: toggleView,
              ) // Updated
            : const _SignUp(),
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Enter an email' : null,
            onChanged: (val) {
              setState(() => email = val);
            },
          ),
          TextFormField(
            obscureText: true,
            validator: (val) =>
                val!.length < 6 ? 'Enter a password 6+ chars long' : null,
            onChanged: (val) {
              setState(() => password = val);
            },
          ),
          ElevatedButton(
            onPressed: () async {
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
    );
  }
}

class _SignUp extends StatefulWidget {
  const _SignUp();
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<_SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Enter an email' : null,
            onChanged: (val) {
              setState(() => email = val);
            },
          ),
          TextFormField(
            obscureText: true,
            validator: (val) =>
                val!.length < 6 ? 'Enter a password 6+ chars long' : null,
            onChanged: (val) {
              setState(() => password = val);
            },
          ),
          TextFormField(
            obscureText: true,
            validator: (val) =>
                val != password ? 'Passwords do not match' : null,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await authProvider.signUpWithEmailAndPassword(
                      email, password);
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
          Text(error, style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
