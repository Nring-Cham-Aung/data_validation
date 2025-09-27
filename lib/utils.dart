import 'obj_type.dart';
import 'stack.dart';
import 'validate.dart';

/// * [Min] adds a minimum constraint to the validation stack.
class Min extends Validate {
  Min(dynamic min, List<Stack> stack){
    super.stack.addAll([...stack,Stack(ObjType.min, min)]);
  }
  Max max(dynamic max) => Max(max, super.stack);
}

/// * [Max] adds a maximum constraint to the validation stack.
class Max extends Validate {
  Max(dynamic max, List<Stack> stack){
    super.stack.addAll([...stack,Stack(ObjType.max, max)]);
  }
  Min min(dynamic min) => Min(min, super.stack);
}

/// * [Len] adds a length constraint to the validation stack.
class Len extends Validate {
  Len(int len, List<Stack> stack){
    super.stack.addAll([...stack,Stack(ObjType.len, len)]);
  }
}

/// * [Only] adds an allowed values constraint to the validation stack.
class Only extends Validate {
  Only(List<dynamic> allow, List<Stack> stack){
    super.stack.addAll([...stack,Stack(ObjType.only, allow)]);
  }
}

/// * [MustEnd] adds a must-end-with constraint to the validation stack.
class MustEnd extends Validate {
  MustEnd(List<dynamic> allow, List<Stack> stack){
    super.stack.addAll([...stack,Stack(ObjType.mustend, allow)]);
  }
}