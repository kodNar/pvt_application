import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/pages/WorkoutLog.dart';

void main(){
  test('title', (){


  });

  /// //////////////////////////////////////////////////////////////////////////
  /// TEST FOR SETS
  /// //////////////////////////////////////////////////////////////////////////

/// If you give an empty set return "Please add at least 1 set"
test('exercise with empty set', (){
  var result = SetFieldValidator.validate('');
  expect(result, 'Please add at least 1 set');
});

///If you give it letters instead of numbers return "Input needs to be digits only"
  test('exercise with letters as input', (){
    var result = SetFieldValidator.validate('Einar');
    expect(result, 'Input needs to be digits only');
  });

  ///If you give it negative inputs return 'Input needs to be 1 or higher only'
  test('exercise with minus inputs such as (-5)', (){
    var result = SetFieldValidator.validate('-5');
    expect(result, 'Input needs to be 1 or higher');
  });

  ///If you give it an overwhelming input return 'There is no way you did that amount of sets'
  test('exercise with overwhelming amount of input 99<input', () {
    var result = SetFieldValidator.validate('100');
    expect(result, 'There is no way you did that amount of sets');
  });
    /// //////////////////////////////////////////////////////////////////////////
    /// TEST FOR REPS
    /// //////////////////////////////////////////////////////////////////////////


    /// If you give an empty set return "Please add at least 1 set"
    test('exercise with empty set', () {
      var result = RepFieldValidator.validate('');
      expect(result, 'Please add at least 1 set');
    });

    ///If you give it letters instead of numbers return "Input needs to be digits only"
    test('exercise with letters as input', () {
      var result = RepFieldValidator.validate('Einar');
      expect(result, 'Input needs to be digits only');
    });

    ///If you give it negative inputs return 'Input needs to be 1 or higher'
    test('exercise with minus inputs such as (-5)', () {
      var result = RepFieldValidator.validate('-5');
      expect(result, 'Input needs to be 1 or higher');
    });

    ///If you give it an overwhelming input return 'There is no way you did that amount of reps'
    test('exercise with overwhelming amount of input 999<input', () {
      var result = RepFieldValidator.validate('1000');
      expect(result, 'There is no way you did that amount of reps');
    });
}

