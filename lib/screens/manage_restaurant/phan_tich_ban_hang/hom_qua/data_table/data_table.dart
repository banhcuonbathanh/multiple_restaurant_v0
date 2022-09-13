import 'package:flutter/material.dart';
import 'package:untitled1/model/order_model.dart';

class DataTableCustomer extends StatefulWidget {
  final List<OrderModel> orderAnalitic;

  const DataTableCustomer({Key? key, required this.orderAnalitic})
      : super(key: key);

  @override
  State<DataTableCustomer> createState() => _DataTableCustomerState();
}

class _DataTableCustomerState extends State<DataTableCustomer> {
  List<OrderModel> listOrder = [];
  List<OrderModel> selectedOrderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> columns = ['nguoi mua', 'so luong mon an'];
    List<DataColumn> getColumn({required List<String> columns}) {
      return columns
          .map((String column) => DataColumn(label: Text(column)))
          .toList();
    }

    List<DataRow> getRow({required List<OrderModel> orderAnalitic}) {
      int soLuongMonAn = 0;
      for (var i in orderAnalitic) {
        for (var j in i.productdetailsIdList) {
          soLuongMonAn = soLuongMonAn + j.productdetailQuantity!.toInt();
        }
      }
      return orderAnalitic
          .map(
            (OrderModel order) => DataRow(
              selected: selectedOrderList.contains(order),
              onSelectChanged: (isSelected) {
                return setState(() {
                  final isAdding = isSelected != null && isSelected;
                  isAdding
                      ? selectedOrderList.add(order)
                      : selectedOrderList.remove(order);
                });
              },
              cells: [
                DataCell(
                  Text(order.BuyingUserName),
                ),
                DataCell(
                  Text(soLuongMonAn.toString()),
                ),
              ],
            ),
          )
          .toList();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: getColumn(columns: columns),
        rows: getRow(orderAnalitic: widget.orderAnalitic),
      ),
    );
  }
}
