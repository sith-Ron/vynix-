// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(calendarRepository)
const calendarRepositoryProvider = CalendarRepositoryProvider._();

final class CalendarRepositoryProvider
    extends
        $FunctionalProvider<
          CalendarRepository,
          CalendarRepository,
          CalendarRepository
        >
    with $Provider<CalendarRepository> {
  const CalendarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalendarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalendarRepository create(Ref ref) {
    return calendarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarRepository>(value),
    );
  }
}

String _$calendarRepositoryHash() =>
    r'f8e0ed68fbbca87eeb9416da4038e7a4ef02a76c';

@ProviderFor(CalendarVisibleMonth)
const calendarVisibleMonthProvider = CalendarVisibleMonthProvider._();

final class CalendarVisibleMonthProvider
    extends $NotifierProvider<CalendarVisibleMonth, DateTime> {
  const CalendarVisibleMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarVisibleMonthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarVisibleMonthHash();

  @$internal
  @override
  CalendarVisibleMonth create() => CalendarVisibleMonth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$calendarVisibleMonthHash() =>
    r'a4286a1cb04eac587636c780562d6f7a2e86c69d';

abstract class _$CalendarVisibleMonth extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CalendarSelectedDay)
const calendarSelectedDayProvider = CalendarSelectedDayProvider._();

final class CalendarSelectedDayProvider
    extends $NotifierProvider<CalendarSelectedDay, DateTime> {
  const CalendarSelectedDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarSelectedDayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarSelectedDayHash();

  @$internal
  @override
  CalendarSelectedDay create() => CalendarSelectedDay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$calendarSelectedDayHash() =>
    r'17fb8adbab3c3c12b9ddbcb59fd6c58720c0926a';

abstract class _$CalendarSelectedDay extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(calendarMonthEvents)
const calendarMonthEventsProvider = CalendarMonthEventsProvider._();

final class CalendarMonthEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CalendarEventEntry>>,
          List<CalendarEventEntry>,
          Stream<List<CalendarEventEntry>>
        >
    with
        $FutureModifier<List<CalendarEventEntry>>,
        $StreamProvider<List<CalendarEventEntry>> {
  const CalendarMonthEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarMonthEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarMonthEventsHash();

  @$internal
  @override
  $StreamProviderElement<List<CalendarEventEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CalendarEventEntry>> create(Ref ref) {
    return calendarMonthEvents(ref);
  }
}

String _$calendarMonthEventsHash() =>
    r'41a35385e131a07fd35f6af69c8a74d159aa40b7';

@ProviderFor(calendarDayAgenda)
const calendarDayAgendaProvider = CalendarDayAgendaProvider._();

final class CalendarDayAgendaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CalendarEventEntry>>,
          List<CalendarEventEntry>,
          Stream<List<CalendarEventEntry>>
        >
    with
        $FutureModifier<List<CalendarEventEntry>>,
        $StreamProvider<List<CalendarEventEntry>> {
  const CalendarDayAgendaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarDayAgendaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarDayAgendaHash();

  @$internal
  @override
  $StreamProviderElement<List<CalendarEventEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CalendarEventEntry>> create(Ref ref) {
    return calendarDayAgenda(ref);
  }
}

String _$calendarDayAgendaHash() => r'3fe354883890f03846dc42a469f74299afdeebf0';

@ProviderFor(CalendarMutations)
const calendarMutationsProvider = CalendarMutationsProvider._();

final class CalendarMutationsProvider
    extends $NotifierProvider<CalendarMutations, AsyncValue<void>> {
  const CalendarMutationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarMutationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarMutationsHash();

  @$internal
  @override
  CalendarMutations create() => CalendarMutations();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$calendarMutationsHash() => r'dcbdda390eb59c2c44017564acb242990beccd0d';

abstract class _$CalendarMutations extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CalendarEventDraftController)
const calendarEventDraftControllerProvider =
    CalendarEventDraftControllerFamily._();

final class CalendarEventDraftControllerProvider
    extends
        $NotifierProvider<CalendarEventDraftController, CalendarEventDraft> {
  const CalendarEventDraftControllerProvider._({
    required CalendarEventDraftControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'calendarEventDraftControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calendarEventDraftControllerHash();

  @override
  String toString() {
    return r'calendarEventDraftControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CalendarEventDraftController create() => CalendarEventDraftController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarEventDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarEventDraft>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarEventDraftControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calendarEventDraftControllerHash() =>
    r'98ed2e2cd6d9e6f3bc2fc6f863129b0430ad5ba2';

final class CalendarEventDraftControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CalendarEventDraftController,
          CalendarEventDraft,
          CalendarEventDraft,
          CalendarEventDraft,
          String
        > {
  const CalendarEventDraftControllerFamily._()
    : super(
        retry: null,
        name: r'calendarEventDraftControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CalendarEventDraftControllerProvider call(String draftId) =>
      CalendarEventDraftControllerProvider._(argument: draftId, from: this);

  @override
  String toString() => r'calendarEventDraftControllerProvider';
}

abstract class _$CalendarEventDraftController
    extends $Notifier<CalendarEventDraft> {
  late final _$args = ref.$arg as String;
  String get draftId => _$args;

  CalendarEventDraft build(String draftId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<CalendarEventDraft, CalendarEventDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalendarEventDraft, CalendarEventDraft>,
              CalendarEventDraft,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
