String? countryCodeValidator(String val) {
  if (val.length < 3 || val.contains("+") == false) {
    return "invalid";
  }
  return null;
}

String? phoneValidator(String val) {
  if (val.length < 9) {
    return "invalid phone number";
  }
  return null;
}

String? emailValidator(String val) {
  if (val.contains("@gmail.com") == false) {
    return "invalid email";
  }
  return null;
}

String? nameValidator(String val) {
  if (val.length < 2) {
    return "Please enter your real name.";
  }
  return null;
}
