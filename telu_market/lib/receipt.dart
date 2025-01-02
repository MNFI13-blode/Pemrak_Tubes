import 'package:flutter/material.dart';
import 'package:telu_market/home.dart';

class ReceiptScreen extends StatefulWidget{
  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt", style: TextStyle(fontSize: 14),),
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, 
                MaterialPageRoute(builder: (context) => HomeScreen()));
          }, 
          icon: Icon(Icons.arrow_back)),
      ),
      body: PageView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text("Id Pembayaran:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Id Barang"
                      ),
                      Text(
                        "Jumlah Barang"
                      ),
                      Text(
                        "Harga Satuan"
                      ),
                    ],
                  ),
                  Divider(),
                
                  Text(
                    "Total Pembayaran"
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}