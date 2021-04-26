import 'package:data/india_health_stack_repo_impl.dart';
import 'package:entities/india_health_stack_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:ui/factory/module/map_module.dart';
import 'package:ui/factory/module/health_data_module.dart';
import 'package:entities/maps_repo.dart';
import 'package:remote_api/maps_api/maps_api.dart';
import 'package:platform_web/platform_web_maps_repo.dart';
class IndiaHealthStackModule {
//  static Alice alice;
  static bool enableOnScreenCrash = kReleaseMode ? false : true;
  static IndiaHealthStackModule _instance;
  MapsRepo _mapsRepoInstance;
  MapsRemoteApi _mapsRemoteApiInstance;
  // ErrorRepo _errorRepoInstance;

  factory IndiaHealthStackModule() {
    if (_instance == null) {
      _instance = IndiaHealthStackModule._default();
    }
//    if (aliceInstance != null) {
//      alice = aliceInstance;
//    }
    return _instance;
  }

  IndiaHealthStackModule._default();

  bool enableMock = false;

  // Map<String, dynamic> _deviceConfig;

  HealthDataModule _healthDataModule;
  IndiaHealthStackRepo _indiaHealthStackRepo;
  Future<bool> initialise() async {
    return true;
  }

  HealthDataModule healthDataModule() {
    if (_healthDataModule == null) {
      _healthDataModule =
          HealthDataModule(indiaHealthStackRepo());
    }
    return _healthDataModule;
  }

  MapModule _mapModuleInstance;

  MapModule mapModule() {
    if (_mapModuleInstance == null) {
      _mapModuleInstance = MapModule(
        _mapsRepo(),
      );
    }
    return _mapModuleInstance;
  }

  IndiaHealthStackRepo indiaHealthStackRepo() {
    if (_indiaHealthStackRepo == null) {
      if (!enableMock) {
        _indiaHealthStackRepo = IndiaHealthStackRepoImplementation(_mapsRemoteApi());
      } else {
        _indiaHealthStackRepo = IndiaHealthStackRepoImplementation(_mapsRemoteApi());
      }
    }
    return _indiaHealthStackRepo;
  }

  MapsRepo _mapsRepo() {
    if (_mapsRepoInstance == null) {
      _mapsRepoInstance = PlatformWebMapsRepo();
    }
    return _mapsRepoInstance;
  }

  MapsRemoteApi _mapsRemoteApi() {
    if (_mapsRemoteApiInstance == null) {
      _mapsRemoteApiInstance = MapsRemoteApi.create();
    }
    return _mapsRemoteApiInstance;
  }
}
