import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:sales_engine/app/app.router.dart';
import 'package:sales_engine/app/app.locator.dart';
import 'package:sales_engine/services/authentication_service.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  Future<void> login() async {
    final url = dotenv.env['URL_CLIENT'];
    final clientId = dotenv.env['CLIENT_ID']!;

    final authorizationEndpoint = 'https://dev-fg0lohc8wlk0t0g7.eu.auth0.com/authorize?response_type=code&client_id=$clientId&redirect_uri=$url';
    const redirectUri = 'dashboard-view';

    // Call the flutter_web_auth library to open a browser and authenticate the user
    final result = await FlutterWebAuth.authenticate(url: authorizationEndpoint, callbackUrlScheme: redirectUri);

    if (result.isNotEmpty) {
      // final code = Uri.parse(result).queryParameters['code'];
      _authenticationService.updateLoginStatus();
      _navigationService.replaceWith(Routes.dashboardView);
    }
  }
}
