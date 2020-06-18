import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/order.dart';
import 'package:shopapp/src/provider/shipper.dart';
import 'package:shopapp/src/utils/toast.dart';
import 'package:shopapp/src/widgets/shipper_item.dart';

class Option extends StatefulWidget {
  final Cart cart;
  final String maquan;
  final String makh;
  final String phiship;
  const Option(
      {Key key,
      @required this.cart,
      @required this.maquan,
      @required this.makh,
      @required this.phiship})
      : super(key: key);
  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  var isInit = true;
  var isLoading = false;
  String radioItem = 'Item 1';
  String hinhthuctt = "1";
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Shippers>(context).fetchData().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mashiper = Provider.of<Shippers>(context).mashiper;
    final response = Provider.of<Orders>(context).respone;
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Phương thức thanh toán"),
              RadioListTile(
                value: 'Item 1',
                title: Text('Thanh toán online'),
                groupValue: radioItem,
                onChanged: (value) {
                  setState(() {
                    radioItem = value;
                    hinhthuctt = "1";
                  });
                },
              ),
              RadioListTile(
                value: 'Item 2',
                title: Text('Thanh toán khi nhận hàng  '),
                groupValue: radioItem,
                onChanged: (value) {
                  setState(() {
                    radioItem = value;
                    hinhthuctt = "2";
                  });
                },
              ),
              Divider(
                color: Colors.black,
                height: 10,
              ),
              Text("Chọn shipper"),
              isLoading
                  ? Center(
                      child: Column(
                        children: <Widget>[
                          Text("Đang tìm shipper"),
                          CircularProgressIndicator()
                        ],
                      ),
                    )
                  : Consumer<Shippers>(
                      builder: (ctx, orderData, child) => ListView.builder(
                            shrinkWrap: true,
                            itemCount: orderData.items.length,
                            itemBuilder: (ctx, i) =>
                                ShipperItem(orderData.items[i]),
                          )),
              FlatButton(
                child:
                    isLoading ? CircularProgressIndicator() : Text("ODER NOW"),
                onPressed: (widget.cart.totalAmount <= 0 || isLoading)
                    ? null
                    : () async {
                        if (widget.cart.item.length <= 0) {
                          print("no item");
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<Orders>(context, listen: false)
                              .addOrder(
                                  widget.cart.item.values.toList(),
                                  widget.cart.quaity,
                                  widget.cart.totalAmount,
                                  widget.maquan,
                                  widget.makh,
                                  mashiper,
                                  hinhthuctt,
                                  widget.phiship);

                          setState(() {
                            isLoading = false;
                          });

                          widget.cart.clear();
                          Navigator.of(context).pop();
                        }
                      },
                textColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
