import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:flutter/material.dart';


class AppTextStyle {
  AppTextStyle._internal();

  static final AppTextStyle _instance = AppTextStyle._internal();

  factory AppTextStyle() {
    return _instance;
  }

  static TextStyle headingH1(heading, {bool mutedText = false}) {
    double headingFontSize = 12.0;
    switch (heading) {
      case 'H1':
        headingFontSize = 18.0;
        break;
      case 'H2':
        headingFontSize = 16.0;
        break;
      case 'H3':
        headingFontSize = 14.0;
        break;
      case 'H4':
        headingFontSize = 12.0;
        break;
      case 'H5':
        headingFontSize = 10.0;
        break;
    }
    return TextStyle(
      fontSize: headingFontSize,
      fontWeight: FontWeight.w600,
      color: (mutedText) ? AppColors.black2 : AppColors.blackHeading,
    );
  }

  static TextStyle mutedTextLabel({
    double? headingFontSize,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontSize: headingFontSize ?? 9,
      fontWeight: fontWeight,
      color: AppColors.black2,
    );
  }

  static TextStyle radioButtonTextLabel() {
    return const TextStyle(
      color: Color(0xFF6b0903),
      fontSize: 11,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle tableCellTextStyle({double? headingFontSize}) {
    return TextStyle(
      fontSize: headingFontSize ?? 10,
      fontWeight: FontWeight.w500,
      color: AppColors.black2,
    );
  }

  static TextStyle drawerMenuStyle() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white1);
  }

  static TextStyle bottomSheetMenuStyle() {
    return const TextStyle(
      color: AppColors.blackHeading,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle claimDashboardMenuStyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.black1,
    );
  }

  static TextStyle rowTitleValueTextStyle({
    double? fontSize,
    Color color = AppColors.black,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 11.5,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle cardTitleTextStyle({
    Color color = AppColors.primary,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle rowTitleValueTextStyleSummaryTable({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: fontWeight,
    );
  }

  static TextStyle textStyleForNote() {
    return const TextStyle(
      color: AppColors.primary,
      fontSize: 10,
    );
  }

  final formInputStyle = const TextStyle(
    color: AppColors.blackHeading,
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  final alertTextStyle = const TextStyle(
    color: AppColors.black,
    // fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  final alertTextStyle2 = const TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontSize: 13,
  );

  static TextStyle cardTitleStyle() {
    return const TextStyle(
      color: AppColors.primary,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bottomSheetTitleStyle() {
    return const TextStyle(
      color: AppColors.primary,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle surveyPhotoTitleStyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.deepBlueColor,
    );
  }

  static TextStyle btnTextStyleWhite({
    double? fontSize,
    Color color = Colors.white,
  }) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 12,
    );
  }

  static elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.primary2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }

  static TextStyle claimCardMutedLabel(context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return TextStyle(
      color: AppColors.black2,
      fontSize: screenWidth > 600 ? 11 : 10,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle claimCardValue(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.black2,
      fontSize: screenWidth > 600 ? 12 : 11,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle fs12Black600() {
    return const TextStyle(
      color: AppColors.black1,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textFieldTextStyle({isFreeze = false}) {
    return TextStyle(
      color: isFreeze ? Colors.black87 : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle dropdownTextStyle({isFreeze = false}) {
    return TextStyle(
      color: isFreeze ? Colors.black87 : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  // mayuri 
  static TextStyle boldText({isFreeze = false}) {
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle text() {
    return const TextStyle(
      color: Colors.black54,
      fontSize: 13,
    );
  }                 


}


// import 'package:dsr_clone/shared/style/appColors.dart';
// import 'package:flutter/material.dart';

// double inputLabelSize = 15;
// double inputFontSize = 13;
// double sideMenuIconSize = 18;
// double headings = 17;
// double buttonFont = 14;
// const FontWeight fontweight = FontWeight.bold;
// const String roboto = 'Roboto';
// const double letterSpacingSmall = 0.5;
// const double letterSpacingMedium = 1.0;
// const double letterSpacingLarge = 1.5;


// final TextStyle headingsTextStyle = TextStyle(
//   fontWeight: fontweight,
//   color: AppColors.primary,
//   fontSize: headings,
//   fontFamily: roboto,
// );
// final TextStyle inputLabelTextStyle = TextStyle(
//     fontSize: inputLabelSize, color: AppColors.fontColor50, fontFamily: roboto);

// final TextStyle inputboxTextStyle = TextStyle(
//     fontSize: inputFontSize,
//     color: AppColors.fontColor,
//     fontWeight: fontweight);

// final TextStyle buttonTextStyle = TextStyle(
//     fontSize: buttonFont,
//     color: AppColors.primary,
//     fontWeight: fontweight,
//     fontFamily: roboto);

// const OutlineInputBorder textFeildBorder = OutlineInputBorder(
//   borderSide: BorderSide(color: AppColors.fontColor),
// );

// const OutlineInputBorder focusedtextFeildBorder = OutlineInputBorder(
//   borderSide: BorderSide(width: 1, color: AppColors.primary),
// );

// final ButtonStyle buttonStyles = ButtonStyle(
//   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//     RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//       side: const BorderSide(color: AppColors.primary),
//     ),
//   ),
//   side: MaterialStateProperty.all(
//     const BorderSide(
//         color: AppColors.primary, width: 1.0, style: BorderStyle.solid),
//   ),
// );

// const InputDecoration inputdecorations = InputDecoration(
//   contentPadding: EdgeInsets.all(10.0),
//   border: textFeildBorder,
//   focusedBorder: focusedtextFeildBorder,
// );

// // mayuri


