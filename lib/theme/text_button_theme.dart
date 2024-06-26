part of 'app_theme.dart';

TextButtonThemeData _textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color.fromARGB(255, 226, 226, 226);
        }
        return const Color(0xFF349f85);
      },
    ),
    minimumSize: MaterialStateProperty.all(
      const Size(double.infinity, 44.0),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
);
