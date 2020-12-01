class Card {
  String cardNumber;
  int expireMonth;
  int expireYear;
  int cvv;


Card(
  this.cardNumber,
  this.cvv,
  this.expireMonth,
  this.expireYear,
);

Card.empty();

}