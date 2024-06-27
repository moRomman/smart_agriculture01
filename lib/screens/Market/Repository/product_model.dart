// class Product {
//   String profileImageUrl;
//   String uId;
//   String userName;
//   String content;
//   String productImage;
//   String amount;
//   String price;
//   String phone;
//   String timestamp;
//   String productId;
//   List? likedBy;

//   Product({
//     required this.profileImageUrl,
//     required this.uId,
//     required this.userName,
//     required this.content,
//     required this.productImage,
//     required this.amount,
//     required this.price,
//     required this.phone,
//     required this.timestamp,
//     required this.productId,
//     required this.likedBy,
//   });

//   // Factory method to create a Product instance from a map
//   factory Product.fromJson(Map<String, dynamic> data) {
//     return Product(
//       profileImageUrl: data['profileImageUrl'] ?? '',
//       uId: data['uId'].toString(),
//       userName: data['userName'].toString(),
//       content: data['content'].toString(),
//       productImage: data['productImage'].toString(),
//       amount: data['amount'].toString(),
//       price: data['price'].toString(),
//       phone: data['phone'].toString(),
//       timestamp: data['timestamp'].toString(),
//       productId: data['productId'].toString(),
//       likedBy: data['likedBy'],
//     );
//   }

//   // Method to convert a Product instance to a map
//   Map<String, dynamic> toJson() {
//     return {
//       'profileImageUrl': profileImageUrl,
//       'uId': uId,
//       'userName': userName,
//       'content': content,
//       'productImage': productImage,
//       'amount': amount,
//       'price': price,
//       'phone': phone,
//       'timestamp': timestamp,
//       'productId': productId,
//       'likedBy': likedBy,
//     };
//   }
// }
class Product {
  final String profileImageUrl;
  final String uId;
  final String userName;
  final String content;
  final String productImage;
  final String amount;
  final String price;
  final String phone;
  final DateTime timestamp;
  final String productId;
  final List<String>? likedBy;

  Product({
    required this.profileImageUrl,
    required this.uId,
    required this.userName,
    required this.content,
    required this.productImage,
    required this.amount,
    required this.price,
    required this.phone,
    required this.timestamp,
    required this.productId,
    this.likedBy,
  });

  // Factory method to create a Product instance from a map
  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      profileImageUrl: data['profileImageUrl'] ?? '',
      uId: data['uId'] ?? '',
      userName: data['userName'] ?? '',
      content: data['content'] ?? '',
      productImage: data['productImage'] ?? '',
      amount: data['amount'] ?? '',
      price: data['price'] ?? '',
      phone: data['phone'] ?? '',
      timestamp: DateTime.parse(data['timestamp']),
      productId: data['productId'] ?? '',
      likedBy:
          data['likedBy'] != null ? List<String>.from(data['likedBy']) : null,
    );
  }

  // Method to convert a Product instance to a map
  Map<String, dynamic> toJson() {
    return {
      'profileImageUrl': profileImageUrl,
      'uId': uId,
      'userName': userName,
      'content': content,
      'productImage': productImage,
      'amount': amount,
      'price': price,
      'phone': phone,
      'timestamp': timestamp.toIso8601String(),
      'productId': productId,
      'likedBy': likedBy,
    };
  }
}
