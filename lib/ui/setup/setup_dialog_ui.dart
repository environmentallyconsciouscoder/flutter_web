import 'package:sales_engine/app/app.locator.dart';
import 'package:sales_engine/enums/dialog_type.dart';
import 'package:sales_engine/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:sales_engine/ui/dialogs/loading/loading.dart';

import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<dynamic, DialogBuilder> builders = {
    DialogType.infoAlert: (context, sheetRequest, completer) =>
        InfoAlertDialog(request: sheetRequest, completer: completer),
    DialogType.loading: (context, sheetRequest, completer) =>
        const LoadingDialog(),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
