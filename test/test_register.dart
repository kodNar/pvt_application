import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/pages/Register.dart';

void main(){

  test('title', () {

  });

  /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// Email tests
  /// /// /// /// /// /// /// /// /// /// /// /// /// ///

  /// If you give an empty email return "Please provide an Email"
  test('empty email returns error string', (){
    var result = EmailFieldValidator.validate('');
    expect(result, 'Please provide an Email');
  });

  /// If you give an email without "@"
  test('If you give an email without @', () { //if you give an email that does not exist return null
    var result = EmailFieldValidator.validate('email');
    expect(result, 'Your email must contain @');
  });

  /// too short email
  test('If you give a too short email', () { //if you give an email that does not exist return null
    var result = EmailFieldValidator.validate('e@a');
    expect(result, 'Email is to short');
  });

  /// too long email
  test('If you give a too long email', () { //if you give an email that does not exist return null
    var result = EmailFieldValidator.validate('e@aasdasdasdasdasdhasjkdhjkasdhkjasdhkjakjhsdhjkasdkhjashdkjkhajsdkhjdkhjadskhjasdkhjkhjadskhjadshjkdhkjshkjdaskhjdaskjhadskhjadkshjhjkadskhjdaskhjkhjadskhjdashkjadhjskjkhdashjkdshkajdksahj');
    expect(result, 'That email is too long to be registered another one');
  });

  /// /// /// /// /// /// /// /// /// /// /// /// /// ///
  /// Password tests
  /// /// /// /// /// /// /// /// /// /// /// /// /// ///

  /// If you give an empty password return "Please provide a password"
  test('empt password returns error string', (){
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Please provide a password');
  });
  /// If you give a working password return "null"
  test('non-empty password returns null', (){
    var result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });

  /// If you give a shorter password than 8 return 'The password needs to be at least 8 characters'
  test('short password', (){
    var result = PasswordFieldValidator.validate('short');
    expect(result, 'The password needs to be at least 8 characters');
  });



}