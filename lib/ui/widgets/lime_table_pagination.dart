import 'package:flutter/material.dart';
import 'package:sales_engine/ui/widgets/lime_table.dart';

// ignore: must_be_immutable
class DataTableWithPaginationWidget extends StatelessWidget {
  final List<dynamic> sortedData;
  final int rowsPerPage;
  late int sortColumnIndex = 0;
  late bool sortAscending = true;
  final dynamic onRowsPerPageChanged;

  DataTableWithPaginationWidget(
      {Key? key,
      required this.sortedData,
      required this.sortAscending,
      required this.sortColumnIndex,
      required this.rowsPerPage,
      required this.onRowsPerPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      rowsPerPage: rowsPerPage,
      onRowsPerPageChanged: (value) {
        onRowsPerPageChanged(value);
      },
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      source: MyDataSource(sortedData),
      columns: const [
        DataColumn(label: Text('Distance')),
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('latitude')),
        DataColumn(label: Text('longitude')),
        DataColumn(label: Text('Address')),
        DataColumn(label: Text('Structural Score')),
        DataColumn(label: Text('Hygiene Score')),
        DataColumn(label: Text('Confidence In Management Score')),
        DataColumn(label: Text('Rating Value')),
        DataColumn(label: Text('Business Type')),
        DataColumn(label: Text('Local Authority')),
      ],
    );
  }
}
