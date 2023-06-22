import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void setPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 200,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * .8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email field cannot be empty';
                        } else if (!isValidEmail(value)) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.7))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width * .8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password field cannot be empty';
                        } else if (value.length < 8) {
                          return 'Password length must be minimum 8';
                        } else if (!isValidPassword(value)) {
                          return 'Password must contain upper case, number, special char';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined)),
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.7))),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .95,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 26),
                            dense: true,
                            value: _rememberMe,
                            onChanged: (val) {
                              setState(() {
                                _rememberMe = val!;
                              });
                            },
                            title: const Text('Remember me'),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: InkWell(
                              onTap: () {},
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                              const SnackBar(
                                content: Text('Logging in...'),
                                duration: Duration(milliseconds: 400),
                              ),
                            )
                            .closed
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Validation Successful')),
                          );
                        });
                        if (_rememberMe) setPreferences();
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Validation Error')),
                        );
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(MediaQuery.of(context).size.width * .7, 45)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  bool isValidPassword(String password) {
    return RegExp(r'^(?=.*\d)(?=.*[A-Z]).{8,}$').hasMatch(password);
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
