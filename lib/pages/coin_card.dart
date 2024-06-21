import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String image;
  final double currentPrice;
  final double priceChange24H;
  final double priceChangePercentage24H;

  CoinCard({
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 120,
        width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.tealAccent,
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(image),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        symbol,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
              "\$ " + currentPrice.toString(),
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    priceChange24H.toDouble() < 0
                        ? priceChange24H.toString() + " \$"
                        : '+' + priceChange24H.toString()+ " \$",
                    style: TextStyle(
                      color: priceChange24H < 0 ? Colors.red : Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    priceChangePercentage24H < 0
                        ? priceChangePercentage24H.toString() + '%'
                        : '+' + priceChangePercentage24H.toString() + '%',
                    style: TextStyle(
                      color: priceChangePercentage24H < 0
                          ? Colors.red
                          : Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
