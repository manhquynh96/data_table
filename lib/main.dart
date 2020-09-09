import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataTableDemo(),
    );
  }
}

class DataTableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Table Demo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          PaginatedDataTable(
            header: Text('Tên Bảng'),
            columns: [
              DataColumn(label: Text('Tiêu đề 1')),
              DataColumn(label: Text('Tiêu đề 2')),
              DataColumn(label: Text('Tiêu đề 3')),
              DataColumn(label: Text('Tiêu đề 4')),
            ],
            source: _DataSource(context),
            rowsPerPage: 4,
          ),
        ],
      ),
    );
  }
}

class _Row {
  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;

  bool selected = false;

  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
  );
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('Cell 1', 'Cell 1', 'Cell 1', 1),
      _Row('Cell 2', 'Cell 2', 'Cell 2', 2),
      _Row('Cell 3', 'Cell 3', 'Cell 3', 3),
      _Row('Cell 4', 'Cell 4', 'Cell 4', 4),
    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) {
      return null;
    }
    final row = _rows[index];
    return DataRow.byIndex(
        index: index,
        selected: row.selected,
        onSelectChanged: (value) {
          if (row.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            row.selected = value;
            notifyListeners();
          }
        },
        cells: [
          DataCell(Text(row.valueA)),
          DataCell(Text(row.valueB)),
          DataCell(Text(row.valueC)),
          DataCell(Text(row.valueD.toString())),
        ]);
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
