import 'package:buksam_flutter_practicum/data/models/forum_status/form_status.dart';
import 'package:buksam_flutter_practicum/data/models/user/user_model.dart';
import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_bloc.dart';
import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_event.dart';
import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_state.dart';
import 'package:buksam_flutter_practicum/logic/blocs/user_bloc/user_bloc.dart';
import 'package:buksam_flutter_practicum/ui/widgets/global_loading_button.dart';
import 'package:buksam_flutter_practicum/ui/widgets/tab_box_Widget.dart';
import 'package:buksam_flutter_practicum/utils/extension/extension.dart';
import 'package:buksam_flutter_practicum/utils/style/app_text_style.dart';
import 'package:buksam_flutter_practicum/utils/ui_utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/blocs/user_bloc/user_event.dart';
import '../../widgets/glass_container_widget.dart';
import '../vedio.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  bool isConfirmPasswordFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const VideoPlayerScreen(),
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
                    decoration: const InputDecoration(
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
                10.boxH(),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      isConfirmPasswordFocused = hasFocus;
                    });
                  },
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Parolni tasdiqlang',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, parolni tasdiqlang';
                      }
                      if (value != _passwordController.text) {
                        return 'Parollar mos emas';
                      }
                      return null;
                    },
                  ),
                ),
                20.boxH(),
                BlocConsumer<AuthBloc, AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    return GlobalLoadingButton(
                      title: "Register",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                RegisterRequested(
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
                      UserModel userModel = UserModel.initialValue();
                      userModel = userModel.copyWith(
                        email: _emailController.text,
                        password: _passwordController.text,
                        uid: state.user!.uid,
                      );
                      context
                          .read<UserBloc>()
                          .add(InsertUserEvent(userModel: userModel));
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => TabBoxScreen(),
                        ),
                      );
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
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Stack(
                                      children: [
                                        const GlassContainerWidget(),
                                        FadeTransition(
                                          opacity: animation,
                                          child: const LoginScreen(),
                                        ),
                                      ],
                                    ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            }));
                  },
                  child: Text(
                    'Login',
                    style: AppTextStyle.medium.copyWith(
                      color: Colors.white,
                      fontSize: 24.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
