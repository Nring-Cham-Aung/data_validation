import 'dart:convert';


/// * [VResult] represents the result of a validation process, including error status, message, and data.
class VResult {
  final bool error;
  final String message;
  final Map<String,dynamic> data;
  VResult({required this.error, required this.message, required this.data});

  static VResult ok(Map<String,dynamic> data) => VResult(error: false, message: 'Ok', data: data);
  static VResult fail(String errorMessage) => VResult(error: true, message: errorMessage, data: {});

  Map<String,dynamic> toJson () => {"error":error, "message": message, "data": data};

  @override
  String toString(){
    return jsonEncode(toJson());
  }

}