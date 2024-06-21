import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coin_model.dart';
import 'coin_card.dart';

class CoinDemo extends StatefulWidget {
  const CoinDemo({super.key});

  @override
  State<CoinDemo> createState() => _CoinDemoState();
}

class _CoinDemoState extends State<CoinDemo> {


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 150,
      width: 500,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return CoinCard(
              name: coinList[index].name ?? '',
              symbol: coinList[index].symbol ?? '',
              image: coinList[index].image ?? '',
              currentPrice: coinList[index].currentPrice ?? 0,
              priceChange24H: coinList[index].priceChange24H ?? 0,
              priceChangePercentage24H: coinList[index].priceChangePercentage24H ?? 0);
        },
      ),
    );
  }
}
