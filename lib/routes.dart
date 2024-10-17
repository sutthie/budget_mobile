import 'package:budget_mobile/admin/ShowAcc.dart';
import 'package:budget_mobile/budget/ShowStartBook.dart';
import 'package:flutter/widgets.dart';
import './admin/AddUser.dart';
import './screens/complete_profile/complete_profile_screen.dart';
import './screens/forgot_password/forgot_password_screen.dart';
import './screens/home/MainScreen.dart';
import './screens/login_success/login_success_screen.dart';
import './screens/otp/otp_screen.dart';
import './screens/profile/profile_screen.dart';
import './screens/sign_in/sign_in_screen.dart';
import './screens/splash/SplashScreen.dart';
import './screens/advert/AdvertScreen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import './screens/account/ShowAccDetail.dart';
import './screens/login_success/login_false_screen.dart';
import './admin/AdminSystem.dart';
import './MainPage.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  AdvertScreen.routeName: (context) => AdvertScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  LoginFalseScreen.routeName: (context) => LoginFalseScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  MainPage.routeName: (context) => MainPage(),
  //MainPage.routeName: (context) => MainPage(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ShowAccDetail.routeName: (context) => ShowAccDetail(),
  ShowAccount.routeName: (context) => ShowAccount(),
  AdminSystem.routeName: (context) => AdminSystem(),
  AddUser.routeName: (context) => AddUser(),
  ShowStartBook.routeName: (context) => ShowStartBook(),
};
