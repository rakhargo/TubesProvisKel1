import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medimate/main.dart';
import 'package:provider/provider.dart';
import 'package:medimate/provider/api/profile_api.dart';

class CreateProfilePage extends StatefulWidget {
  final String responseBody;
  final String profileId;

  const CreateProfilePage(
      {Key? key, required this.responseBody, required this.profileId})
      : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfilePage> {
  late String accessToken;
  late String userId;

  TextEditingController _namaController = TextEditingController();
  TextEditingController _tanggallahirController = TextEditingController();
  String? _selectedGender;
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _notelpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  int? _selectedRelations;
  Color _createProfileButtonColor = Colors.grey;

  List<dynamic> _relations = [];
  bool _isLoadingRelations = true;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _initializeAccessToken();
    _fetchRelations();
  }

  void _initializeUserId() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchRelations() async {
    try {
      final response = await Provider.of<ProfileAPI>(context, listen: false).fetchRelations(accessToken);

      if (response.statusCode == 200) {
        final List<dynamic> relations = jsonDecode(response.body);
        setState(() {
          _relations = relations.where((relation) => relation['id'] != 1).toList();
          _isLoadingRelations = false;
        });
      } else {
        throw Exception('Failed to load relations');
      }
    } catch (e) {
      setState(() {
        _isLoadingRelations = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            "assets/icons/back.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Add Family Member",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color(0xFF090F47),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(_emailController, "Email", size),
              SizedBox(height: 20),
              _buildTextField(_namaController, "Enter your name", size),
              SizedBox(height: 20),
              _buildDateField(_tanggallahirController, "Enter your birth date", context, size),
              SizedBox(height: 20),
              _buildDropdownField(['Male', 'Female'], "Select your gender", size),
              SizedBox(height: 20),
              _buildTextField(_alamatController, "Enter your address", size),
              SizedBox(height: 20),
              _buildTextField(_notelpController, "Enter your mobile number", size),
              SizedBox(height: 20),
              _isLoadingRelations
                  ? CircularProgressIndicator()
                  : _buildRelationsDropdown(size),
              SizedBox(height: 30),
              _createProfileButton(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, Size size) {
    return Container(
      width: size.width * 0.8,
      child: TextField(
        controller: controller,
        onChanged: (_) => _updateCreateProfileButtonColor(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String hint, BuildContext context, Size size) {
    return Container(
      width: size.width * 0.8,
      child: TextField(
        controller: controller,
        onTap: () => _selectDate(context),
        readOnly: true,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(List<String> items, String hint, Size size) {
    return Container(
      width: size.width * 0.8,
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
            _updateCreateProfileButtonColor();
          });
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
          ),
        ),
      ),
    );
  }

  Widget _buildRelationsDropdown(Size size) {
    return Container(
      width: size.width * 0.8,
      child: DropdownButtonFormField<int>(
        value: _selectedRelations,
        items: _relations.map<DropdownMenuItem<int>>((dynamic value) {
          return DropdownMenuItem<int>(
            value: value['id'],
            child: Text(value['relation']),
          );
        }).toList(),
        onChanged: (int? newValue) {
          setState(() {
            _selectedRelations = newValue;
            _updateCreateProfileButtonColor();
          });
        },
        decoration: InputDecoration(
          hintText: "Select your relation",
          hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
          ),
        ),
      ),
    );
  }

  Widget _createProfileButton(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: size.width * 0.8,
        child: ElevatedButton(
          onPressed: _createProfileButtonColor == Colors.grey ? null : _createProfile,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            backgroundColor: _createProfileButtonColor,
          ),
          child: Text(
            "CREATE PROFILE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _tanggallahirController.text = DateFormat('dd-MM-yyyy').format(picked);
        _updateCreateProfileButtonColor();
      });
    }
  }

  void _updateCreateProfileButtonColor() {
    if (_namaController.text.isNotEmpty &&
        _tanggallahirController.text.isNotEmpty &&
        _selectedGender != null &&
        _alamatController.text.isNotEmpty &&
        _notelpController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _selectedRelations != null) {
      setState(() {
        _createProfileButtonColor = Color(0xFF202157);
      });
    } else {
      setState(() {
        _createProfileButtonColor = Colors.grey;
      });
    }
  }

  void _createProfile() async {
    final String tanggalLahir = _tanggallahirController.text;
    final DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(tanggalLahir);
    final String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);

    final Map<String, dynamic> responseBodyLogin = jsonDecode(widget.responseBody);
    final String accessToken = responseBodyLogin['access_token'];
    final int userId = responseBodyLogin['user_id'];

    try {
      final response = await Provider.of<ProfileAPI>(context, listen: false).createNewProfile(
        userId.toString(),
        _namaController.text,
        formattedDate,
        _selectedGender!,
        _alamatController.text,
        _emailController.text,
        _notelpController.text,
        "dummy.png",
        _selectedRelations.toString(),
        accessToken,
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Create Profile Successful'),
              content: Text('You have successfully created a profile!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainApp(responseBody: widget.responseBody, indexNavbar: 0, profileId: widget.profileId.toString()),
                      ),
                    ); // Navigate to login page
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to create profile: ${response.reasonPhrase}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception during making profile: $e');
    }
  }
}
