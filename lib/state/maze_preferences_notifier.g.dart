// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maze_preferences_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MazePreferencesNotifier)
final mazePreferencesProvider = MazePreferencesNotifierProvider._();

final class MazePreferencesNotifierProvider
    extends
        $NotifierProvider<
          MazePreferencesNotifier,
          MazePreferencesNotifierState
        > {
  MazePreferencesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mazePreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mazePreferencesNotifierHash();

  @$internal
  @override
  MazePreferencesNotifier create() => MazePreferencesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MazePreferencesNotifierState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MazePreferencesNotifierState>(value),
    );
  }
}

String _$mazePreferencesNotifierHash() =>
    r'6af98af8e677a5d05d348ae9d8a8190ead9af410';

abstract class _$MazePreferencesNotifier
    extends $Notifier<MazePreferencesNotifierState> {
  MazePreferencesNotifierState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<MazePreferencesNotifierState, MazePreferencesNotifierState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                MazePreferencesNotifierState,
                MazePreferencesNotifierState
              >,
              MazePreferencesNotifierState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
