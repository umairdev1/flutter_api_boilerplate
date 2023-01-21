import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/resources/components/round_button.dart';
import 'package:flutter_api_boilerplate/utils/general_utils.dart';
import 'package:flutter_api_boilerplate/utils/routes/routes_name.dart';
import 'package:flutter_api_boilerplate/viewModel/auth_view_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> securepass = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode userFocusNode = FocusNode();
  FocusNode firstFocusNode = FocusNode();
  FocusNode lastFocusNode = FocusNode();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userController.dispose();
    firstController.dispose();
    lastController.dispose();
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
                  controller: userController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: userFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    hintText: 'User Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, userFocusNode, firstFocusNode);
                  },
                ),
                TextFormField(
                  controller: firstController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: firstFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Frist Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, firstFocusNode, lastFocusNode);
                  },
                ),
                TextFormField(
                  controller: lastController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: lastFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Last Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, lastFocusNode, emailFocusNode);
                  },
                ),
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
                  loading: authviewModel.signuploading,
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
                        "userName": userController.text,
                        "firstName": firstController.text,
                        "lastName": lastController.text,
                      };
                      authviewModel.signupApi(data, context);
                    }
                  },
                  title: 'Sign Up',
                ),
                30.height,
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: const Text("Already have an account? Sign In"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
