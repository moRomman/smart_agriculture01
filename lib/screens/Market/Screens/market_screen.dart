
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture/Shared/consts.dart';
import 'package:smart_agriculture/screens/Market/Repository/product_model.dart';
import 'package:smart_agriculture/screens/Market/Screens/add_product_widget.dart';
import 'package:smart_agriculture/screens/Market/Screens/product_widget.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.mainColor,
              Colors.blueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Stack(
            children: [
              _buildProductStream(),
              _buildAddProductButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductStream() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Error loading products"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No products available"),
          );
        }

        return _buildProductGrid(snapshot.data!.docs);
      },
    );
  }

  Widget _buildProductGrid(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (context, index) {
        final data = docs[index].data();
        final product = Product.fromJson(data);

        return ProductWidget(
          heroTag: 'product-${product.productId}', // Unique hero tag
          product: product,
        );
      },
    );
  }

  Widget _buildAddProductButton(BuildContext context) {
    return Positioned(
      bottom: kToolbarHeight,
      right: 16,
      child: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        backgroundColor: MyColors.mainColor,
        child: const Icon(Icons.add_business_outlined),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddProductDialog(),
    );
  }
}
