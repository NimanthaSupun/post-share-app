import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/views/auth_views/login_page.dart';
import 'package:socially/views/main_screen.dart';
import 'package:socially/views/auth_views/register_page.dart';
import 'package:socially/views/responsive/mobile_layout.dart';
import 'package:socially/views/responsive/responsive_layout.dart';
import 'package:socially/views/responsive/web_layout.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text("Page not Found"),
              ),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go("/");
                },
                child: const Text("Home"),
              ),
            ],
          ),
        ),
      );
    },
    routes: [

      GoRoute(
        name: "/",
        path: "/",
        builder: (context, state) {
          return const ResponsiveLayoutSreen(
            mobileSreenLayout: MobileSreenLayout(),
            webSreenLayout: WebSreenLayout(),
          );
        },
      ),

      GoRoute(
        name: "register",
        path: "/register",
        builder: (context, state) {
          return const RegisterPage();
        },
      ),

      GoRoute(
        name: "login",
        path: "/login",
        builder: (context, state) {
          return LoginScreen();
        },
      ),

      GoRoute(
        name: "main Screen",
        path: "/main-screen",
        builder: (context, state) {
          return const MainScreen();
        },
      ),
      
    ],
  );
}
