class Language{
  final int id;
  final String name;
  final String flag;
  final String languagecode;
  Language({required this.id,required this.name,required this.flag,required this.languagecode});

  static List<Language> languageList(){
    return<Language> [
      Language(id: 1,name: 'English',flag: '🇺🇸' ,languagecode: '🇺🇸'),
      Language(id: 1,name: 'Arabic',flag: '🇪🇬' ,languagecode: 'ar'),
    ];
  }
  static List<Language> get list{
    return languageList();
  }
}