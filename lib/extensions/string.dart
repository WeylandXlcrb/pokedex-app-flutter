extension StringEx on String {
  String capitalize() =>
      isEmpty ? this : substring(0, 1).toUpperCase() + substring(1);

  String hyphenToPascalWord() =>
      isEmpty ? this : split('-').map((e) => e.capitalize()).join(' ');

  String replaceNewLineTo([String replace = ' ']) =>
      isEmpty ? this : replaceAll(RegExp(r'\n'), replace);

  String pretifyGeneration() {
    if (isEmpty) {
      return this;
    }

    final splitStr = split('-');

    return '${splitStr[0].capitalize()} ${splitStr[1].toUpperCase()}';
  }
}
