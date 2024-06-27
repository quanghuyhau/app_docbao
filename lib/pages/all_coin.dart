import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/coin_model.dart';

class AllCoins extends StatelessWidget {
  final List<Coin> coins;
  AllCoins({required this.coins});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tin tức về Coin",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: coins.length,
            itemBuilder: (context, index) {
              return CoinTile(
                  image: coins[index].image!,
                  name: coins[index].name!,
                  symbol: coins[index].symbol!,
                  currentPrice: coins[index].currentPrice!,
                  priceChange24H: coins[index].priceChange24H!,
                  priceChangePercentage24H: coins[index].priceChangePercentage24H!);
            }),
      ),
    );
  }
}

class CoinTile extends StatelessWidget {
  final String image, name, symbol;
  final double currentPrice, priceChange24H, priceChangePercentage24H;

  CoinTile({
    required this.image,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0),
                      ),
                      Text(
                        symbol,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "\$${currentPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      Text(
                        "24h: ${priceChange24H.toStringAsFixed(2)} (${priceChangePercentage24H.toStringAsFixed(2)}%)",
                        style: TextStyle(
                            color: priceChange24H > 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
