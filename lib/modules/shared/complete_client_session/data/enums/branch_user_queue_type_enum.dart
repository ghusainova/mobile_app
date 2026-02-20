enum BranchUserQueueTypeEnum {
  docsManager,
  salesManager,
}

extension BranchUserQueueTypeExt on BranchUserQueueTypeEnum {
  int? get code {
    switch (this) {
      case BranchUserQueueTypeEnum.docsManager:
        return 2;
      case BranchUserQueueTypeEnum.salesManager:
        return 16;
    }
  }

  String? get label {
    switch (this) {
      case BranchUserQueueTypeEnum.docsManager:
        return 'Менеджер оформления документов';
      case BranchUserQueueTypeEnum.salesManager:
        return 'Менеджер продаж';
    }
  }
}
