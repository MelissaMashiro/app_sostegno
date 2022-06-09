import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/core/storage/shared_preferences_impl.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/features/authentication/authentication.dart';
import 'package:app_sostegno/features/monitories/presentation/monitor_monitories/bloc/monitor_monitories_bloc.dart';
import 'package:app_sostegno/features/monitories/presentation/monitor_monitories/pages/monitor_monitories_page.dart';
import 'package:app_sostegno/injection_container.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class InkWellDrawer extends StatefulWidget {
  final BuildContext context;
  const InkWellDrawer({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  State<InkWellDrawer> createState() => _InkWellDrawerState();
}

class _InkWellDrawerState extends State<InkWellDrawer> {
  MySharedPreferences sharedPreferences = MySharedPreferencesImpl();
  UserEntity? user;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      user = await sharedPreferences.getUser();

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget result;

    if (user != null) {
      result = Drawer(
        child: Container(
          color: kDarkBlue,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        //Get.offAndToNamed(RoutesName.PROFILE_PAGE);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0.0, 2.0), //(x,y)
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://www.w3schools.com/howto/img_avatar.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${user?.person.user.firstName ?? ''} ${user?.person.user.lastName ?? ''}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
                    )
                  ],
                ),
              ),
              const Divider(
                indent: 40,
                endIndent: 40,
                color: kGray,
                height: 15,
              ),
              CustomListTile(
                icon: Icons.dashboard,
                text: 'Dashboard',
                onTap: () => {
                  //Get.offAndToNamed(RoutesName.DASHBOARDPAGE_PAGE),
                },
              ),
              user!.personType == 2
                  ? CustomListTile(
                      icon: Icons.book,
                      text: 'Crear Monitoria',
                      onTap: () => {
                        Get.offAndToNamed(RoutesName.CREATE_MONITORY,
                            arguments: {
                              'hasPreData': false,
                            }),
                      },
                    )
                  : const SizedBox(),
              user!.personType == 2
                  ? CustomListTile(
                      icon: Icons.bookmark,
                      text: 'Mis monitorías',
                      onTap: () => {
                        //!TODO: OBTENER INFO DEL USUARIO HERE.
                        Get.to(
                          () => BlocProvider<MonitorMonitoriesBloc>(
                            create: (_) => sl<
                                MonitorMonitoriesBloc>(), //UserBloc(UserRepository()),
                            child: const MonitorMonitoriesPage(),
                          ),
                        )
                        // Get.offAndToNamed(RoutesName.My_MONITORIES),
                      },
                    )
                  : const SizedBox(),
              user!.personType == 1
                  ? CustomListTile(
                      icon: Icons.plus_one,
                      text: 'Solicitar Monitoría',
                      onTap: () => {
                        Get.offAndToNamed(RoutesName.MAKE_MONITORY_REQUEST),
                      },
                    )
                  : const SizedBox(),
              user!.personType == 2
                  ? CustomListTile(
                      icon: Icons.remove_red_eye_rounded,
                      text: 'Ver Solicitudes',
                      onTap: () => {
                        Get.offAndToNamed(RoutesName.REQUESTED_MONITORY),
                      },
                    )
                  : const SizedBox(),
              user!.personType == 1
                  ? CustomListTile(
                      icon: Icons.class_outlined,
                      text: 'Inscribirme a Monitoria',
                      onTap: () => {
                        Get.toNamed(RoutesName.ENROLL_MONITORY_STEP1),
                        // Get.to(
                        //   () => BlocProvider<EnrollToMonitoryBloc>(
                        //     create: (context) =>
                        //         EnrollToMonitoryBloc(), //UserBloc(UserRepository()),
                        //     child: const EnrollToMonitoryPage(),
                        //   ),
                        // )
                      },
                    )
                  : const SizedBox(),
              const Spacer(),
              CustomListTile(
                icon: Icons.logout,
                text: 'Cerrar Sesión',
                onTap: () async {
                  await sharedPreferences.removeUserData().then((_) {
                    Get.back();
                    Get.offAllNamed(RoutesName.LOADING_PAGE);
                  });

                  //Auth.instance.logOut(context);
                },
              ),
              // Auth.instance.logOut(context);
            ],
          ),
        ),
      );
    } else {
      result = const CircularProgressIndicator();
    }

    return result;
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomListTile(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(35.0, 8, 0, 7),
      child: InkWell(
        splashColor: Colors.orangeAccent,
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: Colors.white),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
