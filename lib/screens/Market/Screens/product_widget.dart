// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_agriculture/screens/Community/Repository/post_repository.dart';

// import '../../../../Shared/consts.dart';
// import '../Repository/product_model.dart';

// class ProductWidget extends StatefulWidget {
//   final Product product;
//   final String heroTag; // Add this line

//   const ProductWidget({super.key, required this.product, required this.heroTag});

//   @override
//   ProductWidgetState createState() => ProductWidgetState();
// }

// class ProductWidgetState extends State<ProductWidget> {
//   late Future<bool> _isProductFav;

//   @override
//   void initState() {
//     super.initState();
//     _isProductFav = PostUtils.isFavProduct(widget.product.productId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 4,
//         child: GridTile(
//           header: FutureBuilder<bool>(
//             future: PostUtils.isFavProduct(widget.product.productId),
//             builder: (context, snapshot) {
//               return Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   style: const ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll(Colors.white),
//                   ),
//                   onPressed: () {
//                     PostUtils.addfavProduct(
//                         productID: widget.product.productId);
//                     setState(() {
//                       _isProductFav = Future.value(true); // Update future value
//                     });
//                   },
//                   icon: Icon(
//                     snapshot.data == true
//                         ? Icons.favorite
//                         : Icons.favorite_border,
//                     color: snapshot.data == true ? Colors.red : Colors.grey,
//                   ),
//                 ),
//               );
//             },
//           ),
//           footer: Container(
//             color: Colors.black.withOpacity(0.7),
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.product.content,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       flex: 4,
//                       child: Text(
//                         'Amount: ${widget.product.amount.trim()}',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     const Spacer(
//                       flex: 1,
//                     ),
//                     Flexible(
//                       flex: 4,
//                       child: Text(
//                         'Price: ${widget.product.price.trim()}',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           child: GestureDetector(
//             onTap: () {
//               showDialog(
//                   context: context,
//                   builder: (context) => ProductDetailsDialog(
//                         product: widget.product,
//                       ));
//             },
//             child: Hero(
//               tag: widget.heroTag, // Use the heroTag here
//               child: Image.network(
//                 widget.product.productImage,
//                 fit: BoxFit.fitHeight,
//                 errorBuilder: (context, error, stackTrace) => const Image(
//                     image: AssetImage('images/splash.jpg'),
//                     fit: BoxFit.fitWidth),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProductDetailsDialog extends StatelessWidget {
//   final Product product;

//   const ProductDetailsDialog({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }

//   Widget contentBox(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.rectangle,
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           if (product.uId == FirebaseAuth.instance.currentUser!.uid) ...{
//             IconButton(
//               onPressed: () async {
//                 await FirebaseFirestore.instance
//                     .collection('products')
//                     .doc(product.productId)
//                     .delete()
//                     .then((value) => Navigator.pop(context));
//               },
//               icon: const Icon(Icons.delete),
//             ),
//           },
//           Image.network(
//             product.productImage,
//             height: 200,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'User Name: ${product.userName}',
//                   textScaler: const TextScaler.linear(1.8),
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green.shade800),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   'Description: ${product.content}',
//                   style: const TextStyle(color: MyColors.mainColor),
//                   textScaler: const TextScaler.linear(1.5),
//                 ),
//                 Text(
//                   'Price: ${product.price}',
//                   style: const TextStyle(color: MyColors.mainColor),
//                   textScaler: const TextScaler.linear(1.5),
//                 ),
//                 Text(
//                   'Amount: ${product.amount}',
//                   style: const TextStyle(color: MyColors.mainColor),
//                   textScaler: const TextScaler.linear(1.5),
//                 ),
//                 Text(
//                   'Phone: ${product.phone}',
//                   style: const TextStyle(color: MyColors.mainColor),
//                   textScaler: const TextScaler.linear(1.5),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture/screens/Community/Repository/post_repository.dart';

import '../../../../Shared/consts.dart';
import '../Repository/product_model.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final String heroTag;

  const ProductWidget(
      {super.key, required this.product, required this.heroTag});

  @override
  ProductWidgetState createState() => ProductWidgetState();
}

class ProductWidgetState extends State<ProductWidget> {
  late Future<bool> _isProductFav;

  @override
  void initState() {
    super.initState();
    _isProductFav = PostUtils.isFavoriteProduct(widget.product.productId);
  }

  Future<void> _toggleFavorite() async {
    await PostUtils.toggleFavoriteProduct(widget.product.productId);
    setState(() {
      _isProductFav = Future.value(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: GridTile(
          header: _buildFavoriteButton(),
          footer: _buildProductInfo(),
          child: _buildProductImage(context),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return FutureBuilder<bool>(
      future: _isProductFav,
      builder: (context, snapshot) {
        return Align(
          alignment: Alignment.topRight,
          child: IconButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            onPressed: _toggleFavorite,
            icon: Icon(
              snapshot.data == true ? Icons.favorite : Icons.favorite_border,
              color: snapshot.data == true ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductInfo() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: Text(
                  'Amount: ${widget.product.amount.trim()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(flex: 1),
              Flexible(
                flex: 4,
                child: Text(
                  'Price: ${widget.product.price.trim()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ProductDetailsDialog(product: widget.product),
        );
      },
      child: Hero(
        tag: widget.heroTag,
        child: Image.network(
          widget.product.productImage,
          fit: BoxFit.fitHeight,
          errorBuilder: (context, error, stackTrace) => const Image(
            image: AssetImage('images/splash.jpg'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class ProductDetailsDialog extends StatelessWidget {
  final Product product;

  const ProductDetailsDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (product.uId == FirebaseAuth.instance.currentUser?.uid)
            _buildDeleteButton(context),
          Image.network(
            product.productImage,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildProductDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(product.productId)
            .delete()
            .then((value) => Navigator.pop(context));
      },
      icon: const Icon(Icons.delete),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Name: ${product.userName}',
          textScaler: const TextScaler.linear(1.8),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        const SizedBox(height: 5),
        _buildDetailRow('Description', product.content),
        _buildDetailRow('Price', product.price),
        _buildDetailRow('Amount', product.amount),
        _buildDetailRow('Phone', product.phone),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(color: MyColors.mainColor),
      textScaler: const TextScaler.linear(1.5),
    );
  }
}
