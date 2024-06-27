// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:smart_agriculture/Shared/consts.dart';
//
// import '../Repository/crop_model.dart';
//
// class PredictCropPage extends StatefulWidget {
//   const PredictCropPage({super.key});
//
//   @override
//   PredictCropPageState createState() => PredictCropPageState();
// }
//
// class PredictCropPageState extends State<PredictCropPage> {
//   final TextEditingController nController = TextEditingController();
//   final TextEditingController pController = TextEditingController();
//   final TextEditingController kController = TextEditingController();
//   final TextEditingController temperatureController = TextEditingController();
//   final TextEditingController humidityController = TextEditingController();
//   final TextEditingController phController = TextEditingController();
//   final TextEditingController rainfallController = TextEditingController();
//
//   String prediction = '';
//   Crop crop = Crop(descriptionEn: '', descriptionAr: '', image: '');
//   String _errorText = '';
//   // final String _apiUrl = 'https://web-production-d54c8.up.railway.app';//flask
//   final String _apiUrl = 'https://web-production-86da.up.railway.app/';//fast api
//
//   @override
//   void initState() {
//     super.initState();
//     trainModel();
//   }
//
//   Future<void> trainModel() async {
//     var url = Uri.parse('$_apiUrl/train');
//     var response = await http.post(url);
//     if (response.statusCode == 200) {
//       debugPrint('Model trained successfully');
//     } else {
//       debugPrint('Failed to train model');
//     }
//   }
//
//   Future<void> predictCrop() async {
//     var url = Uri.parse('$_apiUrl/predict');
//     var data = {
//       'data': [
//         nController.text,
//         pController.text,
//         kController.text,
//         temperatureController.text,
//         humidityController.text,
//         phController.text,
//         rainfallController.text
//       ]
//     };
//     var response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(data),
//     );
//     if (response.statusCode == 200) {
//       setState(() {
//         prediction = jsonDecode(response.body)['predicted_crop'];
//         crop = getCropInfo(prediction);
//       });
//     } else {
//       debugPrint('Failed to get prediction: ${response.body}');
//     }
//   }
//
//   bool validateInputs() {
//     if (nController.text.isEmpty ||
//         pController.text.isEmpty ||
//         kController.text.isEmpty ||
//         temperatureController.text.isEmpty ||
//         humidityController.text.isEmpty ||
//         phController.text.isEmpty ||
//         rainfallController.text.isEmpty) {
//       setState(() {
//         _errorText = 'Empty Field/Fields!';
//       });
//       return false;
//     } else if (double.tryParse(nController.text) == null ||
//         double.tryParse(pController.text) == null ||
//         double.tryParse(kController.text) == null ||
//         double.tryParse(temperatureController.text) == null ||
//         double.tryParse(humidityController.text) == null ||
//         double.tryParse(phController.text) == null ||
//         double.tryParse(rainfallController.text) == null) {
//       setState(() {
//         _errorText = 'Invalid Number!';
//       });
//       return false;
//     } else {
//       setState(() {
//         _errorText = '';
//       });
//       return true;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var textFieldWidth = MediaQuery.of(context).size.width / 5;
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             'Crop Prediction',
//             textAlign: TextAlign.center,
//             textScaler: const TextScaler.linear(1.5),
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               // Apply gradient color
//               foreground: Paint()
//                 ..shader = const LinearGradient(
//                   colors: [
//                     Colors.black,
//                     Colors.black,
//                     Colors.lightGreenAccent
//                     // Colors.blueAccent
//                     // Colors.blueAccent
//                   ],
//                   // Adjust colors as needed
//                   // begin: Alignment.topLeft,
//                   // end: Alignment.bottomRight,
//                 ).createShader(const Rect.fromLTWH(
//                     70.0, 70.0, 200.0, 70.0)), // Adjust Rect size as needed
//             ),
//           ),
//         ),
//         backgroundColor: MyColors.mainColor,
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 MyColors.mainColor,
//                 Colors.blueAccent,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.lightGreen.withOpacity(0.4),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Predicted Crop: $prediction',
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 crop.descriptionEn.toString(),
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 crop.descriptionAr.toString(),
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                               const SizedBox(height: 10),
//                               Image(
//                                 image: NetworkImage(
//                                   crop.image,
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     const Icon(Icons.error),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Center(
//                       child: SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             textFieldWidget(
//                                 width: textFieldWidth,
//                                 hint: 'N',
//                                 label: 'Nitrogen',
//                                 controller: nController),
//                             textFieldWidget(
//                                 width: textFieldWidth,
//                                 hint: 'P',
//                                 label: 'Phosphorous',
//                                 controller: pController),
//                             textFieldWidget(
//                                 width: textFieldWidth,
//                                 hint: 'K',
//                                 label: 'Potassium',
//                                 controller: kController),
//                             textFieldWidget(
//                                 width: textFieldWidth,
//                                 hint: 'Temp..',
//                                 label: 'Temperature',
//                                 controller: temperatureController),
//                             textFieldWidget(
//                                 width: textFieldWidth,
//                                 hint: 'Humidity',
//                                 label: 'Humidity in %',
//                                 controller: humidityController),
//                             textFieldWidget(
//                                 width: textFieldWidth,
//                                 hint: 'pH',
//                                 label: 'PH in the soil',
//                                 controller: phController),
//                             textFieldWidget(
//                                 width: textFieldWidth,
//                                 hint: 'Rainfall',
//                                 label: 'Rainfall in mm',
//                                 controller: rainfallController),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Text(
//                           _errorText,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ),
//                     FloatingActionButton.extended(
//                       onPressed: () {
//                         if (validateInputs()) predictCrop();
//                       },
//
//                       label: const Text(
//                         'Predict Crop',
//                         textScaler: TextScaler.linear(1.2),
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.normal),
//                       ),
//                       backgroundColor: MyColors.mainColor,
//                       // style: ElevatedButton.styleFrom(
//                       //   backgroundColor: MyColors.mainColor,
//                       // ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget textFieldWidget({
//     required double width,
//     required String hint,
//     required TextEditingController controller,
//     required String? label, // Add a label parameter
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (label != null) // Display the label if provided
//             Text(
//               label,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontStyle: FontStyle.italic,
//                 fontSize: 16,
//               ),
//             ),
//           SizedBox(
//             width: width,
//             child: TextField(
//               onChanged: (value) {
//                 validateInputs();
//               },
//               controller: controller,
//               keyboardType: TextInputType.number,
//               cursorColor: Colors.white,
//               decoration: InputDecoration(
//                 hintText: '$hint:',
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 filled: true,
//                 fillColor: Colors.transparent,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_agriculture/Shared/consts.dart';

import '../Repository/crop_model.dart';

class PredictCropPage extends StatefulWidget {
  const PredictCropPage({super.key});

  @override
  PredictCropPageState createState() => PredictCropPageState();
}

class PredictCropPageState extends State<PredictCropPage> {
  final TextEditingController nController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController rainfallController = TextEditingController();

  String prediction = '';
  Crop crop = Crop(descriptionEn: '', descriptionAr: '', image: '');
  String _errorText = '';

  // final String _apiUrl = 'https://web-production-86da.up.railway.app/'; // fast api
  final String _apiUrl = 'https://web-production-d54c8.up.railway.app'; //flask

  @override
  void initState() {
    super.initState();
    trainModel();
  }

  Future<void> trainModel() async {
    var url = Uri.parse('$_apiUrl/train');
    var response = await http.post(url);
    if (response.statusCode == 200) {
      debugPrint('Model trained successfully');
    } else {
      debugPrint('Failed to train model');
    }
  }

  Future<void> predictCrop() async {
    var url = Uri.parse('$_apiUrl/predict');
    var data = {
      'data': [
        nController.text,
        pController.text,
        kController.text,
        temperatureController.text,
        humidityController.text,
        phController.text,
        rainfallController.text
      ]
    };
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      setState(() {
        prediction = jsonDecode(response.body)['predicted_crop'];
        crop = getCropInfo(prediction);
      });
    } else {
      debugPrint('Failed to get prediction: ${response.body}');
    }
  }

  bool validateInputs() {
    if (nController.text.isEmpty ||
        pController.text.isEmpty ||
        kController.text.isEmpty ||
        temperatureController.text.isEmpty ||
        humidityController.text.isEmpty ||
        phController.text.isEmpty ||
        rainfallController.text.isEmpty) {
      setState(() {
        _errorText = 'Empty Field/Fields!';
      });
      return false;
    } else if (double.tryParse(nController.text) == null ||
        double.tryParse(pController.text) == null ||
        double.tryParse(kController.text) == null ||
        double.tryParse(temperatureController.text) == null ||
        double.tryParse(humidityController.text) == null ||
        double.tryParse(phController.text) == null ||
        double.tryParse(rainfallController.text) == null) {
      setState(() {
        _errorText = 'Invalid Number!';
      });
      return false;
    } else {
      setState(() {
        _errorText = '';
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textFieldWidth = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        backgroundColor: MyColors.mainColor,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _buildBody(textFieldWidth),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        'Crop Prediction',
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

  Widget _buildBody(double textFieldWidth) {
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildPredictionResult(),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 0.5,
                ),
                _buildInputFields(textFieldWidth),
                const Divider(
                  thickness: 0.5,
                ),
                _buildErrorText(),
                _buildPredictButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionResult() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Predicted Crop: $prediction',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                crop.descriptionEn.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                crop.descriptionAr.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Image(
                image: NetworkImage(crop.image),
                fit: BoxFit.scaleDown,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              )
            ],
          ),
        ),
      ),
    );
  }

/*Here are the acceptable ranges for each parameter:
1. *Nitrogen Content (N) Ratio*: 0 - 100
2. *Phosphorous Content (P) Ratio*: 0 - 100
3. *Potassium Content (K) Ratio*: 0 - 100
4. *Temperature (°C)*: -50 to 50
5. *Humidity (%)*: 0 - 100
6. *pH Value*: 0 - 14
7. *Rainfall (mm)*: 0 - 500*/
  Widget _buildInputFields(double textFieldWidth) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTextField(
                width: textFieldWidth,
                hint: 'Ratio: 0 - 100',
                label: 'Nitrogen',
                controller: nController),
            _buildTextField(
                width: textFieldWidth,
                hint: 'Ratio: 0 - 100',
                label: 'Phosphorous',
                controller: pController),
            _buildTextField(
                width: textFieldWidth,
                hint: 'Ratio: 0 - 100',
                label: 'Potassium',
                controller: kController),
            _buildTextField(
                width: textFieldWidth,
                hint: '(°C): -50 to 50',
                label: 'Temperature',
                controller: temperatureController),
            _buildTextField(
                width: textFieldWidth,
                hint: '(%): 0 - 100',
                label: 'Humidity in %',
                controller: humidityController),
            _buildTextField(
                width: textFieldWidth,
                hint: 'pH: 0 - 14',
                label: 'PH in the soil',
                controller: phController),
            _buildTextField(
                width: textFieldWidth,
                hint: '(mm): 0 - 500',
                label: 'Rainfall in mm',
                controller: rainfallController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required double width,
    required String hint,
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: width,
            child: TextField(
              onChanged: (value) {
                validateInputs();
              },
              controller: controller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: '$hint:',
                hintStyle: const TextStyle(
                  fontSize: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          _errorText,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildPredictButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (validateInputs()) predictCrop();
      },
      label: const Text(
        'Predict Crop',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
      backgroundColor: MyColors.mainColor,
    );
  }
}
