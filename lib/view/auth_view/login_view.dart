import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../resources/components/round_button.dart';
import '../../utils/general_utils.dart';
import '../../utils/routes/routes_name.dart';
import '../../viewModel/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> securepass = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authviewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passwordFocusNode);
                  },
                ),
                20.height,
                ValueListenableBuilder(
                  valueListenable: securepass,
                  builder: (context, value, child) {
                    return TextFormField(
                      obscureText: value,
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              securepass.value = !securepass.value;
                            },
                            icon: Icon(value
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                    );
                  },
                ),
                30.height,
                RoundButton(
                  loading: authviewModel.loading,
                  onPress: () {
                    if (emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter email', context);
                    } else if (passwordController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter password', context);
                    } else if (passwordController.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          'Please enter 6 digit password', context);
                    } else {
                      Map data = {
                        "email": emailController.text.trim(),
                        "password": passwordController.text.trim(),
                      };
                      authviewModel.loginApi(data, context);
                    }
                  },
                  title: 'Login',
                ),
                30.height,
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.signup);
                    },
                    child: const Text("Don't have an account? Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
