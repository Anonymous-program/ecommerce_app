import 'dart:io';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/utils/widget_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/newProduct';
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  String? localImagePath;
  CategoryModel? categoryModel;
  final _fromKey = GlobalKey<FormState>();
  final _nameController=TextEditingController();
  final _priceController=TextEditingController();
  final _descriptionController=TextEditingController();
  final _stockController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Product'),
          actions: [
            IconButton(onPressed: _saveProduct, icon: const Icon(Icons.save)),
          ],
        ),
        body: Form(
          key: _fromKey,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              _buildImageSection(),
              _buildCategorySection(),
              _buildTextFieldSection(),
            ],
          ),
        ));
  }

  Widget _buildImageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            localImagePath == null
                ? const Icon(
                    Icons.card_giftcard,
                    size: 100,
                  )
                : Image.file(
                    File(localImagePath!),
                    width: 100,
                    height: 100,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Capture'),
                ),
                TextButton.icon(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getImage(ImageSource source) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 60);
    if (file != null) {
      if (mounted) {
        setState(() {
          localImagePath = file.path;
        });
      }
    }
  }

  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) =>
              DropdownButtonFormField<CategoryModel>(
              value: categoryModel,
              hint: const Text('Select a category'),
              isExpanded: true,
              items: provider.categoryList
                .map((category) => DropdownMenuItem<CategoryModel>(
                    value: category,
                  child: Text(category.name)))
                .toList(),
            onChanged: (value) {
              setState(() {
                categoryModel = value;
              });
            },
            validator: (value){
                if(value==null){
                  return 'This field must not be empty';
                }
                return null;
            },
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    super.dispose();
  }

 Widget _buildTextFieldSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
          child: TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Product Name',
              filled: true,
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return 'This field must not be empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Product Price',
              filled: true,
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return 'This field must not be empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
          child: TextFormField(
            maxLines: 3,
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Product Description(optional)',
              filled: true,
            ),
            validator: (value){
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _stockController,
            decoration: const InputDecoration(
              labelText: 'Stock',
              filled: true,
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return 'This field must not be empty';
              }
              return null;
            },
          ),
        ),

      ],
    );
 }

  void _saveProduct()async {
    if(localImagePath==null){
      showMsg(context, 'Please select a product image ');
      return;
    }
    if(_fromKey.currentState!.validate()){
      final imageUrl=await Provider.of<ProductProvider>(context,listen: false).uploadImage(localImagePath!);
      final productModel=ProductModel(name:_nameController.text.trim(),
          category: categoryModel!,
          price:num.parse(_priceController.text.trim()),
          stock: num.parse(_stockController.text.trim()),
          imageUrl: imageUrl,
      );
      EasyLoading.show(status: 'Please wait');
      Provider.of<ProductProvider>(context,listen: false)
      .addProduct(productModel)
      .then((value){
        EasyLoading.dismiss();
        showMsg(context, 'Saved');
        _resetField();
      })
      .catchError((error){
        EasyLoading.dismiss();
        showMsg(context, 'Could not  save');
      });
    }
  }

  void _resetField() {
    if(mounted){
      setState(() {
        localImagePath=null;
        categoryModel=null;
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _stockController.clear();
      });
    }
  }
}
