class RegExpClass {
  static const fmtCommaDisp = "";
  static const fmtComma = "r'[\,]";
  static const fmtDigitDisp = "r'^(\d+)(?:\.|\,)\d{0,2}";
  static const fmtDigitChk = r'^(\d+)(?:\.|\,)\d{0,2}$';

  late RegExp fmtRegExp;

  RegExp setRegExpDisplay(fmt) {
    if (fmt == 'digit') // january-september
    {
      fmtRegExp = RegExp(fmtDigitDisp);
    } else if (fmt == 'money') {
      fmtRegExp = RegExp(fmtCommaDisp);
    }

    return fmtRegExp;
  }
}
