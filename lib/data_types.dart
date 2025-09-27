
import 'obj_type.dart';
import 'stack.dart';
import 'type_property.dart';
import 'utils.dart';
import 'validate.dart';

/// * This is a top level data type class for [String] data type.
class Str extends Validate {

  Str(TypeProperty property){super.stack.add(Stack(ObjType.str, property));}

  Min min(int min) => Min(min, super.stack);

  Max max(int max) => Max(max, super.stack);

  Max length(int len) => Max(len, super.stack);

  Only only(List<String> allow) => Only(allow, super.stack);

}

/// * This is a top level data type class for [int] data type.
class Integer extends Validate {
  Integer(TypeProperty property){super.stack.add(Stack(ObjType.integer, property));}

  Min min(int min) => Min(min, super.stack);

  Max max(int max) => Max(max, super.stack);

  Only only(List<int> allow) => Only(allow, super.stack);
}

/// * This is a top level data type class for [double] data type.
class Decimal extends Validate {
  Decimal(TypeProperty property){super.stack.add(Stack(ObjType.decimal, property));}

  Min min(double min) => Min(min, super.stack);

  Max max(double max) => Max(max, super.stack);

  Only only(List<int> allow) => Only(allow, super.stack);
}

/// * This is a top level data type class for [bool] data type.
class Boolean extends Validate {
  Boolean(TypeProperty property){super.stack.add(Stack(ObjType.boolean, property));}
}

/// * This is a top level data type class for [DateTime] data type.
class Datetime extends Validate {
  Datetime(TypeProperty property){super.stack.add(Stack(ObjType.datetime, property));}

  Min min(DateTime min) => Min(min, super.stack);

  Max max(DateTime max) => Max(max, super.stack);

  Only only(List<DateTime> allow) => Only(allow, super.stack);
}

/// * This is a top level data type class for [DateTime] data type.
class Dateonly extends Validate {
  Dateonly(TypeProperty property){
    super.stack.add(Stack(ObjType.datetime, TypeProperty(
      property.nullAble, 
      property.nullValue is DateTime? 
      DateTime((property.nullValue as DateTime).year, (property.nullValue as DateTime).month, (property.nullValue as DateTime).day )
      :null)));
  }

  Min min(DateTime min) => Min(DateTime(min.year,min.month,min.day), super.stack);

  Max max(DateTime max) => Max(DateTime(max.year,max.month,max.day), super.stack);

  Only only(List<DateTime> allow) => Only(allow.map((e)=>DateTime(e.year,e.month,e.day)).toList(), super.stack);
}

/// * This is a top level data type class for valid [Email].
class Email extends Validate {
  
  Email(TypeProperty property){super.stack.add(Stack(ObjType.email, property));}

  MustEnd mustEnd(List<String> allow) => MustEnd(allow, super.stack);

}