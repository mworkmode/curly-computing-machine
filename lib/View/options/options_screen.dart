import 'package:crypto_app/View/options/options_controller.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
// import 'dart:math' as math;

import 'package:get/get.dart';

class OptionsScreen extends StatelessWidget {
  OptionsScreen({super.key});

  final OptionsController optionsController = Get.find();
  final ScrollController _controller = ScrollController();
  static const darkBg = Color(0xFF121212);
  static const cardColor = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
          decoration: const BoxDecoration(
            color: darkBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
          ),
          child: getDataTable(),
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
          color: cardColor,
        ),
        fixedColumnsColor: cardColor.withValues(alpha: 0.8),
        fixedCornerColor: Colors.grey[400],
        minWidth: 600,
        fixedTopRows: 1,
        fixedLeftColumns: 1,
        columns: const [
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Name',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Price',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('High',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Low',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Change',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
          ),
          DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Change%',style: TextStyle(color: Color(0xffe4e4e4),fontWeight: FontWeight.bold,fontSize: 16),),
            size: ColumnSize.S,
            numeric: true,
          ),
        ],
        rows: List<DataRow>.generate(
            optionsController.coinMarket?.length ?? 0 , (index) => _getRow(index, Colors.transparent)));
  }

  DataRow _getRow(int index, [Color? color]) {
    assert(index >= 0);
    if (index >= optionsController.coinMarket!.length) throw 'index > _desserts.length';
    final dessert = optionsController.coinMarket![index];
    return DataRow2.byIndex(
      index: index,
      color: color != null ? WidgetStateProperty.all(color) : null,
      cells: [
        DataCell(Text(dessert.name,style: const TextStyle(color: Color(0xfff0f0f0),fontWeight: FontWeight.w900),),),
        DataCell(Text('${dessert.currentPrice}',style: const TextStyle(color: Colors.white))),
        DataCell(Text(dessert.high24H.toStringAsFixed(1),style: const TextStyle(color: Colors.white))),
        DataCell(Text('${dessert.low24H}',style: const TextStyle(color: Colors.white))),
        DataCell(Text(dessert.priceChange24H.toStringAsFixed(1),style: TextStyle(color:
        dessert.priceChange24H > 0 ? Colors.green : Colors.red))),
        DataCell(Text(dessert.marketCapChangePercentage24H.toStringAsFixed(2),style: TextStyle(color:
        dessert.marketCapChangePercentage24H > 0 ? Colors.green : Colors.red))),
      ],
    );
  }
}
