import '../models/progress_entry.dart';

abstract class ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final List<ProgressEntry> allEntries;
  final List<ProgressEntry> filteredEntries;
  final String selectedRange;
  final bool isTimelineView;

  ProgressLoaded({
    required this.allEntries,
    required this.filteredEntries,
    this.selectedRange = "7",
    this.isTimelineView = true,
  });

  ProgressLoaded copyWith({
    List<ProgressEntry>? allEntries,
    List<ProgressEntry>? filteredEntries,
    String? selectedRange,
    bool? isTimelineView,
  }) {
    return ProgressLoaded(
      allEntries: allEntries ?? this.allEntries,
      filteredEntries: filteredEntries ?? this.filteredEntries,
      selectedRange: selectedRange ?? this.selectedRange,
      isTimelineView: isTimelineView ?? this.isTimelineView,
    );
  }
}
