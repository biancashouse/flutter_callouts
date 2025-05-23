// ignore_for_file: constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';


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
