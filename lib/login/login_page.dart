import 'package:Todo_List/app_colors.dart';
import 'package:Todo_List/homepage/home_page.dart';
import 'package:Todo_List/provider/Appprovider.dart';
import 'package:Todo_List/register/register_page.dart';
import 'package:Todo_List/widgets/alert.dart';
import 'package:Todo_List/widgets/my_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<AppProvider>(context);
    return Stack(
      children: [
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
            title: Text(AppLocalizations.of(context)!.login_title,
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
                      floatingLabelStyleColor: AppColors.blueColor,
                      iconColor: AppColors.blueColor,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    MyTextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(context)!
                              .password_validation;
                        }
                        return null;
                      },
                      controller: passwordController,
                      label: AppLocalizations.of(context)!.password,
                      floatingLabelStyleColor: AppColors.blueColor,
                      iconColor: AppColors.blueColor,
                      obscureText: true,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InkWell(
                      child: Text(
                        AppLocalizations.of(context)!.forget_Password,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.blueColor.withOpacity(.7)),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blueColor,
                              foregroundColor: AppColors.whiteColor),
                          onPressed: () {
                            login();
                          },
                          child: Text(AppLocalizations.of(context)!.login,
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))),
                    ),
                    SizedBox(
                      height: height * .08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dont_have_account,
                          style: TextStyle(
                              color: AppColors.blueColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterPage.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.create_account_now,
                              style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void login() async {
    print('here');

    if (formKey.currentState?.validate() == true) {
      try {
        /// showLoading
        Alert.showLoading(context: context, message: 'Loading...');
        var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        ///hide loading
        Alert.hideLoading(context: context);
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          print('The email or password might be wrong');

          ///hideLoading
          Alert.hideLoading(context: context);

          ///showMessage
          Alert.showAlert(
            context: context,
            content: 'The email or password might be wrong',
            title: 'Error',
            firstbutton: 'back',
          );
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
