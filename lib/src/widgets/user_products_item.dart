import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/products.dart';
import 'package:shopapp/src/screen/edit_product_screen.dart';

class UserProductItems extends StatelessWidget {
  final String id;
  final String title;
  final String imgeUrl;
  UserProductItems(this.title, this.imgeUrl, this.id);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgeUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print(id);
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routerName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: ()async{
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProducts(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text('Deleting faild!'),
                  ));
                }
              },
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
