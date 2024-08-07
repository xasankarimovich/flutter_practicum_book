import 'package:buksam_flutter_practicum/data/models/forum_status/form_status.dart';
import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_bloc.dart';
import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_event.dart';
import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_state.dart';
import 'package:buksam_flutter_practicum/ui/screens/login/register_screen.dart';
import 'package:buksam_flutter_practicum/ui/widgets/global_loading_button.dart';
import 'package:buksam_flutter_practicum/ui/widgets/tab_box_Widget.dart';
import 'package:buksam_flutter_practicum/utils/extension/extension.dart';
import 'package:buksam_flutter_practicum/utils/ui_utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/glass_container_widget.dart';
import '../vedio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isEmailFocused = false;
  bool isPasswordFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          VideoPlayerScreen(),
          const GlassContainerWidget(),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      isEmailFocused = hasFocus;
                    });
                  },
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, email kiriting';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Email noto‘g‘ri formatda';
                      }
                      return null;
                    },
                  ),
                ),
                10.boxH(),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      isPasswordFocused = hasFocus;
                    });
                  },
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Parol',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, parol kiriting';
                      }
                      if (value.length < 6) {
                        return 'Parol kamida 6 ta belgidan iborat bo‘lishi kerak';
                      }
                      return null;
                    },
                  ),
                ),
                20.boxH(),
                BlocConsumer<AuthBloc, AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    return GlobalLoadingButton(
                      title: "Login",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                LoginRequested(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                              );
                        }
                      },
                      isLoading: state.status == ForumStatus.loading ||
                          state.status == ForumStatus.success,
                    );
                  },
                  listenWhen: (oldState, currentState) =>
                      currentState.status == ForumStatus.error ||
                      currentState.status == ForumStatus.success,
                  listener: (BuildContext context, AuthState state) {
                    if (state.status == ForumStatus.success) {
                      Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (_) => TabBoxScreen()));
                    }
                    if (state.status == ForumStatus.error) {
                      showErrorMessage(
                        message: state.errorMessage,
                        context: context,
                        onTap: () {
                          context.read<AuthBloc>().add(InitialEvent());
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return RegisterScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
