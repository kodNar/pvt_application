import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/pages/Profile.dart';


void main(){

  test('title', () {

  });

  /// If you give an empty nickname return "Your nickname cant be empty"
  test('empty nickname returns error string', (){
    var result = NicknameValidator.validate('');
    expect(result, 'Your nickname cant be empty');
  });

  /// If you give an functioning nickname return "null"
  test('non-empty nickname returns null', () {
    var result = NicknameValidator.validate('nickname');
    expect(result, null);
  });

  /// If you give a nickname that contains spaces
  test('space in the nickname returns error string', (){
    var result = NicknameValidator.validate('Einar Edberg');
    expect(result, 'No spaces allowed in the nickname');
  });


}