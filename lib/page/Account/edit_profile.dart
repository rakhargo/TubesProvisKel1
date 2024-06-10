import 'package:flutter/material.dart';
import 'package:medimate/main.dart';
import 'package:provider/provider.dart';
import 'package:medimate/provider/api/profile_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:medimate/provider/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String responseBody;
  final String profileId;

  const EditProfilePage({
    Key? key,
    required this.responseBody,
    required this.profileId,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String accessToken;
  late String userId;
  Profile? chosenProfile;
  File? _image;
  final picker = ImagePicker();

  final _namaController = TextEditingController();
  final _tanggallahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final _notelpController = TextEditingController();
  final _emailController = TextEditingController();

  String? _selectedGender;
  int? _selectedRelations;
  Color _updateProfileButtonColor = Colors.grey;

  List<dynamic> _relations = [];
  bool _isLoadingRelations = true;

  @override
  void initState() {
    super.initState();
    _initializeUserIdAndAccessToken();
    _fetchRelations();
    _fetchProfile(widget.profileId);
  }

  void _initializeUserIdAndAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchProfile(String profileId) async {
    try {
      final profileResponse =
          await Provider.of<ProfileAPI>(context, listen: false)
              .fetchDataByProfileId(profileId, accessToken);

      setState(() {
        chosenProfile = profileResponse;
        _namaController.text = chosenProfile!.nama;
        _tanggallahirController.text = DateFormat('dd-MM-yyyy').format(
            DateFormat('yyyy-MM-dd').parse(chosenProfile!.tanggalLahir));
        _selectedGender = chosenProfile!.jenisKelamin;
        _alamatController.text = chosenProfile!.alamat;
        _notelpController.text = chosenProfile!.noTelepon;
        _emailController.text = chosenProfile!.email;
        _selectedRelations = int.parse(chosenProfile!.isMainProfile);
      });
    } catch (e) {
      // Handle exception
    }
  }

  Future<void> _fetchRelations() async {
    try {
      final response = await Provider.of<ProfileAPI>(context, listen: false)
          .fetchRelations(accessToken);

      if (response.statusCode == 200) {
        final List<dynamic> relations = jsonDecode(response.body);
        setState(() {
          _relations =
              relations.where((relation) => relation['id'] != 1).toList();
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

  Future<String?> _uploadImage() async {
    if (_image == null) return null;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/upload_profile_image'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        _image!.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);
      print("image upload success");
      return json['image_name'];
    } else {
      print('Image upload failed');
      return null;
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    } else {
      print('No image selected.');
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
          child: Consumer<ProfileAPI>(
            builder: (context, item, child) {
              return chosenProfile == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue, // Change color as needed
                          ),
                          child: ClipOval(
                            child: FutureBuilder<dynamic>(
                              future: item.fetchImage(
                                  widget.profileId, accessToken),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Icon(Icons.error);
                                } else if (snapshot.hasData) {
                                  return Image.memory(
                                    snapshot.data!.bodyBytes,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return const Placeholder();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: Text('Pick Image'),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(_emailController, "Email", size),
                        SizedBox(height: 20),
                        _buildTextField(
                            _namaController, "Enter your name", size),
                        SizedBox(height: 20),
                        _buildDateField(_tanggallahirController,
                            "Enter your birth date", context, size),
                        SizedBox(height: 20),
                        _buildDropdownField(
                            ['Male', 'Female'], "Select your gender", size),
                        SizedBox(height: 20),
                        _buildTextField(
                            _alamatController, "Enter your address", size),
                        SizedBox(height: 20),
                        _buildTextField(_notelpController,
                            "Enter your mobile number", size),
                        if (chosenProfile!.isMainProfile != 1.toString()) ...[
                          SizedBox(height: 20),
                          _isLoadingRelations
                              ? CircularProgressIndicator()
                              : _buildRelationsDropdown(size),
                        ],
                        SizedBox(height: 30),
                        _updateProfileButton(size),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, Size size) {
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

  Widget _buildDateField(TextEditingController controller, String hint,
      BuildContext context, Size size) {
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

  Widget _updateProfileButton(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: size.width * 0.8,
        child: ElevatedButton(
          onPressed:
              _updateProfileButtonColor == Colors.grey ? null : _updateProfile,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            backgroundColor: _updateProfileButtonColor,
          ),
          child: Text(
            "UPDATE PROFILE",
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
        _updateProfileButtonColor = Color(0xFF202157);
      });
    } else {
      setState(() {
        _updateProfileButtonColor = Colors.grey;
      });
    }
  }

  void _updateProfile() async {
    final String formattedDate = DateFormat("yyyy-MM-dd").format(
      DateFormat("dd-MM-yyyy").parse(_tanggallahirController.text),
    );

    try {
      String? userPhoto =
          await _uploadImage(); // Upload the image and get the file name

      final userPhotoFirst = chosenProfile!.userPhoto;

      _selectedRelations ??= 1;

      final profileToUpdate = Profile(
        id: widget.profileId,
        userId: userId,
        nama: _namaController.text,
        tanggalLahir: formattedDate,
        jenisKelamin: _selectedGender!,
        email: _emailController.text,
        alamat: _alamatController.text,
        noTelepon: _notelpController.text,
        userPhoto: userPhoto ??= userPhotoFirst,
        isMainProfile: _selectedRelations!.toString(),
      );

      final response = await Provider.of<ProfileAPI>(context, listen: false)
          .updateProfile(
              profileToUpdate.toJson(), accessToken, widget.profileId);

      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        print('Failed to update profile: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception during update profile: $e');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Profile Successful'),
          content: Text('You have successfully updated a profile!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainApp(
                      indexNavbar: 3,
                      responseBody: widget.responseBody,
                      profileId: widget.profileId,
                    ),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
