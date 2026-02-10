import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _obscurePassword = true;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    // Navigate to home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                  color: const Color(0xFF2E7D32),
                ),
                const SizedBox(height: 20),

                // Welcome Text
                const Text(
                  'Welcome Back 👋',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue to GrowMate',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 40),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Container(
                            margin: const EdgeInsets.all(12),
                            width: 20,
                            height: 20,
                            child: const Icon(
                              Icons.email,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Container(
                            margin: const EdgeInsets.all(12),
                            width: 20,
                            height: 20,
                            child: const Icon(
                              Icons.lock,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey.shade500,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Remember Me & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                                activeColor: const Color(0xFF4CAF50),
                              ),
                              Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // OR Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: Colors.grey.shade300),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Social Login Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            icon: 'assets/google.png',
                            onTap: () {},
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            icon: 'assets/facebook.png',
                            onTap: () {},
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            icon: 'assets/twitter.png',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              ' Sign Up',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: 24,
            height: 24,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.account_circle, size: 24);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}