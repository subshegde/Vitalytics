import 'dart:convert';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/get_image_state.dart';
import 'cubit/get_images_cubit.dart';
import 'cubit/progress_cubit.dart';
import 'cubit/progress_state.dart';

class FullProgressScreen extends StatelessWidget {
  final int userId;
  final String base64Image;

  const FullProgressScreen({
    super.key,
    required this.userId,
    required this.base64Image,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProgressSummaryCubit()..fetchProgressSummary(userId, base64Image),
        ),
        BlocProvider(
          create: (_) => ProgressImagesCubit()..fetchProgressImages(userId),
        ),
      ],

      child: Scaffold(
        backgroundColor: const Color(0xFF0D1F17),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Full Progress",
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================================
              // 🟢 PROGRESSION SUMMARY
              // ================================
              BlocBuilder<ProgressSummaryCubit, ProgressSummaryState>(
                builder: (context, state) {
                  if (state is ProgressSummaryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    );
                  }

                  if (state is ProgressSummaryError) {
                    return Text(
                      "Error: ${state.message}",
                      style: const TextStyle(color: Colors.redAccent),
                    );
                  }

                  if (state is ProgressSummaryLoaded) {
                    final summary = state.summary;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _title("Overall Change"),
                        _card(summary.overallChange),

                        const SizedBox(height: 20),

                        _title("Metrics Tracked"),
                        _metrics(summary.metricsTracked),

                        const SizedBox(height: 20),

                        _title("Visual Notes"),
                        _card(summary.visualNotes),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 32),

              // ================================
              // 🔵 IMAGES + CONFIDENCE GRAPH
              // ================================
              BlocBuilder<ProgressImagesCubit, ProgressImagesState>(
                builder: (context, state) {
                  if (state is ProgressImagesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    );
                  }

                  if (state is ProgressImagesError) {
                    return Text(
                      "Image Error: ${state.message}",
                      style: const TextStyle(color: Colors.redAccent),
                    );
                  }

                  if (state is ProgressImagesLoaded) {
                    final list = state.data.images;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _title("Progress Images"),
                        const SizedBox(height: 10),

                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: list.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),

                            itemBuilder: (_, index) {
                              // SAFE BASE64 CLEANING
                              final raw = list[index].base64Image.trim();
                              final clean = raw.contains(',')
                                  ? raw.split(',').last
                                  : raw;

                              Uint8List bytes;

                              try {
                                bytes = base64Decode(clean);
                              } catch (_) {
                                return Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.red.withOpacity(0.2),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.error,
                                    color: Colors.redAccent,
                                  ),
                                );
                              }

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.memory(
                                  bytes,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        _title("Confidence Score Trend"),
                        const SizedBox(height: 10),

                        _confidenceGraph(list),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Section Title
  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.greenAccent,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // 🔹 Simple Card
  Widget _card(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16261E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade900),
      ),
      child: Text(
        text.isEmpty ? "No data available." : text,
        style: const TextStyle(color: Colors.white70, height: 1.4),
      ),
    );
  }

  // 🔹 Metrics List (Strong typed)
  Widget _metrics(List metrics) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16261E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade900),
      ),
      child: Column(
        children: metrics.map((m) {
          final percent = (m.confidenceScore * 100).toInt();

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.metricName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  m.changeDescription,
                  style: const TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 8),

                LinearProgressIndicator(
                  value: m.confidenceScore,
                  backgroundColor: Colors.white12,
                  color: Colors.greenAccent,
                ),

                const SizedBox(height: 4),

                Text(
                  "$percent%",
                  style: const TextStyle(color: Colors.greenAccent),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // 🔹 Confidence Graph
  Widget _confidenceGraph(List images) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF16261E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade900),
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 1,

          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.greenAccent,
              barWidth: 3,
              dotData: FlDotData(show: true),
              spots: List.generate(
                images.length,
                (i) => FlSpot(i.toDouble(), images[i].confidenceScore),
              ),
            ),
          ],

          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) => Text(
                  "${(value * 100).toInt()}%",
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= images.length) {
                    return const SizedBox();
                  }
                  return Text(
                    "Img ${index + 1}",
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
