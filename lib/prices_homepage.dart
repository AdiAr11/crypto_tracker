import 'package:crypto_tracker/price_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceHomepage extends StatefulWidget {
  const PriceHomepage({Key? key}) : super(key: key);

  @override
  State<PriceHomepage> createState() => _PriceHomepageState();
}

class _PriceHomepageState extends State<PriceHomepage> {

  String selectedCurrency = currenciesList.first;
  String price = "1 BTC = ? ${currenciesList[0]}";
  String priceOfETH = "1 ETH = ? ${currenciesList[0]}";
  String priceOfLTC = "1 LTC = ? ${currenciesList[0]}";

  @override
  Widget build(BuildContext context) {
    fetchBTCPrices();
    return Scaffold(
        appBar: AppBar(
          title: const Text("😃 Coin Ticker"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //TODO 2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
              //TODO 3: You'll need to use a Column Widget to contain the three CryptoCards.
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PriceCard(price: price),
                  PriceCard(price: priceOfETH),
                  PriceCard(price: priceOfLTC),
                ],
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: androidDropdown(),
                // child: Platform.isIOS ? iosPicker() : androidDropdown()
              ),
            ],
        ),
    );
  }

  void fetchBTCPrices() async {
    try {
      double rate = await fetchData(cryptoList[0],selectedCurrency);
      price = "1 BTC = ${rate.toStringAsFixed(3)} $selectedCurrency";
    }catch(e){
      print(e);
    }
  }

  void fetchETHPrices() async {
    try {
      double rate = await fetchData(cryptoList[1],selectedCurrency);
      priceOfETH = "1 ETH = ${rate.toStringAsFixed(3)} $selectedCurrency";
    }catch(e){
      print(e);
    }
  }

  void fetchLTCPrices() async {
    try {
      double rate = await fetchData(cryptoList[2],selectedCurrency);
      priceOfLTC = "1 LTC = ${rate.toStringAsFixed(3)} $selectedCurrency";
    }catch(e){
      print(e);
    }
  }

  DropdownButton<String> androidDropdown(){

    return DropdownButton<String>(
      value: selectedCurrency,
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          selectedCurrency = newValue!;
        });
      },
      items: currenciesList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          // getData();
        });
      },
      children: pickerItems,
    );
  }

  CupertinoPicker iosPicker(){
    return CupertinoPicker(
        magnification: 1.22,
        squeeze: 1.2,
        useMagnifier: true,
        itemExtent: 32.0,
        // This is called when selected item is changed.
        onSelectedItemChanged: (int selectedItem) {
      setState(() {
        selectedCurrency = currenciesList[selectedItem];
        fetchBTCPrices();
        print("$selectedCurrency -> $price");
      });
    },
    children:
    List<Widget>.generate(currenciesList.length, (int index){
      return Text(
          currenciesList[index],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 19.0
        ),
      );
    })
    );
  }

}
