import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_buttton.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add_product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String categary = 'Mobiles';

  List<File> images = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentional',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              SizedBox(
                width: 70,
              ),
              const Text(
                'Add Product',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map((i) {
                        return Builder(builder: (BuildContext context) {
                          return Image.file(
                            i,
                            fit: BoxFit.cover,
                            height: 200,
                          );
                        });
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                      ))
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        dashPattern: [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select Product Images',
                                style: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: productNameController,
                hintText: 'Enter Product Name',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                controller: descriptionController,
                hintText: 'Enter Description',
                Maxlen: 7,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                controller: priceController,
                hintText: 'Enter Price ',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                controller: quantityController,
                hintText: 'Enter Quantity',
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Background color
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                  border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1), // Border color and width
                ),
                child: Container(
                  width: double.infinity, // Full width
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Padding inside the dropdown
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: categary,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          categary = newVal!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtton(text: 'Sell', onTap: () {})
            ],
          ),
        )),
      ),
    );
  }
}
