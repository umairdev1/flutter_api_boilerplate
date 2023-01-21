import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api_boilerplate/resources/colors.dart';
import 'package:flutter_api_boilerplate/viewModel/product_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  File? singleImage;
  chooseImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        singleImage = File(pickedFile.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final productviewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          "Add Product",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                InkWell(
                  onTap: () {
                    chooseImage();
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.buttonColor)),
                    child: Center(
                      child: singleImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                singleImage!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image),
                                10.width,
                                Text(
                                  "Add Image",
                                  style: TextStyle(color: AppColors.blackColor),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                20.height,
                TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
                20.height,
                TextFormField(
                  controller: description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'desc',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
                20.height,
                30.height,
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (singleImage == null) {
                          EasyLoading.showToast("please select Image");
                        } else {
                          EasyLoading.show();
                          EasyLoading.show();
                          Map data = {
                            "name": name.text,
                            "description": description.text,
                          };
                          productviewModel.addDataWithImageApi(
                              singleImage!, data, context);
                        }
                      }
                    },
                    child: Text("Add"))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
