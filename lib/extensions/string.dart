extension StringEx on String {
  String capitalize() =>
      isEmpty ? this : substring(0, 1).toUpperCase() + substring(1);

  String hyphenToPascalWord() =>
      isEmpty ? this : split('-').map((e) => e.capitalize()).join(' ');
}
