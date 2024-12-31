import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  CheckoutPage({required this.cart});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _paymentMethod = 'Visa'; // Default payment method
  final TextEditingController _cardholderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  // Controllers for Cash on Delivery
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Simple validation for Visa details
  bool _validateVisaDetails() {
    if (_cardholderNameController.text.isEmpty ||
        _cardNumberController.text.isEmpty ||
        _expiryController.text.isEmpty ||
        _cvvController.text.isEmpty) {
      return false;
    }

    // Example basic validation for Visa card details (16 digits, 3 digits CVV)
    if (_cardNumberController.text.length != 16 ||
        _cvvController.text.length != 3) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var item in widget.cart) {
      totalPrice += item['price'] * item['quantity'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 225, 76, 7),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // Ensure screen adjusts when keyboard appears
      body: SingleChildScrollView(
        // Make entire body scrollable
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cart Summary
              Text(
                'Cart Summary:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                itemCount: widget.cart.length,
                shrinkWrap:
                    true, // Make the ListView take only the space it needs
                itemBuilder: (context, index) {
                  var cartItem = widget.cart[index];
                  return ListTile(
                    title: Text(cartItem['name']),
                    subtitle: Text('Quantity: ${cartItem['quantity']}'),
                    trailing: Text(
                        '\$${(cartItem['price'] * cartItem['quantity']).toStringAsFixed(2)}'),
                  );
                },
              ),
              SizedBox(height: 10),
              // Payment Method
              Text(
                'Select Payment Method:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Visa'),
                leading: Radio<String>(
                  value: 'Visa',
                  groupValue: _paymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _paymentMethod = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Cash on Delivery'),
                leading: Radio<String>(
                  value: 'Cash on Delivery',
                  groupValue: _paymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _paymentMethod = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              // Total Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_paymentMethod == 'Visa') {
                          // Show Visa payment dialog
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Enter Visa Details'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _cardholderNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Cardholder Name',
                                    ),
                                  ),
                                  TextField(
                                    controller: _cardNumberController,
                                    decoration: InputDecoration(
                                      labelText: 'Card Number (16 digits)',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextField(
                                    controller: _expiryController,
                                    decoration: InputDecoration(
                                      labelText: 'Expiry Date (MM/YY)',
                                    ),
                                  ),
                                  TextField(
                                    controller: _cvvController,
                                    decoration: InputDecoration(
                                      labelText: 'CVV (3 digits)',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (_validateVisaDetails()) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Order Placed'),
                                          content: Text(
                                              'Your order has been placed successfully!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Invalid Visa Details'),
                                          content: Text(
                                              'Please check your card details and try again.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Cash on Delivery
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Enter Details for Cash on Delivery'),
                              content: SingleChildScrollView(
                                // Wrap form with scroll view
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                      ),
                                    ),
                                    TextField(
                                      controller: _addressController,
                                      decoration: InputDecoration(
                                        labelText: 'Address',
                                      ),
                                    ),
                                    TextField(
                                      controller: _floorController,
                                      decoration: InputDecoration(
                                        labelText: 'Floor Number',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: _apartmentController,
                                      decoration: InputDecoration(
                                        labelText: 'Apartment Number',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                      ),
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Validate all fields
                                    if (_nameController.text.isNotEmpty &&
                                        _addressController.text.isNotEmpty &&
                                        _floorController.text.isNotEmpty &&
                                        _apartmentController.text.isNotEmpty &&
                                        _phoneController.text.isNotEmpty) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Order Placed'),
                                          content: Text(
                                              'Your order has been placed successfully!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Invalid Details'),
                                          content: Text(
                                              'Please fill out all fields before proceeding.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Cancel
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        'Place Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
