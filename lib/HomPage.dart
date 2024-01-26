import 'package:currency_converter2/services/api_client.dart';
import 'package:currency_converter2/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Setting Colors
Color mainColor = const Color(0xFF212936);
Color secondColor = const Color(0x0ff289e5);


class _HomePageState extends State<HomePage> {
  // API Client Class Instace
  ApiClient client = ApiClient();
  
  // Variables 
  List<String>currencies = []; 
  String from= '', to= ''; 
  
  // Exchage rate variaables 
  double rate = 0; String result='';

  // function to call API
  Future<List<String>> getCurrencyList() async {
    return await client.getCurrencies();
  }

 @override
  void initState() {
  super.initState();
  (() async {
    List<String> list = await client.getCurrencies();
    setState(() {
      currencies = list;
      from = currencies.isNotEmpty ? currencies[0] : '';
      to = currencies.isNotEmpty ? currencies[0] : '';
    });
  })();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16, vertical: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(

                  // App Title 
                  width: 200,
                  child: Text('Currency Converter', style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),),
                ),

                // Input section
                Expanded(child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text Field
                      TextField(
                        onSubmitted: (value) async {
                          try {
                            // Exchange Rate
                            rate = await client.getRate(from, to);
                            setState(() {
                              String convertedAmount = (rate * double.parse(value)).toStringAsFixed(3);
                              result = '$to $convertedAmount';

                            });
                          } catch (e) {
                            print('Error calculating exchange rate: $e');
                            // Handle the error gracefully
                          }
                        },
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Input value to convert",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          )
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Custom Widget for Currency Dropdown Button - 1
                          customDropDown(currencies, from, (val) {
                            setState(() {
                              from = val;
                            });
                          }),
                          // Swap button
                          FloatingActionButton(
                            onPressed: (){
                              setState(() {
                                String temp =from;
                                from = to; 
                                to = temp;
                              });
                            },
                            elevation: 0,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.swap_horiz),
                          ),
                          // Custom Widget for Currency Dropdown Button - 2
                          customDropDown(currencies, to, (val) {
                            setState(() {
                              to = val;
                            });
                          }),
                      ],), const SizedBox(height: 50,),

                      // Display area
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:  Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text("Converted Amount",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(result,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))


              ],
            ) 
          ),
      ),
    );
  }




}