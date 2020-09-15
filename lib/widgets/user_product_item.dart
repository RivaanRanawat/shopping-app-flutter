import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final productData =  Provider.of<Products>(context);
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(icon: Icon(Icons.edit),onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
          },color: Theme.of(context).primaryColor),
          IconButton(icon: Icon(Icons.delete),onPressed: () async {
            try{
            await productData.deleteProduct(id);
            } catch(err) {
              // because future runs and rebuilds, so not sure if we are referring to the same context.
              scaffold.showSnackBar(SnackBar(content: Text("Product could not be deleted."),));
            }
          },color: Theme.of(context).accentColor,),
        ],),
      ),
    );
  }
}
