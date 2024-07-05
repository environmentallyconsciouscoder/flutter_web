import 'package:flutter/material.dart';
import 'package:sales_engine/ui/common/app_colors.dart';
import 'package:sales_engine/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcPrimaryUltraLightColor,
        body: Center(
          child: SizedBox(
            height: 700.0,
            width: 500.0,
            child: Card(
              color: kcPrimaryDarkColor,
              margin: const EdgeInsets.all(32.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset("assets/images/limetrack_logo_white_horizontal.webp"),
                    ),
                    verticalSpaceSmall,
                    const Text(
                      'Sales Engine',
                      style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceMedium,
                    SizedBox(
                      child: Image.asset("assets/images/limetrack_earth.jpg"),
                    ),
                    verticalSpaceMedium,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await model.login();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            backgroundColor: kcPrimaryColor,
                            minimumSize: const Size(120.0, 0),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
