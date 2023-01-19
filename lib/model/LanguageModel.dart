class LanguageModel {
  String flag;
  String language;
  String languageCode;
  LanguageModel(this.flag, this.language, this.languageCode);
  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel("assets/english.png", "English", "en"),
      LanguageModel("assets/spain.png", "Spanish", "es"),
      LanguageModel("assets/france.png", "French", "fr"),
    ];
  }
}
