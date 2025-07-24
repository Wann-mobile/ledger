import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationUtils {
  const NavigationUtils();

  static final scaffoldKey = GlobalKey<ScaffoldState>();
  
  static final iconList = <({IconData idle, IconData active})>[
    (idle: Icons.home_outlined, active: Icons.home),
    (idle: Icons.category_outlined, active: Icons.category), 
    (idle: Icons.receipt_outlined, active: Icons.receipt),
    (idle: Icons.person_outline, active: Icons.person),
  ];

  static int activeIndex (GoRouterState state) {
    return switch (state.fullPath){
      '/home' => 0,
      '/category' => 1,
      '/statements' => 2,
      '/profile' => 3,
      _ => 0,
    };
  }

  
  static final drawerItems = <({String title, IconData icon})>[
    (title: 'Edit Budget', icon: Icons.edit_document),
    (title: 'Privacy Policy', icon: Icons.shield_outlined),
    (title: 'Terms & conditions', icon: Icons.document_scanner_rounded),
  ];
}