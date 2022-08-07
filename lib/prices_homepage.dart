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
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBTCPrices();
    fetchETHPrices();
    fetchLTCPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Crypto Tracker"),
          backgroundColor: Colors.lightBlue,
        ),
        body: isLoading ? const Center(child: CircularProgressIndicator()) :
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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

  Future fetchBTCPrices() async {
    // setState(() {
    //   isLoading = true;
    // });
    try {
      double rate = await fetchData(cryptoList[0],selectedCurrency);
      price = "1 BTC = ${rate.toStringAsFixed(3)} $selectedCurrency";
    }catch(e){
      throw(e.toString());
    }
    setState(() {

    });
    // setState(() {
    //   isLoading = false;
    // });
  }

  Future fetchETHPrices() async {
    try {
      double rate = await fetchData(cryptoList[1],selectedCurrency);
      priceOfETH = "1 ETH = ${rate.toStringAsFixed(3)} $selectedCurrency";
    }catch(e){
      throw(e.toString());
    }
    setState(() {

    });
  }

  Future fetchLTCPrices() async {
    try {
      double rate = await fetchData(cryptoList[2],selectedCurrency);
      priceOfLTC = "1 LTC = ${rate.toStringAsFixed(3)} $selectedCurrency";
    }catch(e){
      throw(e.toString());
    }
    setState(() {

    });
  }

  DropdownButton<String> androidDropdown(){

    return DropdownButton<String>(
      value: selectedCurrency,
      elevation: 16,
      onChanged: (String? newValue) async {
        setState(() {
          selectedCurrency = newValue!;
        });
        await fetchBTCPrices();
        await fetchETHPrices();
        await fetchLTCPrices();
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
        // print("$selectedCurrency -> $price");
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
