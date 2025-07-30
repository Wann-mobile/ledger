import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger/src/root_presentaion/presentation/home_presentation/view/home_view.dart';
import 'package:ledger/src/root_presentaion/presentation/profile_presentation/view/profile_view.dart';
import 'package:ledger/src/root_presentaion/presentation/statements_presentation/view/statements_view.dart';
import 'package:ledger/src/root_presentaion/presentation/statistics_presentation/view/statistics_view.dart';

abstract class NavigationUtils {
  const NavigationUtils();

  static final scaffoldKey = GlobalKey<ScaffoldState>();

  static final iconList = <({IconData idle, IconData active})>[
    (idle: Icons.home_outlined, active: Icons.home),
    (idle: Icons.analytics_outlined, active: Icons.analytics),
    (idle: Icons.description_outlined, active: Icons.description),
    (idle: Icons.person_outline, active: Icons.person),
  ];

  static int activeIndex(GoRouterState state) {
    return switch (state.fullPath) {
      HomeView.path => 0,
      StatisticsView.path => 1,
      StatementsView.path => 2,
      ProfileView.path => 3,
      _ => 0,
    };
  }

  static void indexNavigation(int index, BuildContext context) {
    return switch (index) {
      0 => context.go(HomeView.path),
      1 => context.go(StatisticsView.path),
      2 => context.go(StatementsView.path),
      3 => context.go(ProfileView.path),
      _ => context.go(HomeView.path),
    };
  }

  static final drawerItems = <({String title, IconData icon})>[
    (title: 'Edit Budget', icon: Icons.edit_document),
    (title: 'Privacy Policy', icon: Icons.shield_outlined),
    (title: 'Terms & conditions', icon: Icons.document_scanner_rounded),
  ];
}
