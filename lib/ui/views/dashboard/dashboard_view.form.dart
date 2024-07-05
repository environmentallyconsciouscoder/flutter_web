// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String SearchInputValueKey = 'searchInput';

final Map<String, TextEditingController> _DashboardViewTextEditingControllers =
    {};

final Map<String, FocusNode> _DashboardViewFocusNodes = {};

final Map<String, String? Function(String?)?> _DashboardViewTextValidations = {
  SearchInputValueKey: null,
};

mixin $DashboardView on StatelessWidget {
  TextEditingController get searchInputController =>
      _getFormTextEditingController(SearchInputValueKey);
  FocusNode get searchInputFocusNode => _getFormFocusNode(SearchInputValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_DashboardViewTextEditingControllers.containsKey(key)) {
      return _DashboardViewTextEditingControllers[key]!;
    }
    _DashboardViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _DashboardViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_DashboardViewFocusNodes.containsKey(key)) {
      return _DashboardViewFocusNodes[key]!;
    }
    _DashboardViewFocusNodes[key] = FocusNode();
    return _DashboardViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    searchInputController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    searchInputController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchInputValueKey: searchInputController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        SearchInputValueKey: _getValidationMessage(SearchInputValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _DashboardViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_DashboardViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _DashboardViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _DashboardViewFocusNodes.values) {
      focusNode.dispose();
    }

    _DashboardViewTextEditingControllers.clear();
    _DashboardViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get searchInputValue =>
      this.formValueMap[SearchInputValueKey] as String?;

  bool get hasSearchInput =>
      this.formValueMap.containsKey(SearchInputValueKey) &&
      (searchInputValue?.isNotEmpty ?? false);

  bool get hasSearchInputValidationMessage =>
      this.fieldsValidationMessages[SearchInputValueKey]?.isNotEmpty ?? false;

  String? get searchInputValidationMessage =>
      this.fieldsValidationMessages[SearchInputValueKey];
}

extension Methods on FormViewModel {
  setSearchInputValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchInputValueKey] = validationMessage;
}
