import 'package:Todo_List/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLightColor,
      scaffoldBackgroundColor: AppColors.primaryLightColor,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          elevation: 0,
          backgroundColor: AppColors.blueColor,
          titleTextStyle: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 22,
              fontWeight: FontWeight.bold)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.blueColor,
        unselectedItemColor: AppColors.grayColor,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.blueColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.whiteColor, width: 5),
            borderRadius: BorderRadius.circular(50)),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor),
        titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blueColor,
        ),
        titleSmall:
            GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor),
        bodyLarge: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor),
        bodySmall:
            GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge:
            GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(fontSize: 14, color: AppColors.blackColor),
        labelSmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor),
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: AppColors.primaryLightColor),
      dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(color: AppColors.blueColor, fontSize: 18),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.whiteColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueColor, width: 1)),
          )));
  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDarkColor,
      scaffoldBackgroundColor: AppColors.primaryDarkColor,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.blackColor),
          elevation: 0,
          backgroundColor: AppColors.blueColor,
          titleTextStyle: TextStyle(
              color: AppColors.blackColor,
              fontSize: 22,
              fontWeight: FontWeight.bold)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.blueColor,
        unselectedItemColor: AppColors.grayColor,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.darkColor,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.blueColor,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkColor, width: 5),
            borderRadius: BorderRadius.circular(50)),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
        titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blueColor,
        ),
        titleSmall:
            GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.whiteColor),
        bodyLarge: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.whiteColor),
        bodySmall:
            GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor),
        labelMedium: TextStyle(fontSize: 14, color: AppColors.whiteColor),
        labelSmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: AppColors.primaryDarkColor),
      dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(fontSize: 18, color: AppColors.blueColor),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.darkColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueColor, width: 1)),
          )));
}
