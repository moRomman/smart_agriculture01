import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_agriculture/Shared/consts.dart';
import 'package:smart_agriculture/screens/Login/Screens/login_screen.dart';
import 'package:smart_agriculture/screens/Market/Screens/product_widget.dart';

import '../../Community/Repository/post_model.dart';
import '../../Community/Screens/posts_widget.dart';
import '../../Market/Repository/product_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              padding: const EdgeInsets.all(16),
              onPressed: _signOut,
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: kToolbarHeight + 50, right: 16, left: 16),
                child: UserInfoSection(user: user),
              ),
              const Divider(color: Colors.white54),
              FavoriteProductsSection(user: user, screenWidth: screenWidth),
              const Divider(),
              UserPostsSection(user: user, screenWidth: screenWidth),
              const SizedBox(
                height: kToolbarHeight + 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final User? user;

  const UserInfoSection({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            user?.photoURL ?? '',
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          user?.displayName ?? 'No Name',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(
          user?.email ?? 'No Email',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

class FavoriteProductsSection extends StatelessWidget {
  final User? user;
  final double screenWidth;

  const FavoriteProductsSection(
      {super.key, this.user, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenWidth * 0.7,
      // Make the height proportional to the screen width
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          final myFavProducts = snapshot.data?.docs.where((doc) {
                if (doc.exists && doc.data().containsKey('likedBy')) {
                  return doc['likedBy'].contains(user?.uid);
                } else {
                  return false;
                }
              }).toList() ??
              [];

          return GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: myFavProducts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final doc = myFavProducts[index];
              final productId =
                  doc.id; // Assuming each document has a unique ID
              return ProductWidget(
                product: Product.fromJson(doc.data()),
                heroTag: 'product-$productId', // Unique hero tag
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio:
                  screenWidth / screenWidth, // Adjust aspect ratio
            ),
          );
        },
      ),
    );
  }
}

class UserPostsSection extends StatelessWidget {
  final User? user;
  final double screenWidth;

  const UserPostsSection({super.key, this.user, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        final myPosts = snapshot.data?.docs.where((doc) {
              if (doc.exists && doc.data().containsKey('uId')) {
                return doc['uId'] == user?.uid;
              } else {
                return false;
              }
            }).toList() ??
            [];

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myPosts.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final doc = myPosts[index];
            return PostWidget(
              post: Post.fromJson(doc.data()),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
        );
      },
    );
  }
}
