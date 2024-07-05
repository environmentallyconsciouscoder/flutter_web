import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:sales_engine/app/app.locator.dart';
import 'package:sales_engine/app/app.router.dart';
import 'package:sales_engine/services/authentication_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  Future runStartupLogic() async {
    // 2. Check if the user is logged in
    if (_authenticationService.userLoggedIn()) {
      // 3. Navigate to HomeView
      _navigationService.replaceWith(Routes.dashboardView);
    } else {
      // 4. Or navigate to LoginView
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
