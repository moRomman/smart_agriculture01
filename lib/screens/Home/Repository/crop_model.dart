// import 'package:flutter/material.dart';
//
// class Crop {
//   final String descriptionEn;
//   final String descriptionAr;
//   final String image;
//
//   Crop(
//       {required this.descriptionEn,
//       required this.descriptionAr,
//       required this.image});
// }
//
// Crop getCropInfo(String cropName) {
//   switch (cropName.toLowerCase()) {
//     case "apple":
//       return Crop(
//         descriptionEn:
//             "Apples are one of the most popular and widely grown fruit trees. They are high in fiber and vitamin C.",
//         descriptionAr:
//             "التفاح هو أحد أكثر أشجار الفاكهة شهرة وانتشارًا. يحتوي على نسبة عالية من الألياف وفيتامين C.",
//         image: 'https://images3.alphacoders.com/109/thumb-1920-1093441.jpg',
//       );
//     case "banana":
//       return Crop(
//         descriptionEn:
//             "Bananas are tropical fruits that are rich in potassium and are known for their elongated shape and sweet taste.",
//         descriptionAr:
//             "الموز هو فاكهة استوائية غنية بالبوتاسيوم ومعروفة بشكلها الممدود وطعمها الحلو.",
//         image: 'https://images5.alphacoders.com/370/thumb-1920-370868.jpg',
//       );
//     case "blackgram":
//       return Crop(
//         descriptionEn:
//             "Blackgram, also known as urad bean, is a type of legume widely used in Indian cuisine for its high protein content.",
//         descriptionAr:
//             "الماش الأسود، المعروف أيضًا باسم الفول الأوراد، هو نوع من البقوليات يستخدم على نطاق واسع في المطبخ الهندي بسبب محتواه العالي من البروتين.",
//         image:
//             'https://www.stylecraze.com/wp-content/uploads/2022/02/7-Benefits-Of-Including-Black-Gram-In-Your-Diet-Banner.jpg',
//       );
//     case "chickpea":
//       return Crop(
//         descriptionEn:
//             "Chickpeas, or garbanzo beans, are legumes that are rich in protein and are a staple in many diets around the world.",
//         descriptionAr:
//             "الحمص، أو الفول الجاربانزو، هو بقوليات غنية بالبروتين وهي جزء أساسي من العديد من الأنظمة الغذائية حول العالم.",
//         image:
//             'https://png.pngtree.com/thumb_back/fh260/background/20220311/pngtree-ingredients-coarse-cereals-chickpea-hd-photography-material-image_1032272.jpg',
//       );
//     case "coconut":
//       return Crop(
//         descriptionEn:
//             "Coconuts are versatile fruits used for their water, milk, oil, and meat. They grow on coconut palm trees.",
//         descriptionAr:
//             "جوز الهند هو فاكهة متعددة الاستخدامات تُستخدم لمائها وحليبها وزيتها ولحمها. تنمو على أشجار نخيل جوز الهند.",
//         image: 'https://images6.alphacoders.com/958/958253.jpg',
//       );
//     case "coffee":
//       return Crop(
//         descriptionEn:
//             "Coffee beans are seeds of the Coffea plant, and they are roasted and brewed to make one of the world's most popular beverages.",
//         descriptionAr:
//             "حبوب القهوة هي بذور نبات القهوة، ويتم تحميصها وتخميرها لصنع أحد أشهر المشروبات في العالم.",
//         image:
//             'https://cdn11.bigcommerce.com/s-jmzfi5zcr2/images/stencil/1280x1280/products/986/4315/Coffee_arabica_Coffee_Beans__33693.1585416522.jpg?c=2',
//       );
//     case "cotton":
//       return Crop(
//         descriptionEn:
//             "Cotton is a soft, fluffy staple fiber that grows in a boll around the seeds of cotton plants. It is used to make textiles.",
//         descriptionAr:
//             "القطن هو ألياف ناعمة ورقيقة تنمو في كرات حول بذور نباتات القطن. يستخدم لصنع الأقمشة.",
//         image:
//             'https://cdn.pixabay.com/photo/2019/11/26/12/54/cotton-4654533_1280.jpg',
//       );
//     case "grapes":
//       return Crop(
//         descriptionEn:
//             "Grapes are small, round fruits that grow in clusters and can be eaten fresh or used to make wine, juice, and raisins.",
//         descriptionAr:
//             "العنب هو فاكهة صغيرة ومستديرة تنمو في عناقيد ويمكن تناولها طازجة أو استخدامها لصنع النبيذ والعصير والزبيب.",
//         image:
//             'https://images.pexels.com/photos/60021/grapes-wine-fruit-vines-60021.jpeg?cs=srgb&dl=pexels-pixabay-60021.jpg&fm=jpg',
//       );
//     case "jute":
//       return Crop(
//         descriptionEn:
//             "Jute is a long, soft, shiny vegetable fiber that can be spun into coarse, strong threads. It is mainly used for making ropes and sacks.",
//         descriptionAr:
//             "الجوت هو ألياف نباتية طويلة وناعمة ولامعة يمكن غزلها إلى خيوط خشنة وقوية. يستخدم بشكل رئيسي لصنع الحبال والأكياس.",
//         image: 'https://media.farmer2factory.com/2020/03/jute-1024x458.png',
//       );
//     case "kidneybeans":
//       return Crop(
//         descriptionEn:
//             "Kidney beans are a variety of the common bean (Phaseolus vulgaris), known for their distinctive kidney shape and deep red color.",
//         descriptionAr:
//             "الفاصوليا الحمراء هي نوع من الفاصوليا الشائعة (Phaseolus vulgaris)، وتُعرف بشكلها المميز الذي يشبه الكلى ولونها الأحمر الداكن.",
//         image:
//             'https://www.healthifyme.com/blog/wp-content/uploads/2022/01/807716893sst1641271427-scaled.jpg',
//       );
//     case "lentil":
//       return Crop(
//         descriptionEn:
//             "Lentils are small, lens-shaped legumes that come in various colors, including green, brown, red, and black, and are rich in protein and fiber.",
//         descriptionAr:
//             "العدس هو بقوليات صغيرة ذات شكل عدسي تأتي بألوان مختلفة بما في ذلك الأخضر والبني والأحمر والأسود، وهي غنية بالبروتين والألياف.",
//         image:
//             'https://tildaricelive.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/06/26122313/shutterstock_327715019.jpg',
//       );
//     case "maize":
//       return Crop(
//         descriptionEn:
//             "Maize, or corn, is a cereal grain first domesticated by indigenous peoples in southern Mexico and is a staple food in many parts of the world.",
//         descriptionAr:
//             "الذرة هي حبوب غذائية تم تدجينها لأول مرة من قبل الشعوب الأصلية في جنوب المكسيك وهي غذاء أساسي في العديد من أجزاء العالم.",
//         image:
//             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSFCDuMATNza2gKYxQQil2GIQUEbzuOp_DqA&s',
//       );
//     case "mango":
//       return Crop(
//         descriptionEn:
//             "Mangoes are tropical stone fruits known for their sweet and tangy flavor. They are rich in vitamins A and C.",
//         descriptionAr:
//             "المانجو هي فاكهة استوائية معروفة بنكهتها الحلوة والحامضة. إنها غنية بالفيتامينات A و C.",
//         image:
//             'https://static.vecteezy.com/system/resources/previews/023/732/189/non_2x/mango-fruit-hanging-on-a-tree-with-a-rustic-wooden-table-free-photo.jpg',
//       );
//     case "mothbeans":
//       return Crop(
//         descriptionEn:
//             "Moth beans are small, drought-resistant legumes that are commonly used in Indian cuisine for their high protein content.",
//         descriptionAr:
//             "الفاصوليا الموثية هي بقوليات صغيرة مقاومة للجفاف وتستخدم بشكل شائع في المطبخ الهندي لمحتواها العالي من البروتين.",
//         image:
//             'https://t3.ftcdn.net/jpg/05/59/00/94/360_F_559009453_ucHyN8TPZ41znokJrP9P0LxMB4nFoTVL.jpg',
//       );
//     case "mungbean":
//       return Crop(
//         descriptionEn:
//             "Mung beans are small green legumes that are widely used in Asian cuisine and are known for their high nutrient content.",
//         descriptionAr:
//             "الفاصوليا المونجية هي بقوليات خضراء صغيرة تُستخدم على نطاق واسع في المطبخ الآسيوي ومعروفة بمحتواها العالي من العناصر الغذائية.",
//         image:
//             'https://cdn-prod.medicalnewstoday.com/content/images/articles/324/324156/mung-beans.jpg',
//       );
//     case "muskmelon":
//       return Crop(
//         descriptionEn:
//             "Muskmelons are sweet, fragrant fruits with a netted rind and orange flesh, commonly known as cantaloupes.",
//         descriptionAr:
//             "الشمام هو فاكهة حلوة وعطرة بقشرة مشبكة ولحم برتقالي، ويعرف عمومًا باسم الكنتالوب.",
//         image:
//             'https://c1.wallpaperflare.com/preview/210/814/490/muskmelons-cantaloupes-fruit-melon.jpg',
//       );
//     case "orange":
//       return Crop(
//         descriptionEn:
//             "Oranges are citrus fruits known for their juicy and sweet-tart flavor. They are rich in vitamin C.",
//         descriptionAr:
//             "البرتقال هو فاكهة حمضية معروفة بنكهتها العصيرية والحلوة والحامضة. إنها غنية بفيتامين C.",
//         image:
//             'https://w0.peakpx.com/wallpaper/497/591/HD-wallpaper-oranges-citrus-fruits-background-with-oranges-oranges-texture-orange-background-fruits.jpg',
//       );
//     case "papaya":
//       return Crop(
//         descriptionEn:
//             "Papayas are tropical fruits with sweet orange flesh and numerous black seeds. They are rich in vitamins A and C.",
//         descriptionAr:
//             "البابايا هي فاكهة استوائية ذات لحم برتقالي حلو وبذور سوداء كثيرة. إنها غنية بالفيتامينات A و C.",
//         image:
//             'https://watermark.lovepik.com/photo/20211120/large/lovepik-fruit-papaya-picture_500425725.jpg',
//       );
//     case "pigeonpeas":
//       return Crop(
//         descriptionEn:
//             "Pigeon peas are a type of legume that is an important food crop in tropical regions, rich in protein and fiber.",
//         descriptionAr:
//             "الحمص الهندي هو نوع من البقوليات وهو محصول غذائي مهم في المناطق الاستوائية، غني بالبروتين والألياف.",
//         image:
//             'https://gardenerspath.com/wp-content/uploads/2022/02/How-to-Grow-Pigeon-Peas-Feature.jpg',
//       );
//     case "pomegranate":
//       return Crop(
//         descriptionEn:
//             "Pomegranates are fruits with a tough outer rind and jewel-like seeds inside, known for their tangy flavor and health benefits.",
//         descriptionAr:
//             "الرمان هو فاكهة ذات قشرة خارجية صلبة وبذور تشبه الجواهر في الداخل، معروفة بنكهتها الحامضة وفوائدها الصحية.",
//         image:
//             'https://www.wallpaperflare.com/static/384/146/538/pomegranate-5k-fruit-wallpaper.jpg',
//       );
//     case "rice":
//       return Crop(
//         descriptionEn:
//             "Rice is a staple food for a large part of the world's population, particularly in Asia. It is a cereal grain that comes in many varieties.",
//         descriptionAr:
//             "الأرز هو غذاء أساسي لجزء كبير من سكان العالم، خاصة في آسيا. إنه حبوب غذائية تأتي في العديد من الأصناف.",
//         image:
//             'https://png.pngtree.com/background/20230424/original/pngtree-two-baskets-filled-with-rice-on-the-grass-picture-image_2457613.jpg',
//       );
//     case "watermelon":
//       return Crop(
//         descriptionEn:
//             "Watermelons are large fruits with a hard green rind and sweet, juicy red flesh. They are mostly water, making them very refreshing.",
//         descriptionAr:
//             "البطيخ هو فاكهة كبيرة ذات قشرة خضراء صلبة ولحم أحمر حلو وعصير. إنها تحتوي على نسبة عالية من الماء مما يجعلها منعشة للغاية.",
//         image:
//             'https://images.wallpapersden.com/image/download/striped-watermelon-bag_aW1raG6UmZqaraWkpJRmbmdlrWZlbWU.jpg',
//       );
//     default:
//       return Crop(
//         descriptionEn: '',
//         descriptionAr: '',
//         image: '',
//       );
//   }
// }
//
// void main() {
//   String cropName = "apple";
//   Crop crop = getCropInfo(cropName);
//
//   debugPrint("Description (EN): ${crop.descriptionEn}");
//   debugPrint("Description (AR): ${crop.descriptionAr}");
//   debugPrint("Image URL: ${crop.image}");
// }

import 'package:flutter/material.dart';

class Crop {
  final String descriptionEn;
  final String descriptionAr;
  final String image;

  Crop({
    required this.descriptionEn,
    required this.descriptionAr,
    required this.image,
  });
}

Crop getCropInfo(String cropName) {
  final Map<String, Crop> crops = {
    "apple": Crop(
      descriptionEn: "Apples are one of the most popular and widely grown fruit trees. They are high in fiber and vitamin C.",
      descriptionAr: "التفاح هو أحد أكثر أشجار الفاكهة شهرة وانتشارًا. يحتوي على نسبة عالية من الألياف وفيتامين C.",
      image: 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce',
    ),
    "banana": Crop(
      descriptionEn: "Bananas are tropical fruits that are rich in potassium and are known for their elongated shape and sweet taste.",
      descriptionAr: "الموز هو فاكهة استوائية غنية بالبوتاسيوم ومعروفة بشكلها الممدود وطعمها الحلو.",
      image: 'https://images.unsplash.com/photo-1574226516831-e1dff420e43f',
    ),
    "blackgram": Crop(
      descriptionEn: "Blackgram, also known as urad bean, is a type of legume widely used in Indian cuisine for its high protein content.",
      descriptionAr: "الماش الأسود، المعروف أيضًا باسم الفول الأوراد، هو نوع من البقوليات يستخدم على نطاق واسع في المطبخ الهندي بسبب محتواه العالي من البروتين.",
      image: 'https://images.unsplash.com/photo-1612204474655-fec9bfefb1d8',
    ),
    "chickpea": Crop(
      descriptionEn: "Chickpeas, or garbanzo beans, are legumes that are rich in protein and are a staple in many diets around the world.",
      descriptionAr: "الحمص، أو الفول الجاربانزو، هو بقوليات غنية بالبروتين وهي جزء أساسي من العديد من الأنظمة الغذائية حول العالم.",
      image: 'https://images.unsplash.com/photo-1589923188900-22d5345f76f6',
    ),
    "coconut": Crop(
      descriptionEn: "Coconuts are versatile fruits used for their water, milk, oil, and meat. They grow on coconut palm trees.",
      descriptionAr: "جوز الهند هو فاكهة متعددة الاستخدامات تُستخدم لمائها وحليبها وزيتها ولحمها. تنمو على أشجار نخيل جوز الهند.",
      image: 'https://images.unsplash.com/photo-1562158071-631d2bfa8a85',
    ),
    "coffee": Crop(
      descriptionEn: "Coffee beans are seeds of the Coffea plant, and they are roasted and brewed to make one of the world's most popular beverages.",
      descriptionAr: "حبوب القهوة هي بذور نبات القهوة، ويتم تحميصها وتخميرها لصنع أحد أشهر المشروبات في العالم.",
      image: 'https://images.unsplash.com/photo-1512580775346-e6baf7f21652',
    ),
    "cotton": Crop(
      descriptionEn: "Cotton is a soft, fluffy staple fiber that grows in a boll around the seeds of cotton plants. It is used to make textiles.",
      descriptionAr: "القطن هو ألياف ناعمة ورقيقة تنمو في كرات حول بذور نباتات القطن. يستخدم لصنع الأقمشة.",
      image: 'https://images.unsplash.com/photo-1608155392309-55d2c32a453b',
    ),
    "grapes": Crop(
      descriptionEn: "Grapes are small, round fruits that grow in clusters and can be eaten fresh or used to make wine, juice, and raisins.",
      descriptionAr: "العنب هو فاكهة صغيرة ومستديرة تنمو في عناقيد ويمكن تناولها طازجة أو استخدامها لصنع النبيذ والعصير والزبيب.",
      image: 'https://images.unsplash.com/photo-1576157922633-86c8eb16ce9e',
    ),
    "jute": Crop(
      descriptionEn: "Jute is a long, soft, shiny vegetable fiber that can be spun into coarse, strong threads. It is mainly used for making ropes and sacks.",
      descriptionAr: "الجوت هو ألياف نباتية طويلة وناعمة ولامعة يمكن غزلها إلى خيوط خشنة وقوية. يستخدم بشكل رئيسي لصنع الحبال والأكياس.",
      image: 'https://images.unsplash.com/photo-1611605691201-ef8a7314ee34',
    ),
    "kidneybeans": Crop(
      descriptionEn: "Kidney beans are a variety of the common bean (Phaseolus vulgaris), known for their distinctive kidney shape and deep red color.",
      descriptionAr: "الفاصوليا الحمراء هي نوع من الفاصوليا الشائعة (Phaseolus vulgaris)، وتُعرف بشكلها المميز الذي يشبه الكلى ولونها الأحمر الداكن.",
      image: 'https://images.unsplash.com/photo-1617137855730-8e029f3f88cb',
    ),
    "lentil": Crop(
      descriptionEn: "Lentils are small, lens-shaped legumes that come in various colors, including green, brown, red, and black, and are rich in protein and fiber.",
      descriptionAr: "العدس هو بقوليات صغيرة ذات شكل عدسي تأتي بألوان مختلفة بما في ذلك الأخضر والبني والأحمر والأسود، وهي غنية بالبروتين والألياف.",
      image: 'https://images.unsplash.com/photo-1581607132662-52b42f36b7a4',
    ),
    "maize": Crop(
      descriptionEn: "Maize, or corn, is a cereal grain first domesticated by indigenous peoples in southern Mexico and is a staple food in many parts of the world.",
      descriptionAr: "الذرة هي حبوب غذائية تم تدجينها لأول مرة من قبل الشعوب الأصلية في جنوب المكسيك وهي غذاء أساسي في العديد من أجزاء العالم.",
      image: 'https://images.unsplash.com/photo-1589634574514-6ba917d0f4e6',
    ),
    "mango": Crop(
      descriptionEn: "Mangoes are tropical stone fruits known for their sweet and tangy flavor. They are rich in vitamins A and C.",
      descriptionAr: "المانجو هي فاكهة استوائية معروفة بنكهتها الحلوة والحامضة. إنها غنية بالفيتامينات A و C.",
      image: 'https://images.unsplash.com/photo-1597300497581-b6d52527e8d0',
    ),
    "mothbeans": Crop(
      descriptionEn: "Moth beans are small, drought-resistant legumes that are commonly used in Indian cuisine for their high protein content.",
      descriptionAr: "الفاصوليا الموثية هي بقوليات صغيرة مقاومة للجفاف وتستخدم بشكل شائع في المطبخ الهندي لمحتواها العالي من البروتين.",
      image: 'https://images.unsplash.com/photo-1581547841744-bd991ae5bf1b',
    ),
    "mungbean": Crop(
      descriptionEn: "Mung beans are small green legumes that are widely used in Asian cuisine and are known for their high nutrient content.",
      descriptionAr: "الفاصوليا المونجية هي بقوليات خضراء صغيرة تُستخدم على نطاق واسع في المطبخ الآسيوي ومعروفة بمحتواها العالي من العناصر الغذائية.",
      image: 'https://images.unsplash.com/photo-1580745918790-fd2f74b0ab03',
    ),
    "muskmelon": Crop(
      descriptionEn: "Muskmelons are sweet, fragrant fruits with a netted rind and orange flesh, commonly known as cantaloupes.",
      descriptionAr: "الشمام هو فاكهة حلوة وعطرة بقشرة مشبكة ولحم برتقالي، ويعرف عمومًا باسم الكنتالوب.",
      image: 'https://images.unsplash.com/photo-1560844179-8eea6c4f3bd3',
    ),
    "orange": Crop(
      descriptionEn: "Oranges are citrus fruits known for their juicy and sweet-tart flavor. They are rich in vitamin C.",
      descriptionAr: "البرتقال هو فاكهة حمضية معروفة بنكهتها العصيرية والحلوة والحامضة. إنها غنية بفيتامين C.",
      image: 'https://images.unsplash.com/photo-1571049755200-8f32e02aa0bb',
    ),
    "papaya": Crop(
      descriptionEn: "Papayas are tropical fruits with sweet orange flesh and numerous black seeds. They are rich in vitamins A and C.",
      descriptionAr: "البابايا هي فاكهة استوائية ذات لحم برتقالي حلو وبذور سوداء كثيرة. إنها غنية بالفيتامينات A و C.",
      image: 'https://images.unsplash.com/photo-1596882916142-68c9d7221e6b',
    ),
    "pigeonpeas": Crop(
      descriptionEn: "Pigeon peas are a type of legume that is an important food crop in tropical regions, rich in protein and fiber.",
      descriptionAr: "الحمص الهندي هو نوع من البقوليات وهو محصول غذائي مهم في المناطق الاستوائية، غني بالبروتين والألياف.",
      image: 'https://images.unsplash.com/photo-1609920094841-d2736f9b4a10',
    ),
    "pomegranate": Crop(
      descriptionEn: "Pomegranates are fruits with a tough outer rind and jewel-like seeds inside, known for their tangy flavor and health benefits.",
      descriptionAr: "الرمان هو فاكهة ذات قشرة خارجية صلبة وبذور تشبه الجواهر في الداخل، معروفة بنكهتها الحامضة وفوائدها الصحية.",
      image: 'https://images.unsplash.com/photo-1581616014999-5c293d98478b',
    ),
    "rice": Crop(
      descriptionEn: "Rice is a staple food for a large part of the world's population, particularly in Asia. It is a cereal grain that comes in many varieties.",
      descriptionAr: "الأرز هو غذاء أساسي لجزء كبير من سكان العالم، خاصة في آسيا. إنه حبوب غذائية تأتي في العديد من الأصناف.",
      image: 'https://images.unsplash.com/photo-1560807707-8cc77767d783',
    ),
    "watermelon": Crop(
      descriptionEn: "Watermelons are large fruits with a hard green rind and sweet, juicy red flesh. They are mostly water, making them very refreshing.",
      descriptionAr: "البطيخ هو فاكهة كبيرة ذات قشرة خضراء صلبة ولحم أحمر حلو وعصير. إنها تحتوي على نسبة عالية من الماء مما يجعلها منعشة للغاية.",
      image: 'https://images.unsplash.com/photo-1592928305233-dbc65cd51c9f',
    ),
  };

  return crops[cropName.toLowerCase()] ?? Crop(descriptionEn: '', descriptionAr: '', image: '');
}

// void main() {
//   String cropName = "apple";
//   Crop crop = getCropInfo(cropName);
//
//   debugPrint("Description (EN): ${crop.descriptionEn}");
//   debugPrint("Description (AR): ${crop.descriptionAr}");
//   debugPrint("Image URL: ${crop.image}");
// }
