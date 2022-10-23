class Validators {
  bool isValidEmail(val) {
    if (val.isEmpty) return false;

    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(val)) return false;
    return true;
  }

  bool isValidName(val) {
    if (val.isEmpty) return false;
    final pnameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    if (!pnameRegExp.hasMatch(val)) return false;
    return true;
  }

  bool isValidPassword(val) {
    if (val.isEmpty) return false;
    if (val.length < 6) return false;
    return true;
  }
}
