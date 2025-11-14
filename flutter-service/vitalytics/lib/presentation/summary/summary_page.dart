import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vitalytics/core/constants/app_colors.dart';
import 'package:vitalytics/data/models/full_summary/full_summary.dart';
import 'package:vitalytics/presentation/summary/cubit/summary_cubit.dart';
import 'package:vitalytics/presentation/summary/cubit/summary_state.dart';

// IMPORT YOUR THEME

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
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primeGreen900,
          title: Text(
            "Full Summary Report",
            style: const TextStyle(color: primeText),
          ),
          iconTheme: const IconThemeData(color: primeText),
          actions: [
            BlocBuilder<FullSummaryCubit, FullSummaryState>(
              builder: (context, state) {
                if (state is FullSummaryLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.picture_as_pdf, color: primeAccent),
                    onPressed: () {
                      exportSummaryPdf(context, state.summary);
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
              return const Center(child: CircularProgressIndicator(color: primeAccent));
            } else if (state is FullSummaryError) {
              return Center(
                child: Text("Error: ${state.message}", style: const TextStyle(color: primeText)),
              );
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

          const Text(
            "Key Metrics",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primeAccent),
          ),
          const SizedBox(height: 8),
          _tile("Diet Score", summary.keyMetrics?.dietScore.toString()),
          _tile("Progression Trend", summary.keyMetrics?.progressionTrend),

          const SizedBox(height: 20),
          const Text(
            "Sections",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primeAccent),
          ),
          const SizedBox(height: 10),

          ...summary.sections!.map(
            (s) => Card(
              color: cardColor,
              shadowColor: primeGreen900,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.sectionTitle ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: primeText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      s.briefSummary ?? "",
                      style: const TextStyle(color: primeTextDim),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Recommendation: ${s.recommendation}",
                      style: const TextStyle(color: accentColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primeAccent,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: const TextStyle(color: primeText),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> exportSummaryPdf(BuildContext context, FullSummary summary) async {
  final robotoRegular = pw.Font.ttf(
    await rootBundle.load("assets/fonts/Roboto-Regular.ttf"),
  );
  final robotoBold = pw.Font.ttf(
    await rootBundle.load("assets/fonts/Roboto-Bold.ttf"),
  );

  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      theme: pw.ThemeData.withFont(
        base: robotoRegular,
        bold: robotoBold,
      ),
      build: (context) => [
        pw.Header(
          level: 0,
          child:
              pw.Text("Full Summary Report", style: pw.TextStyle(fontSize: 22)),
        ),

        pw.Text("Analysis Date: ${summary.analysisDate ?? "-"}"),
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
              }).toList() ??
              [],
        ),
      ],
    ),
  );

  if (kIsWeb || !Platform.isAndroid && !Platform.isIOS) {
    // DESKTOP or WEB → Save PDF to file
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/summary_report.pdf");
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF saved at: ${file.path}")),
    );
  } else {
    // MOBILE → Use Printing plugin
    await Printing.layoutPdf(onLayout: (_) => pdf.save());
  }
}
