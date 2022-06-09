import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_sostegno/core/network_info.dart';
import 'package:app_sostegno/core/storage/shared_preferences_impl.dart';
import 'package:app_sostegno/features/authentication/authentication.dart';
import 'package:app_sostegno/features/enroll_to_monitory/enroll_to_monitory.dart';
import 'package:app_sostegno/features/monitories/domain/usecases/get_materias_by_monitor.dart';
import 'package:app_sostegno/features/monitories/monitories.dart';
import 'package:app_sostegno/features/monitory_creation/create_monitory.dart';
import 'package:app_sostegno/features/monitory_request_creation/make_monitory_request.dart';
import 'package:app_sostegno/features/monitory_requests/monitory_requests.dart';
import 'package:app_sostegno/features/register/register.dart';

import 'features/monitor_details/monitor_details.dart';

final sl = GetIt.instance;

//Acá registraremos singletons(factory)
// Al usar sl() como parametro, servirá para poder referenciar estos metodos sin usarlos aun.
Future<void> init() async {
  //! Authentication
  sl.registerLazySingleton(() => AuthenticationBloc(
        loginUser: sl(),
        logoutUser: sl(),
      ));

  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton<AuthenticationLocalDataSource>(() =>
      AuthenticationLocalDataSourceImpl(
          sharedPreferences: MySharedPreferencesImpl()));

  //! Enroll To Monitories
  // Bloc
  sl.registerFactory(
    () => EnrollToMonitoryBloc(
      getAvailableMonitories: sl(),
      enrollToMonitory: sl(),
      getAllMaterias: sl(),
      getMonitoresByMateria: sl(),
      getMonitoryDetails: sl(),
    ),
  );

  // Use Cases
  // Lazy es para que se inicie cuando se requiere, sin lazy, se iniciaria automaticamente cuando se inicia la app
  sl.registerLazySingleton(() => GetAvailableMonitories(sl()));
  sl.registerLazySingleton(() => EnrollToMonitory(sl()));
  sl.registerLazySingleton(() => GetAllMaterias(sl()));
  sl.registerLazySingleton(() => GetMonitoresByMateria(sl()));
  sl.registerLazySingleton(() => GetMonitoryDetails(sl()));

  // Repository
  // Acá instancio el repositorio a usar para este feature y le paso la implementacion de este que quiero usar
  sl.registerLazySingleton<EnrollMonitoryRepository>(() =>
      EnrollMonitoryRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<EnrollMonitoryRemoteDataSource>(
    () => EnrollMonitoryRemoteDataSourceImpl(
      dio: sl(),
      sharedPreferences: MySharedPreferencesImpl(),
    ),
  );

  sl.registerLazySingleton<EnrollMonitoryLocalDataSource>(
      () => EnrollMonitoryLocalDataSourceImpl(sharedPreferences: sl()));

  //! Monitor Details
  sl.registerFactory(() => MonitorDetailsBloc(getMonitorDetails: sl()));

  sl.registerLazySingleton(() => GetMonitorDetails(sl()));

  sl.registerLazySingleton<MonitorDetailsRepository>(
    () => MonitorDetailsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<MonitorDetailsRemoteDataSource>(
      () => MonitorDetailsRemoteDataSourceImpl(
            dio: sl(),
            sharedPreferences: MySharedPreferencesImpl(),
          ));

  //! Monitories
  sl.registerFactory(
    () => MonitorMonitoriesBloc(
      getMateriasByMonitor: sl(),
      getMonitoriesByMonitor: sl(),
      getMonitorMonitoriesByMateria: sl(),
    ),
  );
  sl.registerFactory(
    () => MonitoriesCalendarBloc(
      getStudentEnrolledMonitories: sl(),
      getMonitoriesByMonitor: sl(),
      getMonitoryDetails: sl(),
    ),
  );
  sl.registerFactory(
    () => MonitoryDetailsBloc(
      getMonitoryDetails: sl(),
      cancelMonitory: sl(),
    ),
  );

  sl.registerLazySingleton(() => CancelMonitory(sl()));
  sl.registerLazySingleton(() => GetMateriasByMonitor(sl()));
  sl.registerLazySingleton(() => GetMateriasByMonitorWithCode(sl()));
  sl.registerLazySingleton(() => GetMonitorMonitoriesByMateria(sl()));
  sl.registerLazySingleton(() => GetMonitoriesByMonitor(sl()));
  sl.registerLazySingleton(() => GetStudentEnrolledMonitories(sl()));

  sl.registerLazySingleton<MonitoriesRepository>(
    () => MonitoriesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<MonitoriesRemoteDataSource>(
      () => MonitoriesRemoteDataSourceImpl(
            dio: sl(),
            sharedPreferences: MySharedPreferencesImpl(),
          ));

  sl.registerLazySingleton<MonitoriesLocalDataSource>(
      () => MonitoriesLocalDataSourceImpl(sharedPreferences: sl()));

  //! Monitory Creation
  sl.registerFactory(() => MonitoryCreationBloc(
        createMonitory: sl(),
        getMateriasByMonitor: sl(),
        sharedPreferences: MySharedPreferencesImpl(),
      ));

  sl.registerLazySingleton(() => CreateMonitory(sl()));

  sl.registerLazySingleton<MonitoryCreationRepository>(
    () => MonitoryCreationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<MonitoryCreationRemoteDataSource>(
      () => MonitoryCreationRemoteDataSourceImpl(
            dio: sl(),
            sharedPreferences: MySharedPreferencesImpl(),
          ));

  //! Monitory Request Creation
  sl.registerFactory(() => MonitoryRequestCreationBloc(
      createMonitoryRequest: sl(), getAllMaterias: sl()));

  sl.registerLazySingleton(() => CreateMonitoryRequest(sl()));

  sl.registerLazySingleton<MonitoryRequestCreationRepository>(
    () => MonitoryRequestCreationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<MonitoryRequestCreationRemoteDataSource>(
    () => MonitoryRequestCreationRemoteDataSourceImpl(
      dio: sl(),
      sharedPreferences: MySharedPreferencesImpl(),
    ),
  );

  //! Monitory Requests
  sl.registerFactory(() =>
      MonitoryRequestsBloc(acceptMonitory: sl(), getRequestedMonitories: sl()));

  sl.registerLazySingleton(() => AcceptMonitory(sl()));
  sl.registerLazySingleton(() => GetRequestedMonitories(sl()));

  sl.registerLazySingleton<MonitoryRequestsRepository>(
    () => MonitoryRequestsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<MonitoryRequestsRemoteDataSource>(
    () => MonitoryRequestsRemoteDataSourceImpl(
      dio: sl(),
      sharedPreferences: MySharedPreferencesImpl(),
    ),
  );

  sl.registerLazySingleton<MonitoryRequestsLocalDataSource>(
      () => MonitoryRequestsLocalDataSourceImpl(sharedPreferences: sl()));

  //! Registration
  sl.registerFactory(() =>
      RegistrationBloc(getBarranquillaUniversities: sl(), registerUser: sl()));

  sl.registerLazySingleton(() => GetBarranquillaUniversities(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(dio: sl()));

  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() {
    Dio dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        request: true,
        error: true,
        compact: true,
        maxWidth: 150,
      ),
    );

    return dio;
  });
  sl.registerLazySingleton(() => Connectivity());
}
