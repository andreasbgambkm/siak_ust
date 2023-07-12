import 'package:flutter/material.dart';



class NavigationRouter {
  static void switchToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/LoginPage");
  }

  static void switchToRegistration(BuildContext context) {
    Navigator.pushNamed(context, "/RegistrationPage");
  }

  static void switchToHome(BuildContext context) {
    Navigator.pushNamed(context, "/HomePage");
  }
  static void switchToProfile(BuildContext context) {
    Navigator.pushNamed(context, "/UserPage");
  }

  static void switchToBanner(BuildContext context) {
    Navigator.pushNamed(context, "/BannerPage");
  }
}