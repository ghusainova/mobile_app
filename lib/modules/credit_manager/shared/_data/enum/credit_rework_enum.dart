import '../../../../../config/injectable/injectable.dart';
import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';

const creditReworkTechPassType = 'PASSPORT_INFO';
const creditReworkRecycleType = 'RECYCLE';

enum CreditReworkEnum {
  wrongTechRegNum,
  wrongPassportVin,
  wrongBodyNumber,
  wrongYear,
  wrongVol,
  wrongTechpas,
  wrongWeight,
  noRecyclePayment,
  qualPhotoTch,
  changePdfPassportInfo,
  otherPassportInfo,
}

extension CreditReworkExt on CreditReworkEnum {
  String get type {
    if (this == CreditReworkEnum.noRecyclePayment) {
      return creditReworkRecycleType;
    } else {
      return creditReworkTechPassType;
    }
  }

  String get name {
    final creditExpDate =
        getIt.get<CreditApplicationBloc>().carLoanOrder?.order.creditExpDate;
    final inputDateText =
        (creditExpDate?.isNotEmpty ?? false) ? 'до $creditExpDate' : '';

    if (this == CreditReworkEnum.noRecyclePayment) {
      return 'Продавцу нужно оплатить утильсбор $inputDateText';
    }

    return 'Продавцу нужно заменить техпаспорт $inputDateText';
  }

  String get finalName {
    if (this == CreditReworkEnum.noRecyclePayment) {
      return 'Продавец оплатил утильсбор';
    }

    return 'Продавцу заменил техпаспорт';
  }

  String get code {
    switch (this) {
      case CreditReworkEnum.wrongTechRegNum:
        return 'WRONG_REGNUM';
      case CreditReworkEnum.wrongPassportVin:
        return 'WRONG_PASSPORT_VIN';
      case CreditReworkEnum.wrongBodyNumber:
        return 'WRONG_BODY_NUMBER';
      case CreditReworkEnum.wrongYear:
        return 'WRONG_YEAR';
      case CreditReworkEnum.wrongVol:
        return 'WRONG_VOL';
      case CreditReworkEnum.wrongTechpas:
        return 'WRONG_TECHPAS';
      case CreditReworkEnum.wrongWeight:
        return 'WRONG_WEIGHT';
      case CreditReworkEnum.noRecyclePayment:
        return 'NO_RECYCLE_PAYMENT';
      case CreditReworkEnum.qualPhotoTch:
        return 'QUAL_PHOTO_TCH';
      case CreditReworkEnum.changePdfPassportInfo:
        return 'CHANGE_PDF_PASSPORT_INFO';
      case CreditReworkEnum.otherPassportInfo:
        return 'OTHER_PASSPORT_INFO';
    }
  }

  String get description {
    switch (this) {
      case CreditReworkEnum.wrongTechRegNum:
        return 'Неверно указан регистрационный номер';
      case CreditReworkEnum.wrongPassportVin:
        return 'Неверно указан VIN в техпаспорте';
      case CreditReworkEnum.wrongBodyNumber:
        return 'Неверно указан номер кузова';
      case CreditReworkEnum.wrongYear:
        return 'Неверно указан Год выпуска';
      case CreditReworkEnum.wrongVol:
        return 'Неверно указан объём';
      case CreditReworkEnum.wrongTechpas:
        return 'Неверно указан номер техпаспорта';
      case CreditReworkEnum.wrongWeight:
        return 'Масса авто больше 3500';
      case CreditReworkEnum.noRecyclePayment:
        return 'По данному VIN/Номеру кузова не найдено оплат утилизационного сбора, кредитование возможно после оплаты';
      case CreditReworkEnum.qualPhotoTch:
        return 'Предоставьте качественное фото техпаспорта';
      case CreditReworkEnum.changePdfPassportInfo:
        return 'Необходимо заменить документ(-ы)';
      case CreditReworkEnum.otherPassportInfo:
        return 'Другое';
    }
  }
}
