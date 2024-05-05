import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() 
{
  runApp(const HelpSupportPage());
}

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupportPage>
{
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
      home: Scaffold
      (
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
            preferredSize: const Size.fromHeight(2.0), //Set the height of the border
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Set the color of the border
                    width: 0.5, // Set the width of the border
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Set the color of the shadow
                    blurRadius: 2.0, // Set the blur radius of the shadow
                    offset: Offset(0.0, 2.0), // Set the offset of the shadow
                  ),
                ],
              ),
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    "Urgent problem?\nContact us now",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202157),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30), // Added SizedBox for spacing
              Center( // Wrap the Row with Center widget
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Aligns the containers evenly
                  children: [
                    _buildGradientContainer(Icons.phone_outlined, "Call"), // First container with icon and text
                    _buildGradientContainer(Icons.email_outlined, "Email"), // Second container with icon and text
                  ],
                ),
              ),
              
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Popular Questions",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202157),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 10), // Added SizedBox for spacing
              Divider( // Divider under "Popular Questions" text
                color: Color(0xFF9799DF).withOpacity(0.5),
                thickness: 1,
              ),
              
              SizedBox(height: 10), // Added SizedBox for spacing
              
              // Dropdowns
              // More items revealed when the box is clicked
              if (isExpanded) ...[
                Text("Additional item 1"),
                Text("Additional item 2"),
                // Add more items here
              ],
              
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildClickableBox() {
      return GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded; // Toggle expanded state
          });
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background color of the box
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Clickable Box",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(
                isExpanded ? Icons.remove : Icons.add,
                size: 30,
                color: Colors.black,
              ),
            ],
          ),
        ),
      );
    }

  Widget _buildGradientContainer(IconData iconData, String text) {
    return Container(
      width: 130,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color(0xFF7173BD), Color(0xFF51539B)], // Gradient colors
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0), // Add padding here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10), // Adjusted spacing between icon and text
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

