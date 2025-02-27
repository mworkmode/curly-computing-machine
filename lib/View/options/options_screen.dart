import 'package:crypto_app/View/options/options_controller.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
// import 'dart:math' as math;

import 'package:get/get.dart';

class OptionsScreen extends StatelessWidget {
  OptionsScreen({super.key});

  final OptionsController optionsController = Get.find();
  // late DessertDataSource _dessertsDataSource;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColor.black.withOpacity(0.8),
                AppColor.black.withOpacity(0.6),
                AppColor.black.withOpacity(0.4),
                AppColor.kAppPrimary,
              ]
            )
          ),
          //https://padymies.medium.com/flutter-bidirectional-scroll-datatable-57e24c2fae8e
          child: Container(
            margin: const EdgeInsets.only(top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
            decoration: const BoxDecoration(
              color: Color(0xff363636),
              borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
            ),
            child: getDataTable(),
            // child: DataTable2(
            //     columnSpacing: 12,
            //     horizontalMargin: 12,
            //     minWidth: 600,
            //     columns: const [
            //       DataColumn2(
            //         label: Text('Column A'),
            //         size: ColumnSize.L,
            //       ),
            //       DataColumn(
            //         label: Text('Column B'),
            //       ),
            //       DataColumn(
            //         label: Text('Column C'),
            //       ),
            //       DataColumn(
            //         label: Text('Column D'),
            //       ),
            //       DataColumn(
            //         label: Text('Column NUMBERS'),
            //         numeric: true,
            //       ),
            //     ],
            //     rows: List<DataRow>.generate(
            //         100,
            //             (index) => DataRow(cells: [
            //           DataCell(Text('A' * (10 - index % 10))),
            //           DataCell(Text('B' * (10 - (index + 5) % 10))),
            //           DataCell(Text('C' * (15 - (index + 5) % 10))),
            //           DataCell(Text('D' * (15 - (index + 10) % 10))),
            //           DataCell(Text(((index + 0.1) * 25.4).toString()))
            //         ]))),
          ),
        )
      ),
    );
  }

  DataTable2 getDataTable() {
    return DataTable2(
        dividerThickness: 1,
        scrollController: _controller,
        columnSpacing: 0,
        horizontalMargin: 8,
        bottomMargin: 0,
        border: TableBorder.all(width: 1.0, color: const Color(0xff3f3e41)),
        headingRowColor: WidgetStateProperty.resolveWith(
                (states) => 1 > 0 ? Colors.grey[200] : Colors.transparent),
        headingRowDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff373042),
              Color(0xff262628),
              // Colors.grey[200]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        fixedColumnsColor: const Color(0xff434246),
        fixedCornerColor: Colors.grey[400],
        minWidth: 600,
        fixedTopRows: 1,
        fixedLeftColumns: 1,
        // sortColumnIndex: _sortColumnIndex,
        // sortAscending: _sortAscending,
        // onSelectAll: (val) => setState(() => selectAll(val)),
        columns: const [
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Name',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            // onSort: (columnIndex, ascending) =>
            //     _sort<String>((d) => d.name, columnIndex, ascending),
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Price',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
            // onSort: (columnIndex, ascending) =>
            //     _sort<num>((d) => d.calories, columnIndex, ascending),
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('High',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
            // onSort: (columnIndex, ascending) =>
            //     _sort<num>((d) => d.fat, columnIndex, ascending),
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Low',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
            // onSort: (columnIndex, ascending) =>
            //     _sort<num>((d) => d.carbs, columnIndex, ascending),
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Change',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
            // onSort: (columnIndex, ascending) =>
            //     _sort<num>((d) => d.protein, columnIndex, ascending),
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Change%',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
            // onSort: (columnIndex, ascending) =>
            //     _sort<num>((d) => d.sodium, columnIndex, ascending),
          ),
          // DataColumn2(
          //   label: Text('Calcium (%)'),
          //   size: ColumnSize.S,
          //   numeric: true,
          //   // onSort: (columnIndex, ascending) =>
          //   //     _sort<num>((d) => d.calcium, columnIndex, ascending),
          // ),
          // DataColumn2(
          //   label: Text('Iron (%)'),
          //   size: ColumnSize.S,
          //   numeric: true,
          //   // onSort: (columnIndex, ascending) =>
          //   //     _sort<num>((d) => d.iron, columnIndex, ascending),
          // ),
        ],
        rows: List<DataRow>.generate(
            optionsController.coinMarket?.length ?? 0 , (index) => _getRow(index, Colors.transparent)));
  }

  DataRow _getRow(int index, [Color? color]) {
    // final format = NumberFormat.decimalPercentPattern(
    //   locale: 'en',
    //   decimalDigits: 0,
    // );
    assert(index >= 0);
    if (index >= optionsController.coinMarket!.length) throw 'index > _desserts.length';
    final dessert = optionsController.coinMarket![index];
    return DataRow2.byIndex(
      index: index,
      // selected: dessert.selected,
      color: color != null ? WidgetStateProperty.all(color) : null,
      // onSelectChanged: (value) {
      //   if (dessert.selected != value) {
      //     dessert.selected = value!;
      //     setState(() {});
      //   }
      // },
      cells: [
        DataCell(Text(dessert.name,style: const TextStyle(color: Color(0xfff0f0f0),fontWeight: FontWeight.w900),),),
        DataCell(Text('${dessert.currentPrice}',style: const TextStyle(color: Colors.white))),
        DataCell(Text(dessert.high24H.toStringAsFixed(1),style: const TextStyle(color: Colors.white))),
        DataCell(Text('${dessert.low24H}',style: const TextStyle(color: Colors.white))),
        DataCell(Text(dessert.priceChange24H.toStringAsFixed(1),style: TextStyle(color:
        dessert.priceChange24H > 0 ? Colors.green : Colors.red))),
        DataCell(Text(dessert.marketCapChangePercentage24H.toStringAsFixed(2),style: TextStyle(color:
        dessert.marketCapChangePercentage24H > 0 ? Colors.green : Colors.red))),
        // DataCell(Text(format.format(dessert.calcium / 100))),
        // DataCell(Text(format.format(dessert.iron / 100))),
      ],
    );
  }
}
