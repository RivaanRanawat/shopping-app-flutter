import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product-screen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  var _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  var _editedProduct =
      Product(id: null, title: "", price: 0.0, imageUrl: "", description: "");

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.validate();
    if(!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if(value.isEmpty) {
                    return "Please enter the title of the Product.";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      title: value,
                      description: _editedProduct.description,
                      id: null,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      id: null,
                      imageUrl: _editedProduct.imageUrl,
                      price: double.parse(value));
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                      title: _editedProduct.title,
                      description: value,
                      id: null,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? Text("Enter an image URL")
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ), // image
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                       _editedProduct = Product(
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      id: null,
                      imageUrl: value,
                      price: _editedProduct.price);
                },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
