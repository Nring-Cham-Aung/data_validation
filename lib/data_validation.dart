

import 'package:data_validation/data_types.dart';
import 'package:data_validation/type_property.dart';

import 'common.dart';
import 'v_error.dart';
import 'v_result.dart';
import 'validate.dart';


/// * [MultiValidation] is used to validate multiple data with multiple rules.
class MultiValidation extends Common {
  final Map<String,dynamic> _data;

  final Map<String, Validate> _rules;

  /// ## Example
  /// ```
  /// final vr = MultiValidation(data, {
  ///   'name': Validation.string().max(30),
  ///   'gender': Validation.string().only(['Male', 'Female']),
  ///   'age': Validation.integer().min(0).max(150),
  ///   'address': Validation.string(nullAble: true).max(200),
  ///   'email': Validation.email().mustEnd(['.com','.org'])
  /// }).validate();
  /// ```
  MultiValidation(this._data, this._rules);

  VResult validate(){
    
    try {
      Iterable<String> keys = _rules.keys;
      for(String k in _data.keys){
        if(!keys.contains(k)) throw VError('Unregistered key found "$k"');
      }

      final Map<String,dynamic> validData = {};
      for (var e in _rules.entries) {
        if(!_data.containsKey(e.key)) throw VError('${e.key} is required');
        dynamic r = valid(_data[e.key], e);
        validData[e.key] = r;
      }

      return VResult.ok(validData);
    } catch (e) {
      if(e is VError) return VResult.fail(e.message);
      return VResult.fail('Unknow error!');
    }
  }

}


/// * [SingleValidation] is used to validate a single data with a rule.
class SingleValidation extends Common {
  final dynamic _value;
  final Validate _validate;

  /// ## Example
  /// ```
  /// final vr = SingleValidation(yourData, Validation.string().only(['Male', 'Female'])).validate();
  /// final vr = SingleValidation(yourData, Validation.email().mustEnd(['.com','.org'])).validate();
  /// ```
  SingleValidation(this._value, this._validate);

  VResult validate(){
    try {
      final Map<String,dynamic> validData = {};
      valid(_value, MapEntry('data', _validate));
      return VResult.ok(validData);
    } catch (e) {
      if(e is VError) return VResult.fail(e.message);
      return VResult.fail('Unknow error!');
    }
  }

}


/// * [Validation] provides static methods to create various data type validators with specified properties.
class Validation {
  static Str string({bool nullAble = false, String? nullValue})  => Str(TypeProperty(nullAble, nullValue));
  static Integer integer({bool nullAble = false, int? nullValue})  => Integer(TypeProperty(nullAble, nullValue));
  static Decimal decimal({bool nullAble = false, double? nullValue})  => Decimal(TypeProperty(nullAble, nullValue));
  static Boolean boolean({bool nullAble = false, bool? nullValue})  => Boolean(TypeProperty(nullAble, nullValue));
  static Datetime datetime({bool nullAble = false, DateTime? nullValue})  => Datetime(TypeProperty(nullAble, nullValue));
  static Email email({bool nullAble = false, String? nullValue})  => Email(TypeProperty(nullAble, nullValue));
}
