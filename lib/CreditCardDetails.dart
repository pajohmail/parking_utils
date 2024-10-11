class CreditCardDetails {
  String _cardNumber = "";
  String _expiryDate = "";
  String _cvvCode = "";

  CreditCardDetails({
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
  })  : _cardNumber = cardNumber,
        _expiryDate = expiryDate,
        _cvvCode = cvvCode;



  // Getters
  String get cardNumber => _cardNumber;
  String get expiryDate => _expiryDate;
  String get cvvCode => _cvvCode;

  // Setters
  set cardNumber(String cardNumber) {
    _cardNumber = cardNumber;
  }

  set expiryDate(String expiryDate) {
    _expiryDate = expiryDate;
  }

  set cvvCode(String cvvCode) {
    _cvvCode = cvvCode;
  }
}