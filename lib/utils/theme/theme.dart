import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class DAppTheme {
  DAppTheme._();

  /// -- Light Fluent Theme
  static FluentThemeData lightTheme = FluentThemeData(

    brightness: Brightness.light,
    accentColor: AccentColor.swatch({
      'normal': DColors.primary,
      'lighter': DColors.accent,
      'darker': DColors.secondary,
    }),
    scaffoldBackgroundColor: DColors.primary,
    typography: Typography.raw(
      display: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: DColors.textPrimary,
      ),
      title: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
        color: DColors.textPrimary,
      ),
      body: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: DColors.bodyTextColor,
      ),
      bodyStrong: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w600,
        color: DColors.textPrimary,
      ),
      caption: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: DColors.darkGrey,
        fontSize: 12,
      ),
    ),
    buttonTheme: ButtonThemeData(
      defaultButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(DColors.primary),
        foregroundColor: WidgetStateProperty.all(DColors.textWhite),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkedDecoration: WidgetStateProperty.all(
        BoxDecoration(
          color: DColors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),

  );
}
