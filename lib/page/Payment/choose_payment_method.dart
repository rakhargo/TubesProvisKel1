import 'package:flutter/material.dart';

// void main() {
//   runApp(MediMateApp());
// }

// class MediMateApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MediMate',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PaymentPage(),
//     );
//   }
// }

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'On the Site';
  String _selectedBank = 'BCA Virtual Account';
  List<String> banks = [
    'BCA Virtual Account',
    'Mandiri Virtual Account',
    'BNI Virtual Account',
    'BRI Virtual Account'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios, color: Color.fromRGBO(32, 33, 87, 1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Payment',
          style: TextStyle(
            color: Color.fromRGBO(32, 33, 87, 1),
            fontWeight: FontWeight.bold, // Ubah font weight menjadi bold
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Payment Method',
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 33, 87, 1)),
            ),
            SizedBox(height: 16),
            _buildPaymentMethodCard('On the Site'),
            _buildPaymentMethodCard('QRIS'),
            _buildPaymentMethodCard('Virtual Account'),
            if (_selectedPaymentMethod == 'Virtual Account')
              _buildVirtualAccountDropdown(),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle confirm action
                  // Navigate to the next page
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF202157), // Ubah warna latar tombol
                    foregroundColor: Color(0xFFFFFFFF)),
                child: Text('CONFIRM'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(String method) {
    return Card(
      child: ListTile(
        leading: Radio<String>(
          value: method,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
        title: Text(method),
      ),
    );
  }

  Widget _buildVirtualAccountDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration( 
          border: OutlineInputBorder(),
          labelText: 'Select Bank',
        ),
        value: _selectedBank,
        onChanged: (String? newValue) {
          setState(() {
            _selectedBank = newValue!;
          });
        },
        items: banks.map((String bank) {
          return DropdownMenuItem<String>(
            value: bank,
            child: Text(bank),
          );
        }).toList(),
      ),
    );
  }
}
