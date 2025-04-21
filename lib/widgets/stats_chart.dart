import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../models/stats_data.dart';
import 'dart:math' as math;

class StatsChart extends StatelessWidget {
  final StatsData data;
  final String timeframe;

  const StatsChart({
    Key? key,
    required this.data,
    required this.timeframe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: data.maxValue / 4,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.15),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.15),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: timeframe == 'month' ? 5 : 1,
              getTitlesWidget: (value, meta) {
                if (value % 1 != 0) return const Text('');
                final index = value.toInt();
                if (index < 0 || index >= data.data.length) return const Text('');
                
                String label = '';
                switch (timeframe) {
                  case 'day':
                    label = '${index}';
                    break;
                  case 'week':
                    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                    label = days[index % 7];
                    break;
                  case 'month':
                    label = '${index + 1}';
                    break;
                }
                
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: data.data.asMap().entries.map((entry) {
              return FlSpot(
                entry.key.toDouble(),
                entry.value['value'].toDouble(),
              );
            }).toList(),
            isCurved: true,
            color: primaryColor,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: primaryColor,
                  strokeWidth: 1,
                  strokeColor: primaryColor,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: primaryColor.withOpacity(0.1),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor.withOpacity(0.2),
                  primaryColor.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ],
        minY: 0,
        maxY: data.maxValue * 1.2,
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.grey[800]!,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  spot.y.toStringAsFixed(0),
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
} 