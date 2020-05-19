import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/pages/HomePage.dart';

void main(){

  test('title', () {

    //Setup


    //Run


    //Verify
  });

  /// If you give an empty email return "Please provide an Email"
  test('empty email returns error string', (){
    var result = EmailFieldValidator.validate('');
    expect(result, 'Please provide an Email');

  });

  /// If you give an email that does not exist in the database return "null"
  test('non-empty email returns null', () { //if you give an email that does not exist return null
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  /// If you give an empty password return "Please provide a password"
  test('empty email returns error string', (){
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Please provide a password');
  });
  /// If you give an email that does not exist in the database return "null"
    test('non-empty password returns null', (){
      var result = PasswordFieldValidator.validate('password');
      expect(result, null);
    });
  /// If you give a shorter password than 6 return 'The password needs to be at least 6 characters'
  test('short password', (){
    var result = PasswordFieldValidator.validate('short');
    expect(result, 'The password needs to be at least 6 characters');
  });



}