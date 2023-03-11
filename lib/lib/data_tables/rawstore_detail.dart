import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../api_link.dart';
import '../components/colors.dart';
import '../dll.dart';
import '../main.dart';
import '../models/customers.dart' show Data, Customers;
import 'package:http/http.dart' as http;
import 'dart:convert';

class RawstoreDetail extends StatefulWidget {
  const RawstoreDetail({Key? key}) : super(key: key);

  @override
  State<RawstoreDetail> createState() => _RawstoreDetailState();
}

class _RawstoreDetailState extends State<RawstoreDetail> with DLL {
  Customers? customers;
  String date = sharedPref.getString("S_LastUpdate").toString();
  String currentCustomer = "0";
  bool isLoading = false;
  bool isOwner = false;

  void _getCustomers() async {
    var response = await http.post(Uri.parse("$linkServerName/Customers.php"));

    setState(() {
      customers = Customers.fromJson(json.decode(response.body));
    });
  }

  @override
  void initState() {
    super.initState();
    if (sharedPref.getString("S_UserType") == '0') {
      currentCustomer = sharedPref.getString("S_CusCode")!;
    } else {
      _getCustomers();
      isOwner = true;
      currentCustomer = "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: kMainColor,
          actions: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/Logo.png',
                width: 50,
              ),
            ),
          ],
          title: const Center(
            child: Text(
              "رصيد الخام مفصل",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: isOwner,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 60,
                        decoration: BoxDecoration(
                          color: kMainColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Autocomplete<Data>(
                          optionsMaxHeight: 300,
                          onSelected: (data) {
                            currentCustomer = data.cusCode;
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          optionsBuilder: (TextEditingValue value) {
                            return customers!.data
                                .where((element) => element.cusName
                                    .toLowerCase()
                                    .contains(value.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (Data d) => d.cusName,
                          fieldViewBuilder: (context, controller, focsNode,
                              onEditingComplete) {
                            return TextField(
                              textDirection: TextDirection.rtl,
                              controller: controller,
                              focusNode: focsNode,
                              onEditingComplete: onEditingComplete,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: kMainColor)),
                                hintText: "أختر العميل",
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: kMainColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Center(
                        child: Text(
                          sharedPref.getString("S_LastUpdate").toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.72,
                      child: FutureBuilder(
                        future: getProductDataSource(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          return snapshot.hasData
                              ? SfDataGridTheme(
                                  data: SfDataGridThemeData(
                                    headerColor:
                                        kMainColor.withOpacity(0.7),
                                    selectionColor: Colors.grey,
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SfDataGrid(
                                      source: snapshot.data,
                                      columns: getColumns(snapshot),
                                      allowPullToRefresh: true,
                                      allowSorting: true,
                                      rowHeight: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.089,
                                      selectionMode: SelectionMode.multiple,
                                      gridLinesVisibility:
                                          GridLinesVisibility.both,
                                      headerGridLinesVisibility:
                                          GridLinesVisibility.both,
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: kMainColor,
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await generateProductList();
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns(AsyncSnapshot<dynamic> snapshot) {
    ProductDataGridSource dataSource = snapshot.data;

    if (dataSource.productList.isNotEmpty) {
      return <GridColumn>[
        GridColumn(
            columnName: 'CusSNo',
            width: MediaQuery.of(context).size.width * 0.23,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text('الرساله',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.clip,
                    softWrap: true))),
        GridColumn(
            columnName: 'DateInOut',
            width: MediaQuery.of(context).size.width * 0.35,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  'تاريخ التوريد',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
        GridColumn(
            columnName: "CusName",
            width: MediaQuery.of(context).size.width * 0.45,
            visible: isOwner,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  "العميل",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
        GridColumn(
            columnName: 'Cloth',
            width: MediaQuery.of(context).size.width * 0.5,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  'الخام',
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
        GridColumn(
            columnName: 'ThNo',
            width: MediaQuery.of(context).size.width * 0.2,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  'الغزل',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
        GridColumn(
            columnName: 'InchNo',
            width: MediaQuery.of(context).size.width * 0.2,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text('البوصه',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.clip,
                    softWrap: true))),
        GridColumn(
            columnName: 'RawSupp',
            width: MediaQuery.of(context).size.width * 0.4,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  'مورد الخام',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
        GridColumn(
            columnName: "RollIncome",
            width: MediaQuery.of(context).size.width * 0.25,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  "أثواب وارده",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
        GridColumn(
            columnName: 'RawIncome',
            width: MediaQuery.of(context).size.width * 0.27,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  'الكميه الوارد',
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
        GridColumn(
            columnName: 'RawWt',
            width: MediaQuery.of(context).size.width * 0.25,
            label: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  'الرصيد',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))),
      ];
    } else {
      return <GridColumn>[
        GridColumn(
            columnName: '',
            width: MediaQuery.of(context).size.width + 4,
            label: Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  "لا يوجد رصيد",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                  ),
                ))),
      ];
    }
  }

  Future<List<Product>> generateProductList() async {
    List<Product> productList = [];
    var response = await postRequest(
        "$linkServerName/Rawstore/RawDetail.php", {"CusCode": currentCustomer});

    for (var item in response["data"]) {
      Product current = Product(
          cusSNo: item['CusSNo'],
          dateInOut: item['DateInOut'] ?? "",
          cusName: item['CusName'] ?? "",
          cloth: item['Cloth'] ?? "",
          thNo: item['ThNo'] ?? "",
          inchNo: item['InchNo'] ?? "",
          rawSupp: item['RawSupp'] ?? "",
          rollIncome: item['RollIncome'] ?? "",
          rawIncome: item['RawIncome'] ?? "",
          rawWt: int.parse(item['RawWt'].toString()));
      productList.add(current);
    }
    return productList;
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Product> productList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value,
          textDirection: TextDirection.rtl,
          overflow: TextOverflow.visible,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          row.getCells()[1].value.substring(0, 11),
          overflow: TextOverflow.visible,
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value,
          textDirection: TextDirection.rtl,
          overflow: TextOverflow.visible,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value,
          textDirection: TextDirection.rtl,
          overflow: TextOverflow.visible,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            row.getCells()[4].value,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            row.getCells()[5].value,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            row.getCells()[6].value,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            row.getCells()[7].value,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            row.getCells()[8].value,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(
            row.getCells()[9].value,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'CusSNo', value: dataGridRow.cusSNo),
        DataGridCell<String>(
            columnName: 'DateInOut', value: dataGridRow.dateInOut),
        DataGridCell<String>(columnName: 'CusName', value: dataGridRow.cusName),
        DataGridCell<String>(columnName: 'Cloth', value: dataGridRow.cloth),
        DataGridCell<String>(columnName: 'ThNo', value: dataGridRow.thNo),
        DataGridCell<String>(columnName: 'InchNo', value: dataGridRow.inchNo),
        DataGridCell<String>(columnName: 'RawSupp', value: dataGridRow.rawSupp),
        DataGridCell<String>(
            columnName: 'RollIncome', value: dataGridRow.rollIncome),
        DataGridCell<String>(
            columnName: 'RawIncome', value: dataGridRow.rawIncome),
        DataGridCell<String>(
            columnName: 'RawWt', value: dataGridRow.rawWt.toString()),
      ]);
    }).toList(growable: false);
  }
}

class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        cusSNo: json["CusSNo"],
        dateInOut: json["DateInOut"],
        cusName: json["CusName"],
        cloth: json["Cloth"],
        thNo: json["ThNo"],
        inchNo: json["InchNo"],
        rawSupp: json["RawSupp"],
        rollIncome: json["RollIncome"],
        rawIncome: json["RawIncome"],
        rawWt: int.parse(json["RawWt"]));
  }
  Product({
    required this.cusSNo,
    required this.dateInOut,
    required this.cusName,
    required this.cloth,
    required this.thNo,
    required this.inchNo,
    required this.rollIncome,
    required this.rawSupp,
    required this.rawIncome,
    required this.rawWt,
  });

  final String cusSNo;
  final String dateInOut;
  final String cusName;
  final String cloth;
  final String thNo;
  final String inchNo;
  final String rollIncome;
  final String rawSupp;
  final String rawIncome;
  final int rawWt;
}
