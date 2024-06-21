
class Coin{
  Coin({
     this.name,
     this.symbol,
     this.image,
     this.currentPrice,
     this.priceChange24H,
     this.priceChangePercentage24H,

});

  String? name;
  String? symbol;
  String? image;
  double? currentPrice;
  double? priceChange24H;
  double? priceChangePercentage24H;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json["name"],
      symbol: json["symbol"],
      image: json["image"],
      currentPrice: json['current_price'].toDouble(),
      priceChange24H: json["price_change_24h"],
      priceChangePercentage24H: json["price_change_percentage_24h"],

    );
  }
}
List<Coin> coinList = [];