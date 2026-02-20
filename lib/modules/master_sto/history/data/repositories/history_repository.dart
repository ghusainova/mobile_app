import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../defect_inspection/_shared/data/models/paint_thickness.dart';
import '../models/history.dart';
import '../providers/history_api_provider.dart';

@lazySingleton
class HistoryRepository {
  final HistoryApiProvider provider;

  const HistoryRepository({
    required this.provider,
  });

  Future<History?> getHistory(String caseId) async {
    return await provider.getHistory(caseId: caseId);
  }

  Future<HttpResponse> cancelCase(String caseId) async {
    return await provider.cancelCase(caseId: caseId);
  }

  Future<HttpResponse> finishCase({
    required String caseId,
    String? comment,
  }) async {
    return await provider.finishCase(
      caseId: caseId,
      comment: comment,
    );
  }

  Future<PaintThickness> getThicknessValues(String brand, String model) async {
    return await provider.getThicknessValues(
      brand: brand,
      model: model,
    );
  }

  Future<void> setOrderByName({
    required String caseId,
    required String stageName,
  }) async {
    return await provider.setOrderByName(
      caseId: caseId,
      stageName: stageName,
    );
  }
}
