class Language {
  final int id;
  final String name;
  final String flag;
  final String langaugeCode;

  Language(this.id, this.name, this.flag, this.langaugeCode);

  static List<Language> langaugeList() {
    return <Language>[
      Language(1, "English", "🇺🇸", "en"),
      Language(2, "العربية", "🇸🇦", "ar"),
    ];
  }
}
