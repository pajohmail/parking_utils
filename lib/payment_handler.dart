/// This class is responsible for handling the payment process.
/// It will only be a simplefied empty class for simulate a phonnumber based payment.
class PaymentHandler {
  /// This method will simulate the payment process.
  /// It will return a Future<bool> with the result of the payment.
  Future<bool> pay(String phoneNumber, double amount) async {
    // Simulate the payment process
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  /// This method will simulate the refund process.
  /// It will return a Future<bool> with the result of the refund.
  Future<bool> refund(String phoneNumber, double amount) async {
    // Simulate the refund process
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
