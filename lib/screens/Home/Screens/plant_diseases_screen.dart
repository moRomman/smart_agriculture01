import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:smart_agriculture/Shared/consts.dart';

class PlantDiseaseApp extends StatefulWidget {
  const PlantDiseaseApp({super.key});

  @override
  PlantDiseaseAppState createState() => PlantDiseaseAppState();
}

class PlantDiseaseAppState extends State<PlantDiseaseApp> {
  File? _image;
  String _resultMessage = '';
  Map<String, dynamic>? _resultDetails;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      _uploadImage(_image!);
    }
  }

  Future<void> _uploadImage(File image) async {
    final uri =
        Uri.parse('https://web-production-7125.up.railway.app/'); //fast api

    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final result = json.decode(responseBody) as Map<String, dynamic>;

      setState(() {
        _resultMessage = 'Plant Condition: ${result["Plant Condition"]}';
        // 'Confidence Percentage: ${result["Confidence Percentage"]}%';
        _resultDetails = result;
      });
    } else {
      setState(() {
        _resultMessage = 'Error: ${response.reasonPhrase}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        backgroundColor: MyColors.mainColor,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        'Plant diseases',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          foreground: Paint()
            ..shader = const LinearGradient(
              colors: [Colors.black, Colors.black, Colors.lightGreenAccent],
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
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text('No image selected.')
                  : Card(elevation: 8, child: Image.file(_image!)),
              const SizedBox(height: 20),
              FloatingActionButton.extended(
                onPressed: _pickImage,
                label: const Text(
                  'Pick Image',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                backgroundColor: MyColors.mainColor,
              ),
              const SizedBox(height: 20),
              if (_resultDetails != null) _buildResultCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return ListTile(
      title: Text(
        _resultMessage,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        _resultDetails?["Plant Condition"] == 'Rust'
            ? 'Rust is a fungal disease causing reddish or orange-brown pustules on leaves and stems. It disrupts photosynthesis and nutrient flow, reducing plant vigor and yield.\nSolution: Remove and destroy infected plant parts, avoid overhead watering, and apply fungicides. Ensure proper spacing for airflow.\nReference: University of Minnesota Extension, American Phytopathological Society.\nConfidence Percentage: 70-90%\nالصدأ هو مرض فطري يسبب بثرات حمراء أو بنية على الأوراق والسيقان. يعطل التمثيل الضوئي وتدفق العناصر الغذائية، مما يقلل من حيوية النبات والمحصول.\nالحل: إزالة الأجزاء المصابة وتدميرها، تجنب الري العلوي، وتطبيق مبيدات الفطريات. تأكد من التباعد الصحيح لمرور الهواء.'
            : _resultDetails?["Plant Condition"] == 'Powdery'
                ? 'Powdery mildew is a fungal disease identified by white or grayish powdery spots on leaves, stems, and flowers. It reduces photosynthesis, causing stunted growth and distorted leaves.\nSolution: Increase air circulation, reduce humidity, remove infected parts, and apply fungicides. Water plants at the base.\nReference: University of California Agriculture and Natural Resources, American Phytopathological Society.\nConfidence Percentage: 60-85%\nالبياض الدقيقي هو مرض فطري يظهر كبقع بيضاء أو رمادية على الأوراق والسيقان والأزهار. يقلل التمثيل الضوئي، مما يسبب نموًا متقزمًا وأوراق مشوهة.\nالحل: زيادة تهوية الهواء، تقليل الرطوبة، إزالة الأجزاء المصابة، وتطبيق مبيدات الفطريات. ري النباتات عند القاعدة.'
                : 'Confidence Percentage: 100%',
        style: const TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// class PlantDiseaseApp extends StatefulWidget {
//   @override
//   _PlantDiseaseAppState createState() => _PlantDiseaseAppState();
// }
//
// class _PlantDiseaseAppState extends State<PlantDiseaseApp> {
//   File? _image;
//   final picker = ImagePicker();
//   String? _result;
//
//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   Future<void> _uploadImage() async {
//     if (_image == null) return;
//
//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse('https://web-production-8adc.up.railway.app/'),
//     );
//     request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
//
//     final response = await request.send();
//
//     if (response.statusCode == 200) {
//       final responseData = await http.Response.fromStream(response);
//       final Map<String, dynamic> responseJson = json.decode(responseData.body);
//       setState(() {
//         _result = 'Plant Condition: ${responseJson['Plant Condition']}\n'
//             'Confidence Percentage: ${responseJson['Confidence Percentage']}%';
//       });
//     } else {
//       setState(() {
//         _result = 'Error: ${response.reasonPhrase}';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plant Disease Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image == null ? Text('No image selected.') : Image.file(_image!),
//             SizedBox(height: 20),
//             _result == null
//                 ? Container()
//                 : Text(
//                     _result!,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             ElevatedButton(
//               onPressed: _uploadImage,
//               child: Text('Upload Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/*
Rust
English:
Rust is a fungal disease that affects a wide range of plants, characterized by reddish or orange-brown pustules on the leaves and stems. These pustules contain spores that can spread the infection to other plants. Rust can significantly reduce plant vigor and yield by disrupting photosynthesis and nutrient flow.

Arabic:
الصدأ هو مرض فطري يؤثر على مجموعة واسعة من النباتات، ويتميز بظهور بثرات حمراء أو بنية برتقالية على الأوراق والسيقان. تحتوي هذه البثرات على أبواغ يمكن أن تنشر العدوى إلى نباتات أخرى. يمكن للصدأ أن يقلل بشكل كبير من حيوية النبات والمحصول عن طريق تعطيل عملية التمثيل الضوئي وتدفق العناصر الغذائية.

Powdery Mildew
English:
Powdery mildew is a common fungal disease that affects many types of plants, recognized by white or grayish powdery spots on leaves, stems, and flowers. This disease can lead to reduced photosynthesis, stunted growth, and distorted leaves, ultimately decreasing the plant's productivity and aesthetic value.

Arabic:
البياض الدقيقي هو مرض فطري شائع يؤثر على العديد من أنواع النباتات، ويتم التعرف عليه من خلال البقع البيضاء أو الرمادية المسحوقية على الأوراق والسيقان والأزهار. يمكن لهذا المرض أن يؤدي إلى تقليل عملية التمثيل الضوئي، ونمو متقزم، وأوراق مشوهة، مما يقلل في النهاية من إنتاجية النبات وقيمته الجمالية.

 */
