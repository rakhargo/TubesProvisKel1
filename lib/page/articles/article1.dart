import 'package:flutter/material.dart';

class Article1 extends StatefulWidget {
  const Article1({super.key});

  @override
  State<Article1> createState() => _Article1();
}

class _Article1 extends State<Article1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Article',
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Help and Support',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 9, 15, 71),
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Color(0xFF202157),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(25),
            children: [
              Text(
                'Plant-Based Protein: The Best, the Worst, and Everything in Between',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202157)),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  buildBox('Nutrition & Diet'),
                  SizedBox(width: 16), // Add spacing between the two boxes
                  buildBox('Lifestyle'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Reviewed by dr. Nadin Amizah, Sp. GK',
                    style: TextStyle(fontSize: 14, color: Color(0xFF202157)),
                  ),
                  Spacer(),
                  Text(
                    '19 June 2023',
                    style: TextStyle(fontSize: 14, color: Color(0xFF202157)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Protein is an essential nutrient that plays many important roles in our body, such as building and repairing tissues, producing enzymes and hormones, and supporting immune function. While animal products like meat, dairy, and eggs are often considered the go-to sources of protein, plant-based protein is gaining popularity among health-conscious individuals, vegetarians, and vegans.\nIn this article, we’ll explore the best and worst sources of plant-based protein and everything in between to help you make informed decisions about your diet.',
                style: TextStyle(fontSize: 16, color: Color(0xFF202157)),
              ),
              SizedBox(height: 16),
              Image.asset('assets/images/article/1.jpg'),
              SizedBox(height: 16),
              Text(
                'The Best Sources of Plant-Based Protein',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202157)),
              ),
              SizedBox(height: 16),
              buildListItem('1. Legumes',
                  'Legumes are a family of plants that include beans, lentils, chickpeas, and peas. They are rich in protein, fiber, iron, and other micronutrients. One cup of cooked beans contains around 15 grams of protein, making them an excellent source of plant-based protein.'),
              buildListItem('2. Nuts and seeds',
                  'Nuts and seeds like almonds, chia seeds, and hemp seeds are also good sources of protein and healthy fats. They can be added to smoothies, salads, or eaten as a snack.'),
              buildListItem('3. Soy-based products',
                  'Tofu and tempeh are soy-based products that are high in protein and low in fat. They can be used in a variety of dishes, such as stir-fries, salads, and sandwiches.'),
              buildListItem('4. Quinoa',
                  'Quinoa is a gluten-free grain that is also a complete protein source, meaning it contains all nine essential amino acids that our body needs to function properly. One cup of cooked quinoa contains around 8 grams of protein.'),
              SizedBox(height: 16),
              Text(
                'The Worst Sources of Plant-Based Protein',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202157)),
              ),
              SizedBox(height: 16),
              buildListItem('1. Refined grains',
                  'Refined grains like white bread, white rice, and pasta are often low in protein and fiber and high in refined carbohydrates, which can spike blood sugar levels and contribute to weight gain. Instead, opt for whole-grain varieties that are higher in protein and fiber.'),
              buildListItem('2. Processed plant-based foods',
                  'Many processed plant-based foods like vegan burgers, sausages, and deli meats are often high in sodium, unhealthy fats, and preservatives, and may not provide the same nutritional benefits as whole plant-based foods.'),
              SizedBox(height: 16),
              Text(
                'Everything in Between',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202157)),
              ),
              SizedBox(height: 16),
              Text(
                'While some plant-based protein sources are better than others, it’s important to remember that a varied and balanced diet is key to meeting our daily protein needs. Aim for a combination of whole grains, legumes, nuts, seeds, and vegetables to ensure you are getting all the essential amino acids and other nutrients your body needs.',
                style: TextStyle(fontSize: 16, color: Color(0xFF202157)),
              ),
              Text(
                'Moreover, it’s important to note that plant-based protein sources may have lower bioavailability than animal-based sources, meaning our body may not absorb the protein as efficiently. However, this can be counteracted by eating a variety of plant-based protein sources throughout the day.',
                style: TextStyle(fontSize: 16, color: Color(0xFF202157)),
              ),
              Text(
                'In conclusion, plant-based protein can be a healthy and sustainable choice for those looking to reduce their intake of animal products. By choosing whole plant-based foods and incorporating a variety of protein sources into your diet, you can ensure you are meeting your daily protein needs while also reaping other health benefits associated with a plant-based diet.',
                style: TextStyle(fontSize: 16, color: Color(0xFF202157)),
              ),
              SizedBox(height: 16),
              Text(
                'Contact a Nutritionist at MediMate for Precise Dietary Guidelines',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202157)),
              ),
              SizedBox(height: 16),
              Text(
                'Medimate is here to help you consult directly with a nutritionist about your daily nutritional intake.',
                style: TextStyle(fontSize: 16, color: Color(0xFF202157)),
              ),
              SizedBox(height: 8),
              buildContactItem(
                  'dr. Nadin Amizah, Sp. GK',
                  '15 years',
                  'Rumah Sakit Hermina Pasteur',
                  'assets/images/orang/dokter/humberto-chavez-FVh_yqLR9eA-unsplash.jpg'),
              buildContactItem(
                  'Dr. Rendy Pandugo, Sp. GK',
                  '10 years',
                  'Rumah Sakit Siloam',
                  'assets/images/orang/dokter/usman-yousaf-tPxS-1IPZAo-unsplash.jpg'),
              buildContactItem(
                  'Dr. Teddy Adhitya, Sp. GK',
                  '8 years',
                  'Rumah Sakit Medistra',
                  'assets/images/orang/dokter/austin-distel-7bMdiIqz_J4-unsplash.jpg'),
            ],
          ),
        ));
  }

  Widget buildBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF353779),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget buildListItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202157),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0), // Adjust the padding as needed
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF202157),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContactItem(
      String name, String experience, String hospital, String imagePath) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF353779), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202157)),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF353779),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    experience,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  hospital,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF353779),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
