import 'package:flutter/material.dart';
import 'checkout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxury Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedCategory = 'Samsung';
  String _searchQuery = ''; // Variable to hold the search query
  List<Map<String, dynamic>> _products = [
    {
      'name': 'Galaxy S24 ultra',
      'description':
          '256GB Storage, 12GB RAM, 200MP Camera, S Pen, Long Battery Life Android Smartphone',
      'category': 'Samsung',
      'image': 's24u.png',
      'price': 1299.99
    },
    {
      'name': 'Galaxy S24 Plus',
      'description':
          '256GB, 50MP Camera, Fast Processor, Long Battery Life, AMOLED Display',
      'category': 'Samsung',
      'image': 's24.jpg',
      'price': 999.99
    },
    {
      'name': 'Galaxy fold 6',
      'description': 'Samsung\'s foldable flagship smartphone',
      'category': 'Samsung',
      'image': 'samsung fold 6.png',
      'price': 1799.99
    },
    {
      'name': 'iPhone 16',
      'description':
          '6.1 inch, Advanced dual-camera system 48MP Fusion | 12MP Ultra , 128gb ',
      'category': 'Apple',
      'image': 'ip16.png',
      'price': 849.99
    },
    {
      'name': 'iPhone 16 pro max',
      'description':
          '6.9 inch, Pro camera system 48MP Fusion | 48MP Ultra Wide | Telephoto, 256 gb',
      'category': 'Apple',
      'image': 'iphone 16 pro max.png',
      'price': 1399.99
    },
    {
      'name': 'iPhone 15',
      'description':
          '6.1 inch, Advanced dual-camera system 48MP Main | 12MP Ultra Wide, 128gb',
      'category': 'Apple',
      'image': '15.png',
      'price': 749.99
    },
  ];
  List<Map<String, dynamic>> _cart = [];

  @override
  Widget build(BuildContext context) {
    // Filtering products based on the selected category and search query
    List<Map<String, dynamic>> filteredProducts = _products
        .where((product) =>
            product['category'] == _selectedCategory &&
            product['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 225, 76, 7),
        title: Text(
          'Luxury Tech',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.supervised_user_circle),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 244, 243, 241),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query; // Update search query
                  });
                },
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 225, 76, 7),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'Apple';
                    });
                  },
                  child: Text(
                    'Apple',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 225, 76, 7),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'Samsung';
                    });
                  },
                  child: Text(
                    'Samsung',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: filteredProducts.length * 270 / 2 +
                    (filteredProducts.length / 2).ceil() * 25,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    var product = filteredProducts[index];
                    return buildProductCard(product);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: const Color.fromARGB(255, 225, 76, 7),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cart: _cart),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/${product['image']}',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name'],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product['description'],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              '\$${product['price'].toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 140),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _cart.add({
                      'name': product['name'],
                      'quantity': 1,
                      'price': product['price']
                    });
                  });
                },
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white , fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var item in widget.cart) {
      totalPrice += item['price'] * item['quantity'];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 225, 76, 7),
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: widget.cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                var cartItem = widget.cart[index];
                return ListTile(
                  title: Text(
                    cartItem['name'],
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Quantity: ${cartItem['quantity']} | Price: \$${(cartItem['price'] * cartItem['quantity']).toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            if (cartItem['quantity'] > 1) {
                              cartItem['quantity']--;
                            } else {
                              widget.cart.removeAt(index);
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            cartItem['quantity']++;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: const Color.fromARGB(255, 225, 76, 7)),
                        onPressed: () {
                          setState(() {
                            widget.cart.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomSheet: Container(
        color: Colors.white, // Background color for the bottom sheet
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Box color for the Checkout button
                ),
                onPressed: () {
                  // Navigate to CheckoutPage and pass the cart
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(cart: widget.cart),
                    ),
                  );
                },
                child: Text('Checkout',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
