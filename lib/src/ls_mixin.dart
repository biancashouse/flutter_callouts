// ignore_for_file: constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../flutter_callouts.dart' show fca;


mixin LocalStorageMixin {
  Storage get localStorage {
    return HydratedBloc.storage;
  }

  Future<void> initLocalStorage() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
    fca.initGotits();

  }
}
