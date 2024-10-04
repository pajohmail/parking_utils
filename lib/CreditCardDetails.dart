class CreditCardDetails {
  String _cardNumber="";
  String _expiryDate="";
  String _cvvCode="";

  CreditCardDetails({
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
  })  : _cardNumber = cardNumber,
        _expiryDate = expiryDate,
        _cvvCode = cvvCode;
}

//getters and setters
String getCardNumber(CreditCardDetails creditCardDetails) {
  return creditCardDetails._cardNumber;
}

String getExpiryDate(CreditCardDetails creditCardDetails) {
  return creditCardDetails._expiryDate;
}

String getCvvCode(CreditCardDetails creditCardDetails) {
  return creditCardDetails._cvvCode;
}

void setCardNumber(CreditCardDetails creditCardDetails, String cardNumber) {
  creditCardDetails._cardNumber = cardNumber;
}

void setExpiryDate(CreditCardDetails creditCardDetails, String expiryDate) {
  creditCardDetails._expiryDate = expiryDate;
}


void setCvvCode(CreditCardDetails creditCardDetails, String cvvCode) {
  creditCardDetails._cvvCode = cvvCode;
}

