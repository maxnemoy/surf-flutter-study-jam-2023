import 'package:flutter/material.dart';

class SelectableListWrapper<T> extends InheritedWidget {
  final ValueNotifier<List<T>> selectedItems;

  const SelectableListWrapper({
    super.key,
    required this.selectedItems,
    required super.child,
  });

  void change(T item) {
    List<T> current = selectedItems.value;
    if (current.contains(item)) {
      current.remove(item);
    } else {
      current.add(item);
    }

    selectedItems.value = current.toList();
  }

  void unSelectAll() {
    selectedItems.value = [];
  }

  static SelectableListWrapper<T>? maybeOf<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SelectableListWrapper<T>>();
  }

  static SelectableListWrapper<T> of<T>(BuildContext context) {
    final SelectableListWrapper<T>? result = maybeOf(context);
    assert(result != null, 'No found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SelectableListWrapper oldWidget) => true;
}
