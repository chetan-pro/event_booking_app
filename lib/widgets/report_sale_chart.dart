// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Line chart example
import 'dart:convert';

import 'package:basalon/services/my_color.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate = false});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData(sales) {
    return new PointsLineChart(
      _createSampleData(sales),
      // Disable animations for image tests.
      // animate: true,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  // factory PointsLineChart.withRandomData() {
  //   return new PointsLineChart(_createRandomData());
  // }

  /// Create random data.
  // static List<charts.Series<LinearSales, num>> _createRandomData() {
  //   final random = new Random();
  //
  //   final data = [
  //     new LinearSales(0, random.nextInt(100)),
  //     new LinearSales(1, random.nextInt(100)),
  //     new LinearSales(2, random.nextInt(100)),
  //     new LinearSales(3, random.nextInt(100)),
  //     new LinearSales(4, random.nextInt(100)),
  //   ];
  //
  //   return [
  //     new charts.Series<LinearSales, int>(
  //       id: 'Sales',
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //       domainFn: (LinearSales sales, _) => sales.year,
  //       measureFn: (LinearSales sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }

  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
        roundEndCaps: true,
        radiusPx: 10,
        stacked: true,
        // includeArea: true,
      ),
      rtlSpec: RTLSpec(axisDirection: charts.AxisDirection.normal),
      selectionModels: [
        new charts.SelectionModelConfig(
            changedListener: (SelectionModel model) {
          print(
              model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
        })
      ],
      behaviors: [
        charts.ChartTitle('Sales Report',
            // subTitle: 'Top sub-title text',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18),
        charts.ChartTitle('Time',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Total Sales',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        // new charts.ChartTitle('End title',
        //     behaviorPosition: charts.BehaviorPosition.end,
        //     titleOutsideJustification:
        //         charts.OutsideJustification.middleDrawArea),
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData(sales) {
    List<LinearSales> data = [
      // LinearSales(1648771200000, 0),
      // LinearSales(1648857600000, 0),
      // LinearSales(1648944000000, 0),
      // LinearSales(1649030400000, 0),
      // LinearSales(1649116800000, 0),
      // LinearSales(1649203200000, 0),
      // LinearSales(1649289600000, 0),
      // LinearSales(1649376000000, 0),
      // LinearSales(1649462400000, 0),
      // LinearSales(1649548800000, 0),
      // LinearSales(1649635200000, 0),
      // LinearSales(1649721600000, 0),
    ];

    final data1 = [];

    var x = jsonDecode(sales.chart).first;
    if (sales.chart != null) {
      for (var i = 0; i < x.length; i++) {
        data.add(LinearSales(i, x[i][1]));
      }
    }

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(MyColors.topOrange),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        areaColorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.white,
        patternColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.green),
        radiusPxFn: (_, __) => 7,
        outsideLabelStyleAccessorFn: (_, __) => charts.TextStyleSpec(
            lineHeight: 10,
            color: charts.ColorUtil.fromDartColor(Colors.green)),
        fillPatternFn: (_, __) => charts.FillPatternType.forwardHatch,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
