import 'package:flutter/material.dart';

final ThemeData mytheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface:  Color(0xFFF7F8FA), 
    onSurface:  Color(0xFF1E1E1E), 
    surfaceTint:  Color(0xFFE3E6EB), 
    primary:  Color(0xFF1565C0),
    onPrimary: Colors.white,
    secondary:  Color(0xFF90CAF9), 
  ),

  appBarTheme:  AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Color(0xFF1565C0), // deep blue tint
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1E1E1E),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF1565C0), // blue icons
    ),
  ),
  
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    indicatorColor:  Color(0xFF90CAF9), 
    iconTheme: WidgetStateProperty.all(
       IconThemeData(
        color: Color(0xFF1565C0),
        size: 28,
      ),
    ),
    labelTextStyle: WidgetStateProperty.all(
       TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1E1E1E),
      ),
    ),
  ),
);
