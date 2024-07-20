import 'package:e_comm_exam/utils/product_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Map<String, dynamic> product =
        (ModalRoute.of(context)?.settings.arguments ?? allProducts[0])
            as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text("Detail Page"),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // Thumbnail View
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                product['images'].length,
                (index) => Container(
                  height: size.height * 0.3,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xffF2EFE5),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(product['images'][index]),
                      fit: BoxFit.contain,
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                ),
              ),
            ),
          ),
          const Spacer(),
          // Details Card
          Container(
            height: size.height * 0.5,
            width: size.width,
            decoration: const BoxDecoration(
              color: Color(0xffC7C8CC),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
              borderRadius: BorderRadius.vertical(
                top: Radius.elliptical(30, 50),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    product['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "\$${product['price'].toStringAsFixed(2)}/-",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Discount: ${product['discountPercentage'].toString()}%",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Brand: ${product['brand']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "SKU: ${product['sku']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Weight: ${product['weight']} grams",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Dimensions: ${product['dimensions']['width']} x ${product['dimensions']['height']} x ${product['dimensions']['depth']} cm",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Warranty Information: ${product['warrantyInformation']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Shipping Information: ${product['shippingInformation']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Availability: ${product['availabilityStatus']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Return Policy: ${product['returnPolicy']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Minimum Order Quantity: ${product['minimumOrderQuantity']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Created At: ${product['meta']['createdAt']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Updated At: ${product['meta']['updatedAt']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RatingBarIndicator(
                    rating: double.parse(
                      product['rating'].toString(),
                    ),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          late SnackBar snackBar;
          if (cartItems.contains(product)) {
            cartItems.remove(product);
            snackBar = SnackBar(
              content: Text("${product['title']} removed from the CART !!"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            );
          } else {
            cartItems.add(product);
            snackBar = SnackBar(
              content: Text("${product['title']} added to the CART !!"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        backgroundColor: const Color(0xffB5C0D0),
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        label: const Text("Add to cart"),
      ),
    );
  }
}
