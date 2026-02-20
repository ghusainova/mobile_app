import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';

final _context = rootNavigatorKey.currentContext;

void getSellerDataStep() {
  if (_context != null) {
    const GetSellerDataRoute().push(_context!);
  }
}

void sendDataToCheckStep() {
  if (_context != null) {
    const CreditAdditionalInfoRoute().push(_context!);
  }
}

void goToReworkStep() {
  if (_context != null) {
    const CreditReworkRoute().push(_context!);
  }
}
