
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemography_test/entities/snack_bar_entity.dart';
import 'package:gemography_test/network/api/repo_service_api/repo_service.dart';
import 'package:gemography_test/view_models/repo_view_model/repo_view_model.dart';

/// Snack bar provider
final snackBarStateProvider = StateProvider<SnackBarEntity>(
        (_) => SnackBarEntity.initial(),
);

/// Loading provider
final loadingStateProvider = StateProvider<bool>((_) => false);

/// Banners data Providers
final repoServiceProvider = Provider<RepoServiceApi>((ref) => RepoServiceApi());
final repoViewModelProvider = ChangeNotifierProvider<RepoViewModel>((ref) => RepoViewModel(ref.read));