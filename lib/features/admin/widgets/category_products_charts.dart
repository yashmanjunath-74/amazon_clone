import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart' as fi;
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData;
  const CategoryProductsChart({
    Key? key,
    required this.salesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Category Products Earnings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: fi.BarChart(
            fi.BarChartData(
              barGroups: salesData.map((sales) {
                return fi.BarChartGroupData(
                  x: sales.label.hashCode,
                  barRods: [
                    fi.BarChartRodData(
                      toY: sales.earnings.toDouble(),
                      color: Colors.blue,
                      width: 20, // Set the bar width
                      borderRadius: BorderRadius.circular(5), // Rounded bars
                    ),
                  ],
                );
              }).toList(),
              titlesData: fi.FlTitlesData(
                leftTitles: fi.AxisTitles(
                  sideTitles: fi.SideTitles(
                    showTitles: true,
                    interval: 700, // Set the y-axis interval to 700 units
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '₹${value.toInt()}', // Use rupee symbol
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: fi.AxisTitles(
                  sideTitles: fi.SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final sales = salesData.firstWhere(
                          (sales) => sales.label.hashCode == value.toInt());
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          sales.label,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: fi.FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return fi.FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return fi.FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  );
                },
              ),
              borderData: fi.FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
