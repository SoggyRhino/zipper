// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maze_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MazeNotifier)
final mazeProvider = MazeNotifierProvider._();

final class MazeNotifierProvider
    extends $NotifierProvider<MazeNotifier, MazeNotifierState> {
  MazeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mazeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mazeNotifierHash();

  @$internal
  @override
  MazeNotifier create() => MazeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MazeNotifierState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MazeNotifierState>(value),
    );
  }
}

String _$mazeNotifierHash() => r'1169bea0d2827e4d3c0932055991bed7aec34e9f';

abstract class _$MazeNotifier extends $Notifier<MazeNotifierState> {
  MazeNotifierState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MazeNotifierState, MazeNotifierState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MazeNotifierState, MazeNotifierState>,
              MazeNotifierState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
