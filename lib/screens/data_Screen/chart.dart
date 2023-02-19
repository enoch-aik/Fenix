import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../onboarding/constants.dart';

class LineGraph extends StatefulWidget {
  const LineGraph({Key? key}) : super(key: key);

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Stack(
        children: [
          LineChart(
            mainData(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,8,0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 30),
              Text('Fenix Auction Store',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Colors.blueGrey.withOpacity(0.7))),
              SizedBox(height: 12),  Text('Kelajak Sari Birinchi Qadam',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200,color: Colors.blueGrey.withOpacity(0.7))),
              const Text('Developed by Akmalov.Kh',
                  style: TextStyle(fontSize: 8)),
            ],),
          )
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.w300,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('8:00', style: style);
        break;
      case 4:
        text = const Text('12:00', style: style);
        break;
      case 6:
        text = const Text('16:00', style: style);
        break;
      case 8:
        text = const Text('20:00', style: style);
        break;
      case 10:
        text = const Text('22:00', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.w300,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '';
        break;
      case 3:
        text = '';
        break;
      case 5:
        text = '';
        break;
      case 7:
        text = '';
        break;
      case 9:
        text = '';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 7,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 0,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 1.50),
            FlSpot(1.4, 2.00),
            FlSpot(2.6, 2.60),
            FlSpot(3.6, 3.00),
            FlSpot(4.9, 2.82),
            FlSpot(8, 2.44),
            FlSpot(9.5, 5.00),
            FlSpot(11, 5.10),
          ],
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.1),
              ],
            ),
            color: Colors.white.withOpacity(0.4),
          ),
          isCurved: true,
          color: Colors.blue,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
