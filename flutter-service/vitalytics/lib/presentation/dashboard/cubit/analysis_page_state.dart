import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object?> get props => [];
}

class AnalysisInitial extends AnalysisState {}

class AnalysisLoading extends AnalysisState {}

class AnalysisImageSelected extends AnalysisState {
  final File image;
  const AnalysisImageSelected(this.image);

  @override
  List<Object?> get props => [image];
}

class AnalysisUploaded extends AnalysisState {
  final Map<String, dynamic> response;
  const AnalysisUploaded(this.response);

  @override
  List<Object?> get props => [response];
}

class AnalysisError extends AnalysisState {
  final String message;
  const AnalysisError(this.message);

  @override
  List<Object?> get props => [message];
}
