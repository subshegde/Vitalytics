import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/progress_entry.dart';
import 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressLoading()) {
    loadEntries();
  }

  void loadEntries() {
    final data = [
      ProgressEntry(
        date: DateTime(2023, 10, 24),
        severity: 8,
        notes: "Started new cream.",
        image: "assets/p1.png",
      ),
      ProgressEntry(
        date: DateTime(2023, 10, 17),
        severity: 6,
        notes: "Felt less itchy.",
        image: "assets/p2.png",
      ),
      ProgressEntry(
        date: DateTime(2023, 10, 10),
        severity: 5,
        notes: "First entry.",
        image: "assets/p3.png",
      ),
    ];

    emit(ProgressLoaded(
      allEntries: data,
      filteredEntries: data,
    ));
  }

  void filterRange(String days) {
    final current = state as ProgressLoaded;

    final now = DateTime.now();
    final cutoff = now.subtract(Duration(days: int.parse(days)));

    final filtered = current.allEntries
        .where((e) => e.date.isAfter(cutoff))
        .toList();

    emit(current.copyWith(
      selectedRange: days,
      filteredEntries: filtered,
    ));
  }

  void switchView(bool timeline) {
    final current = state as ProgressLoaded;
    emit(current.copyWith(isTimelineView: timeline));
  }
}
