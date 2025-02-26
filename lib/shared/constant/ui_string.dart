class UiString {
  UiString._internal();

  static final UiString _instance = UiString._internal();

  factory UiString() {
    return _instance;
  }
  
  final String invalidLoginAlert ='Please enter with valid credentials!';
  final String somethingWentWrong = 'Something went wrong. Please try again!';
}
