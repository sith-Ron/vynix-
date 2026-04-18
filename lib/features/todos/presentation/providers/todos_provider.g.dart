// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodosController)
const todosControllerProvider = TodosControllerProvider._();

final class TodosControllerProvider
    extends $NotifierProvider<TodosController, List<TodoItem>> {
  const TodosControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todosControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todosControllerHash();

  @$internal
  @override
  TodosController create() => TodosController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TodoItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TodoItem>>(value),
    );
  }
}

String _$todosControllerHash() => r'e156be14aaa46fcc6073f47a5b5fec606ded6d70';

abstract class _$TodosController extends $Notifier<List<TodoItem>> {
  List<TodoItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<TodoItem>, List<TodoItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TodoItem>, List<TodoItem>>,
              List<TodoItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(todosRepository)
const todosRepositoryProvider = TodosRepositoryProvider._();

final class TodosRepositoryProvider
    extends
        $FunctionalProvider<TodosRepository, TodosRepository, TodosRepository>
    with $Provider<TodosRepository> {
  const TodosRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todosRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todosRepositoryHash();

  @$internal
  @override
  $ProviderElement<TodosRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodosRepository create(Ref ref) {
    return todosRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodosRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodosRepository>(value),
    );
  }
}

String _$todosRepositoryHash() => r'c3a699ed20693e3ca823457242e3bbfca528a4e8';

@ProviderFor(sortedTodos)
const sortedTodosProvider = SortedTodosProvider._();

final class SortedTodosProvider
    extends $FunctionalProvider<List<TodoItem>, List<TodoItem>, List<TodoItem>>
    with $Provider<List<TodoItem>> {
  const SortedTodosProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortedTodosProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortedTodosHash();

  @$internal
  @override
  $ProviderElement<List<TodoItem>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<TodoItem> create(Ref ref) {
    return sortedTodos(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TodoItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TodoItem>>(value),
    );
  }
}

String _$sortedTodosHash() => r'7a8d8976a36c28e2bed57c5fb39ef869df9d8d8b';
