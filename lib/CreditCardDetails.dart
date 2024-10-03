class CreditCardDetails {
  String _cardNumber;
  String _expiryDate;
  String _cvvCode;

  CreditCardDetails({
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
  })  : _cardNumber = cardNumber,
        _expiryDate = expiryDate,
        _cvvCode = cvvCode;
}