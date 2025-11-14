import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'cubit/progress_cubit.dart';
import 'cubit/progress_state.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with TickerProviderStateMixin {
  late TabController _viewTabController;

  @override
  void initState() {
    super.initState();

    _viewTabController = TabController(length: 2, vsync: this);

    _viewTabController.addListener(() {
      final cubit = context.read<ProgressCubit>();

      if (_viewTabController.index == 0) {
        cubit.switchView(true); // Timeline
      } else {
        cubit.switchView(false); // Graph
      }
    });
  }

  @override
  void dispose() {
    _viewTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProgressCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1F17),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "My Progress",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),

        body: BlocBuilder<ProgressCubit, ProgressState>(
          builder: (context, state) {
            if (state is ProgressLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = state as ProgressLoaded;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Eczema - Left Arm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      buildRangeChip(context, "1W", "7", data),
                      buildRangeChip(context, "1M", "30", data),
                      buildRangeChip(context, "6M", "180", data),
                      buildRangeChip(context, "All", "9999", data),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // TAB BAR (Timeline / Graph)
                  Container(
                    height: kToolbarHeight + 3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green.shade800),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TabBar(
                      controller: _viewTabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      padding: const EdgeInsets.all(4),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.shade800,
                      ),
                      labelStyle: Theme.of(context).textTheme.titleMedium,
                      unselectedLabelStyle: Theme.of(
                        context,
                      ).textTheme.titleMedium,
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.timeline, size: 20),
                          text: "Timeline",
                        ),
                        Tab(
                          icon: Icon(Icons.show_chart, size: 20),
                          text: "Graph",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CONTENT BASED ON TAB
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: _viewTabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        buildTimelineView(data),
                        buildGraphView(context, data),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildGraphView(BuildContext context, ProgressLoaded data) {
  final sorted = [...data.filteredEntries]
    ..sort((a, b) => a.date.compareTo(b.date));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF16261E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Metric:", style: TextStyle(color: Colors.white)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Severity",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                buildRangeChip(context, "1W", "7", data),
                buildRangeChip(context, "1M", "30", data),
                buildRangeChip(context, "6M", "180", data),
                buildRangeChip(context, "All", "9999", data),
              ],
            ),

            const SizedBox(height: 20),

            // GRAPH
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 10,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(color: Colors.white54),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < 0 || index >= sorted.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            DateFormat("MMM d").format(sorted[index].date),
                            style: const TextStyle(color: Colors.white54),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.green,
                      dotData: FlDotData(show: true),
                      barWidth: 3,
                      spots: List.generate(
                        sorted.length,
                        (i) =>
                            FlSpot(i.toDouble(), sorted[i].severity.toDouble()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      buildPhotoLogSection(data),
    ],
  );
}

Widget buildRangeChip(
  BuildContext context,
  String label,
  String days,
  ProgressLoaded data,
) {
  bool selected = data.selectedRange == days;

  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: GestureDetector(
      onTap: () => context.read<ProgressCubit>().filterRange(days),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.green.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    ),
  );
}

Widget buildPhotoLogSection(ProgressLoaded data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Photo Log",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 12),

      SizedBox(
        height: 150,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: data.filteredEntries.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final entry = data.filteredEntries[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    entry.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        width: 150,

                        color: Colors.green.shade900,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white70,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  DateFormat("MMM dd").format(entry.date),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}

Widget buildTimelineView(ProgressLoaded data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildPhotoLogSection(data),
      const SizedBox(height: 20),

      Column(
        children: data.filteredEntries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chat, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Severity: ${entry.severity}/10",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat("MMM dd, yyyy").format(entry.date),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.notes,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ],
  );
}
