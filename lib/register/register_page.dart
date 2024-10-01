import 'package:Todo_List/app_colors.dart';
import 'package:Todo_List/homepage/home_page.dart';
import 'package:Todo_List/provider/Appprovider.dart';
import 'package:Todo_List/widgets/alert.dart';
import 'package:Todo_List/widgets/my_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<AppProvider>(context);
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: provider.isDark()
            ? AppColors.primaryDarkColor
            : AppColors.primaryLightColor,
      ),
      Image.asset(
        'assets/images/background.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
      Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.register_title,
              style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: height * .3,
                  ),
                  MyTextFormField(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .username_validation;
                      }
                      return null;
                    },
                    controller: usernameController,
                    label: AppLocalizations.of(context)!.user_name,
                    iconColor: AppColors.blueColor,
                    keyboardType: TextInputType.name,
                    floatingLabelStyleColor: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  MyTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.email_validation;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'Please Enter a Valid Email';
                      }
                      return null;
                    },
                    controller: emailController,
                    label: AppLocalizations.of(context)!.email,
                    iconColor: AppColors.blueColor,
                    keyboardType: TextInputType.emailAddress,
                    floatingLabelStyleColor: AppColors.blueColor,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  MyTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .password_validation;
                      }
                      if (value.length <= 4) {
                        return "Enter A Strong Password";
                      }
                      return null;
                    },
                    controller: passwordController,
                    label: AppLocalizations.of(context)!.password,
                    iconColor: AppColors.blueColor,
                    keyboardType: TextInputType.visiblePassword,
                    floatingLabelStyleColor: AppColors.blueColor,
                    maxLines: 1,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  MyTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .confirm_password_validation;
                      }
                      if (passwordController.text != value) {
                        return "Passwords don't match, check confirm password";
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    label: AppLocalizations.of(context)!.confirm_password,
                    iconColor: AppColors.blueColor,
                    keyboardType: TextInputType.visiblePassword,
                    floatingLabelStyleColor: AppColors.blueColor,
                    maxLines: 1,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blueColor,
                            foregroundColor: AppColors.whiteColor),
                        onPressed: () {
                          createAccount();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.create_account,
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void createAccount() async {
    if (formKey.currentState?.validate() == true) {
      try {
        Alert.showLoading(context: context, message: 'waiting');
        var userCredentail = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print(userCredentail.user?.uid);
        Alert.hideLoading(context: context);
        Alert.showAlert(
            context: context,
            content: 'Account Create Successfully ',
            title: 'Success',
            firstbutton: 'ok',
            firstAction: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Alert.hideLoading(context: context);
          Alert.showAlert(
            context: context,
            content: 'The password provided is too weak.',
            title: 'Success',
            firstbutton: 'ok',
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Alert.hideLoading(context: context);
          Alert.showAlert(
            context: context,
            content: 'The account already exists for that email.',
            title: 'Success',
            firstbutton: 'ok',
          );
          print('The account already exists for that email.');
        } else if (e.code == 'network-request-failed') {
          ///hideLoading
          Alert.hideLoading(context: context);

          ///showMessage
          Alert.showAlert(
            context: context,
            content: '${e.code} check your network connection',
            title: 'Error',
            firstbutton: 'back',
          );
        }
      } catch (e) {
        Alert.hideLoading(context: context);
        Alert.showAlert(
            context: context,
            content: e.toString(),
            title: 'Error',
            firstbutton: 'back');
        print(e);
      }
    }
  }
}
