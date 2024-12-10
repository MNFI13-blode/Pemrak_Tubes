import 'package:flutter/material.dart';

class DeskripsiProduk extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deskripsi Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('HQ Mechanic Pencil 2B'),
            Text('Pensil memiliki ketebalan yang pas untuk menulis serta menggambar'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        }, 
        child: Text('Add to cart'),
      ),
    );
  }
}