import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vitalytics/data/models/full_summary/full_summary.dart';
import 'package:vitalytics/presentation/summary/cubit/summary_cubit.dart';
import 'package:vitalytics/presentation/summary/cubit/summary_state.dart';

class FullSummaryScreen extends StatelessWidget {
  final String userId;
  final String query;

  const FullSummaryScreen({
    super.key,
    required this.userId,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FullSummaryCubit()..fetchSummary(userId, query),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Full Summary Report"),
          actions: [
            BlocBuilder<FullSummaryCubit, FullSummaryState>(
              builder: (context, state) {
                if (state is FullSummaryLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.picture_as_pdf),
                    onPressed: () {
                      exportSummaryPdf(state.summary);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        body: BlocBuilder<FullSummaryCubit, FullSummaryState>(
          builder: (context, state) {
            if (state is FullSummaryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FullSummaryError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is FullSummaryLoaded) {
              return _buildSummaryView(state.summary);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildSummaryView(FullSummary summary) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tile("Analysis Date", summary.analysisDate),
          _tile("Overall Status", summary.overallStatus),

          const SizedBox(height: 20),
          const Text("Key Metrics", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          _tile("Diet Score", summary.keyMetrics?.dietScore.toString()),
          _tile("Progression Trend", summary.keyMetrics?.progressionTrend),

          const SizedBox(height: 20),
          const Text("Sections", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          ...summary.sections!.map((s) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.sectionTitle ?? "",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(s.briefSummary ?? ""),
                        const SizedBox(height: 8),
                        Text("Recommendation: ${s.recommendation}"),
                      ]),
                ),
              ))
        ],
      ),
    );
  }

  Widget _tile(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? "-")),
        ],
      ),
    );
  }
}


Future<void> exportSummaryPdf(FullSummary summary) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Header(
          level: 0,
          child: pw.Text("Full Summary Report", style: pw.TextStyle(fontSize: 22)),
        ),

        pw.Text("📅 Analysis Date: ${summary.analysisDate ?? "-"}"),
        pw.Text("Status: ${summary.overallStatus ?? "-"}"),

        pw.SizedBox(height: 20),

        pw.Text("Key Metrics", style: pw.TextStyle(fontSize: 18)),
        pw.Table.fromTextArray(
          headers: ["Diet Score", "Progression Trend"],
          data: [
            [
              summary.keyMetrics?.dietScore.toString() ?? "-",
              summary.keyMetrics?.progressionTrend ?? "-"
            ]
          ],
        ),

        pw.SizedBox(height: 25),
        pw.Text("Sections", style: pw.TextStyle(fontSize: 18)),
        pw.SizedBox(height: 10),

        pw.Table.fromTextArray(
          headers: ["Title", "Summary", "Recommendation"],
          data: summary.sections?.map((s) {
            return [
              s.sectionTitle ?? "-",
              s.briefSummary ?? "-",
              s.recommendation ?? "-"
            ];
          }).toList() ?? [],
        ),
      ],
    ),
  );

  await Printing.layoutPdf(onLayout: (_) => pdf.save());
}
