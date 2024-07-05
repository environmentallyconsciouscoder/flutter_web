import 'package:flutter/material.dart';

class MyDataSource extends DataTableSource {
  final List<dynamic> data;

  MyDataSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final object = data[index];
    return DataRow(cells: [
      DataCell(Text(object?.distance?.toStringAsFixed(2) ?? '')),
      DataCell(Text(object?.id?.toString() ?? '')),
      DataCell(Text(object?.name?.toString() ?? '')),
      DataCell(Text(object?.latitude?.toString() ?? '')),
      DataCell(Text(object?.longitude?.toString() ?? '')),
      DataCell(Text('${object?.addressLineOne ?? ''} '
          ' ${object?.addressLineTwo ?? ''} '
          ' ${object?.addressLineThree ?? ''} '
          ' ${object?.addressLineFour ?? ''} '
          ' ${object?.postCode ?? ''}')),
      DataCell(Text(object?.structuralScore?.toString() ?? '')),
      DataCell(Text(object?.hygieneScore?.toString() ?? '')),
      DataCell(Text(object?.confidenceInManagementScore?.toString() ?? '')),
      DataCell(Text(object?.ratingValue?.toString() ?? '')),
      DataCell(Text(object?.businessType?.toString() ?? '')),
      DataCell(Text(object?.localAuthority?.toString() ?? '')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
