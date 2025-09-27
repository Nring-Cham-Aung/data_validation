
/// * [VError] represents a validation error with a message.
class VError extends Error{
  final String message;
  VError(this.message);
}