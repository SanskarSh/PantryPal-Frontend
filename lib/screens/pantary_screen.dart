import 'package:flutter/material.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const TabBar(
            labelColor: Colors.white,
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text('All'),
              ),
              Tab(
                child: Text('Fruits'),
              ),
              Tab(
                child: Text('Vegetables'),
              ),
              Tab(
                child: Text('Dairy'),
              ),
              Tab(
                child: Text('Bakery'),
              ),
              Tab(
                child: Text('Meat'),
              ),
              Tab(
                child: Text('Spices'),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    buildTile(context),
                    buildTile(context),
                    buildTile(context),
                    buildTile(context),
                    buildTile(context),
                  ],
                ),
              ),
            ),
            const Center(
              child: Text('Fruits'),
            ),
            const Center(
              child: Text('Vegetables'),
            ),
            const Center(
              child: Text('Dairy'),
            ),
            const Center(
              child: Text('Bakery'),
            ),
            const Center(
              child: Text('Meat'),
            ),
            const Center(
              child: Text('Spices'),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Column(
                children: [
                  const Text('Product Name'),
                  const Text('Qty'),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        leading: const Icon(Icons.fastfood_outlined),
        title: const Text("Product Name"),
        subtitle: const Text("Qty"),
      ),
    );
  }
}
