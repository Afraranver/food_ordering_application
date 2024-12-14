import 'package:flutter/material.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  int quantity = 1;
  final TextEditingController _commentController = TextEditingController();

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Comment Section
        const Text(
          'Add Comments (Optional)',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF19120E),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 36 / 32,
          ),
        ),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            hintText: 'Write here',
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFFA7A19E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 36 / 32,
            ),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 16),

        // Quantity Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: _decrementQuantity,
                  icon: const Icon(Icons.remove, color: Colors.green),
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF201A18),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 36 / 32,
                  ),
                ),
                IconButton(
                  onPressed: _incrementQuantity,
                  icon: const Icon(Icons.add, color: Colors.green),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 36 / 32,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
