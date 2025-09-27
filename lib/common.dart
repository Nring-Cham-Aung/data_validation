import 'obj_type.dart';
import 'type_property.dart';
import 'v_error.dart';
import 'validate.dart';

/// * [Common] is a base class providing common validation functionalities.
abstract class Common {
  final RegExp _emailRegex = RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$');

  dynamic valid(dynamic value, MapEntry<String, Validate> validate){
    final stack = validate.value.stack;
    final fv = stack.first.value as TypeProperty;
    switch (stack.first.name) {
      case ObjType.str:
        if(value == null){
          if(fv.nullAble) return null;
          if(fv.nullValue is String) return fv.nullValue as String;
          throw VError('${validate.key} is required.');
        }
        if(value is! String) throw VError('${validate.key} must be a String value.');
        String v = value;
        for(var e in stack.where((vs)=>vs.name!=ObjType.str)){
          switch (e.name) {
            case ObjType.min:
              if(!(v.length>=(e.value as int))) {
                throw VError('minimal length of ${validate.key} must be ${e.value}.');
              }
              break;
            case ObjType.max:
              if(!(v.length<=(e.value as int))) {
                throw VError('maximan length of ${validate.key} must be ${e.value}.');
              }
              break;
            case ObjType.len:
              if(v.length!=(e.value as int)) {
                throw VError('the length of ${validate.key} must be ${e.value}.');
              }
              break;
            case ObjType.only:
              if(!(e.value as List<String>).contains(v)) {
                throw VError('${validate.key} must be one of this ${e.value}.');
              }
              break;
            default:
              throw VError('unknow error occured at ${validate.key}.');
          }
        }
        return v;
      case ObjType.integer:
        if(value == null){
          if(fv.nullAble) return null;
          if(fv.nullValue is int) return fv.nullValue as int;
          throw VError('${validate.key} is required.');
        }
        int? v = int.tryParse('$value');
        if(v==null) throw VError('${validate.key} must be an integer value.');
        for(var e in stack.where((vs)=>vs.name!=ObjType.integer)){
          switch (e.name) {
            case ObjType.min:
              if(!(v>=(e.value as int))) {
                throw VError('${validate.key} cannot be less than ${e.value}.');
              }
              break;
            case ObjType.max:
              if(!(v<=(e.value as int))) {
                throw VError('${validate.key} cannot be greater than ${e.value}.');
              }
              break;
            case ObjType.only:
              if(!(e.value as List<int>).contains(v)) {
                throw VError('${validate.key} must be one of this ${e.value}.');
              }
              break;
            default:
              throw VError('unknow error occured at ${validate.key}.');
          }
        }
        return v;
      case ObjType.decimal:
        if(value == null){
          if(fv.nullAble) return null;
          if(fv.nullValue is double) return fv.nullValue as double;
          throw VError('${validate.key} is required.');
        }
        double? v = double.tryParse('$value');
        if(v==null) throw VError('${validate.key} must be a decimal value.');
        for(var e in stack.where((vs)=>vs.name!=ObjType.decimal)){
          switch (e.name) {
            case ObjType.min:
              if(!(v>=(e.value as double))) {
                throw VError('${validate.key} cannot be less than ${e.value}.');
              }
              break;
            case ObjType.max:
              if(!(v<=(e.value as double))) {
                throw VError('${validate.key} cannot be greater than ${e.value}.');
              }
              break;
            case ObjType.only:
              if(!(e.value as List<double>).contains(v)) {
                throw VError('${validate.key} must be one of this ${e.value}.');
              }
              break;
            default:
              throw VError('unknow error occured at ${validate.key}.');
          }
        }
        return v;
      case ObjType.boolean:
        if(value == null){
          if(fv.nullAble) return null;
          if(fv.nullValue is bool) return fv.nullValue as bool;
          throw VError('${validate.key} is required.');
        }
        bool? v = bool.tryParse('$value', caseSensitive: false);
        if(v==null) throw VError('${validate.key} must be a TRUE or FALSE value.');
        return v;
      case ObjType.datetime:
        if(value == null){
          if(fv.nullAble) return null;
          if(fv.nullValue is DateTime) return fv.nullValue as DateTime;
          throw VError('${validate.key} is required.');
        }
        DateTime? v = DateTime.tryParse('$value');
        if(v==null) throw VError('${validate.key} must be a DateTime value.');
        for(var e in stack.where((vs)=>vs.name!=ObjType.datetime)){
          switch (e.name) {
            case ObjType.min:
              if(!v.isAfter(e.value as DateTime)) {
                throw VError('${validate.key} cannot be before than ${e.value}.');
              }
              break;
            case ObjType.max:
              if(!v.isBefore(e.value as DateTime)) {
                throw VError('${validate.key} cannot be after than ${e.value}.');
              }
              break;
            case ObjType.only:
              if(!(e.value as List<DateTime>).contains(v)) {
                throw VError('${validate.key} must be one of this ${e.value}.');
              }
              break;
            default:
              throw VError('unknow error occured at ${validate.key}.');
          }
        }
        return v;
      case ObjType.email:
        if(value == null){
          if(fv.nullAble) return null;
          if(fv.nullValue is String){
            if(_emailRegex.hasMatch(fv.nullValue)) {
              return fv.nullValue as String;
            }
            throw VError('default nullValue is not valid email address at ${validate.key}');
          }
          throw VError('${validate.key} is required.');
        }
        if(value is! String) throw VError('${validate.key} must be a valid email.');
        String v = value;
        for(var e in stack.where((vs)=>vs.name!=ObjType.email)){
          switch (e.name) {
            case ObjType.mustend:
              bool isEnd = false;
              for(String ending in e.value as List<String>){
                if(v.endsWith(ending)){isEnd = true;}
              }
              if(!isEnd) {
                throw VError('${validate.key} must end one of this ${e.value}.');
              }
              break;
            default:
              throw VError('unknow error occured at ${validate.key}.');
          }
        }
        return v;
      default:
      throw VError('Unregistered key found ~ ${validate.key}');
    }
    
  }

}