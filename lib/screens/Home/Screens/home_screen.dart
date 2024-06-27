// import 'package:flutter/material.dart';
// import 'package:smart_agriculture/Shared/consts.dart';
// import 'package:smart_agriculture/screens/Home/Screens/plant_diseases_screen.dart';
// import 'package:smart_agriculture/screens/Home/Screens/soil_analyze_screen.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Center(
//           child: ListTile(
//             title: Text(
//               'GreenGrow',
//               textAlign: TextAlign.center,
//               textScaler: const TextScaler.linear(2),
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 // Apply gradient color
//                 foreground: Paint()
//                   ..shader = const LinearGradient(
//                     colors: [
//                       Colors.black,
//                       Colors.black,
//                       Colors.lightGreenAccent
//
//                       // Colors.blueAccent
//                     ],
//                     // Adjust colors as needed
//                     // begin: Alignment.topLeft,
//                     // end: Alignment.bottomRight,
//                   ).createShader(const Rect.fromLTWH(
//                       70.0, 70.0, 200.0, 70.0)), // Adjust Rect size as needed
//               ),
//             ),
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               MyColors.mainColor,
//               Colors.blueAccent,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Image.asset('images/plant.png'),
//
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const PredictCropPage(),
//                     // builder: (context) => PlantDiseaseApp(),
//                   ),
//                 ),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                   width: double.infinity,
//                   height: 300,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.lightGreen.withOpacity(0.1),
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15),
//                             ),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'Analyze the soil elements',
//                               textAlign: TextAlign.center,
//                               textScaler: TextScaler.linear(1.5),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             image: const DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(
//                                 'images/plant_ai.png',
//                               ),
//                             ),
//                             color: Colors.lightGreen.withOpacity(0.4),
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(15),
//                               bottomRight: Radius.circular(15),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     // builder: (context) => const PredictCropPage(),
//                     builder: (context) => const PlantDiseaseApp(),
//                   ),
//                 ),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                   width: double.infinity,
//                   height: 300,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.lightGreen.withOpacity(0.1),
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15),
//                             ),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'Plant disease analysis',
//                               textAlign: TextAlign.center,
//                               textScaler: TextScaler.linear(1.5),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             image: const DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(
//                                 'images/plant_ai.png',
//                               ),
//                             ),
//                             color: Colors.lightGreen.withOpacity(0.4),
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(15),
//                               bottomRight: Radius.circular(15),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:smart_agriculture/Shared/consts.dart';
import 'package:smart_agriculture/screens/Home/Screens/plant_diseases_screen.dart';
import 'package:smart_agriculture/screens/Home/Screens/soil_analyze_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _buildTitle(),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        'Smart Agriculture',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          foreground: Paint()
            ..shader = const LinearGradient(
              colors: [
                Colors.black,
                Colors.black,
                Colors.lightGreenAccent,
              ],
            ).createShader(const Rect.fromLTWH(70.0, 70.0, 200.0, 70.0)),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildFeatureCard(
            title: 'Analyze the soil elements',
            image: 'images/plant_ai.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PredictCropPage(),
              ),
            ),
          ),
          _buildFeatureCard(
            title: 'Plant disease analysis',
            image: 'images/plant_ai.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlantDiseaseApp(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String image,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              _buildFeatureCardTitle(title),
              _buildFeatureCardImage(image),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCardTitle(String title) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCardImage(String image) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
          color: Colors.lightGreen.withOpacity(0.4),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
