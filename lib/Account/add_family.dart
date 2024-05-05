import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const AddFamilyMemberPage());
}

class AddFamilyMemberPage extends StatefulWidget {
  const AddFamilyMemberPage({Key? key}) : super(key: key);

  @override
  State<AddFamilyMemberPage> createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMemberPage> {
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();

  String? _selectedRelation; 
  List<String> _relations = [
    'Parent',
    'Sibling',
    'Spouse',
    'Child',
    'Grandparent',
    'Grandchild',
  ];

  String? _selectedInsurance;
  List<String> _insuranceOptions = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];

  bool _allFieldsFilled() {
    return _selectedDate != null &&
        _selectedRelation != null &&
        _selectedInsurance != null &&
        _dateController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add Family Member',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Family Member',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF091547),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("General Information"),
                _buildFullNameTextField(),
                _buildDateOfBirthField(),
                _buildRelationDropdown(),
                _buildSectionTitle("Additional Information"),
                _buildWeightTextField(),
                _buildHeightTextField(),
                _buildInsuranceDropdown(),
                _buildAddProfileButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color(0xFF202157).withOpacity(0.85),
        ),
      ),
    );
  }

  Widget _buildFullNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF51539B),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Enter full name according to ID",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF090F47).withOpacity(0.5),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7173BD).withOpacity(0.75),
                width: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date of Birth",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF51539B),
          ),
        ),
        TextFormField(
          readOnly: true,
          controller: _dateController,
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
                _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
              });
            }
          },
          decoration: InputDecoration(
            hintText: "Select date of birth",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF090F47).withOpacity(0.5),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7173BD).withOpacity(0.75),
                width: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRelationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Relations",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF51539B),
          ),
        ),
        DropdownButtonFormField<String>(
          value: _selectedRelation,
          onChanged: (newValue) {
            setState(() {
              _selectedRelation = newValue;
            });
          },
          items: _relations.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: "Select relationship with main profile",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF090F47).withOpacity(0.5),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7173BD).withOpacity(0.75),
                width: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildWeightTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weight (kg)",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF51539B),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Enter weight in kg",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF090F47).withOpacity(0.5),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7173BD).withOpacity(0.75),
                width: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHeightTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Height (cm)",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF51539B),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Enter height in cm",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF090F47).withOpacity(0.5),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7173BD).withOpacity(0.75),
                width: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInsuranceDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Insurance",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF51539B),
          ),
        ),
        DropdownButtonFormField<String>(
          value: _selectedInsurance,
          onChanged: (newValue) {
            setState(() {
              _selectedInsurance = newValue;
            });
          },
          items: _insuranceOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: "Select the insurance",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF090F47).withOpacity(0.5),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7173BD).withOpacity(0.75),
                width: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAddProfileButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: _allFieldsFilled() ? Color(0xFF202157) : Color(0xFFCCCCCC),
      ),
      child: MaterialButton(
        onPressed: () {
          // Handle button press
        },
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          "Add Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: _allFieldsFilled() ? Color(0xFFFFFFFF).withOpacity(0.75) : Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
