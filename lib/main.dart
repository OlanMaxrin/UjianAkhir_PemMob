import 'package:flutter/material.dart';
import 'services/api_service.dart'; // Pastikan path ini benar
import 'models/product.dart';       // Pastikan path ini benar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KaryaKita',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KaryaKita"),
      ),
      body: FutureBuilder<List<Product>>(
        future: apiService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("Rp ${product.price}"),
                  leading: Image.network(product.imageUrl),
                );
              },
            );
          }
        },
      ),
    );
  }
}