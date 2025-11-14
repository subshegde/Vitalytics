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
          title: const Text("Full Progress",
              style: TextStyle(color: Colors.white)),
        ),

        body: Stack(
          children: [
            _mainContent(),
            _globalLoader(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SINGLE GLOBAL LOADER
  // ============================================================

  Widget _globalLoader() {
    return BlocBuilder<ProgressSummaryCubit, ProgressSummaryState>(
      builder: (context, summaryState) {
        return BlocBuilder<ProgressImagesCubit, ProgressImagesState>(
          builder: (context, imagesState) {
            final isLoading =
                summaryState is ProgressSummaryLoading ||
                    imagesState is ProgressImagesLoading;

            if (isLoading) {
              return Container(
                color: Colors.black.withOpacity(0.6),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                    strokeWidth: 4,
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  // ============================================================
  // MAIN CONTENT (ONLY AFTER BOTH LOAD SUCCESS)
  // ============================================================

  Widget _mainContent() {
    return BlocBuilder<ProgressSummaryCubit, ProgressSummaryState>(
      builder: (context, summaryState) {
        return BlocBuilder<ProgressImagesCubit, ProgressImagesState>(
          builder: (context, imagesState) {
            // ERRORS
            if (summaryState is ProgressSummaryError) {
              return _error("Summary Error: ${summaryState.message}");
            }
            if (imagesState is ProgressImagesError) {
              return _error("Images Error: ${imagesState.message}");
            }

            // If either is still idle/loading → hide UI
            if (summaryState is! ProgressSummaryLoaded ||
                imagesState is! ProgressImagesLoaded) {
              return const SizedBox.shrink();
            }

            final summary = summaryState.summary;
            final images = imagesState.data.images;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// SUMMARY
                  _title("Overall Change"),
                  _card(summary.overallChange),

                  const SizedBox(height: 20),

                  _title("Metrics Tracked"),
                  _metrics(summary.metricsTracked),

                  const SizedBox(height: 20),

                  _title("Visual Notes"),
                  _card(summary.visualNotes),

                  const SizedBox(height: 30),

                  /// IMAGES
                  _title("Progress Images"),
                  const SizedBox(height: 10),
                  _progressImages(images),

                  const SizedBox(height: 30),

                  /// GRAPH
                  _title("Confidence Score Trend"),
                  const SizedBox(height: 10),
                  _confidenceGraph(images),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // ERROR UI
  // ============================================================

  Widget _error(String msg) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          msg,
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

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

  // ============================================================
  // SIMPLE CARD
  // ============================================================

  Widget _card(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _box(),
      child: Text(
        text.isEmpty ? "No data available." : text,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }

  BoxDecoration _box() {
    return BoxDecoration(
      color: const Color(0xFF16261E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade900),
    );
  }

  // ============================================================
  // METRICS
  // ============================================================

  Widget _metrics(List metrics) {
    if (metrics.isEmpty) {
      return _card("No metrics found.");
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _box(),
      child: Column(
        children: metrics.map((m) {
          final percent = ((m.confidenceScore ?? 0) * 100).toInt();

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.metricName ?? "Unknown Metric",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  m.changeDescription ?? "No description",
                  style: const TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 8),

                LinearProgressIndicator(
                  value: (m.confidenceScore ?? 0).toDouble(),
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

  // ============================================================
  // IMAGES
  // ============================================================

  Widget _progressImages(List images) {
    if (images.isEmpty) {
      return _card("No progress images found.");
    }

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),

        itemBuilder: (_, index) {
          final raw = images[index].base64Image?.trim() ?? "";

          if (raw.isEmpty) {
            return _brokenImage();
          }

          final clean = raw.contains(',')
              ? raw.split(',').last
              : raw;

          Uint8List bytes;

          try {
            bytes = base64Decode(clean);
          } catch (_) {
            return _brokenImage();
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.memory(
              bytes,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _brokenImage(),
            ),
          );
        },
      ),
    );
  }

  Widget _brokenImage() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.red.withOpacity(0.25),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, color: Colors.redAccent),
    );
  }

  // ============================================================
  // GRAPH
  // ============================================================

  Widget _confidenceGraph(List images) {
    if (images.isEmpty) {
      return _card("No graph data available.");
    }

    final spots = <FlSpot>[];

    for (int i = 0; i < images.length; i++) {
      final score = images[i].confidenceScore ?? 0.0;
      spots.add(FlSpot(i.toDouble(), score));
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: _box(),
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
              spots: spots,
            ),
          ],

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, _) =>
                    Text("${(value * 100).toInt()}%",
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  int index = value.toInt();
                  if (index < 0 || index >= images.length) {
                    return const SizedBox();
                  }
                  return Text("Img ${index + 1}",
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12));
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
}
