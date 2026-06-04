import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_emailController.text.trim().isEmpty || 
        _passwordController.text.trim().isEmpty ||
        _firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final user = await _authService.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.pop(context); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup Failed. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo.shade400, Colors.indigo.shade900],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.person_add_outlined, size: 70, color: Colors.indigo),
                    const SizedBox(height: 16),
                    const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(labelText: 'First Name', prefixIcon: Icon(Icons.person_outline)),
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(labelText: 'Last Name'),
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline)),
                      obscureText: true,
                    ),
                    const SizedBox(height: 32),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                      child: const Text('SIGN UP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.grey.shade600),
                          children: const [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
