import 'package:flutter/material.dart';
import 'package:sales_engine/ui/common/ui_helpers.dart';
import 'package:sales_engine/ui/widgets/lime_table_pagination.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'dashboard_view.form.dart';
import 'package:sales_engine/ui/common/app_colors.dart';
import 'package:sales_engine/ui/common/responsive.dart';
import 'package:sales_engine/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:sales_engine/ui/widgets/lime_drawer_menu.dart';
import 'package:sales_engine/ui/widgets/lime_search_bar.dart';
import 'package:sales_engine/ui/widgets/lime_google_map.dart';

@FormView(fields: [
  FormTextField(name: 'searchInput'),
])
class DashboardView extends StackedView<DashboardViewModel> with $DashboardView {
  DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: Responsive.isMobile(context) ? AppBar(backgroundColor: kcPrimaryDarkColor) : null,
      drawer: Responsive.isMobile(context) ? DrawerMenu(selector: viewModel.selector) : null,
      backgroundColor: kcWhiteColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: DrawerMenu(selector: viewModel.selector),
              ),
            Expanded(
                flex: 4,
                child: SafeArea(
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                        child: Column(children: [
                          SearchBarView(controller: searchInputController, submit: viewModel.submitSearch),
                          if (viewModel.showAndHide)
                            DataTableWithPaginationWidget(
                                sortedData: viewModel.sortedCompanies,
                                sortAscending: viewModel.sortAscending,
                                sortColumnIndex: viewModel.sortColumnIndex,
                                rowsPerPage: viewModel.rowsPerPage,
                                onRowsPerPageChanged: viewModel.onRowsPerPageChanged),
                          verticalSpaceMedium,
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              viewModel.label,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GoogleMapView(getMap: viewModel.initMap)
                        ]))))
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(DashboardViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  DashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardViewModel();
}
