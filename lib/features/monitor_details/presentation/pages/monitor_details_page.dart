import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/features/monitor_details/presentation/bloc/monitor_details_bloc.dart';
import 'package:app_sostegno/features/monitor_details/presentation/widgets/monitor_details_view.dart';
import 'package:app_sostegno/injection_container.dart';

class MonitorDetailsPage extends StatefulWidget {
  const MonitorDetailsPage({Key? key}) : super(key: key);

  @override
  State<MonitorDetailsPage> createState() => _MonitorDetailsPageState();
}

class _MonitorDetailsPageState extends State<MonitorDetailsPage> {
  final String _monitorCode = Get.arguments['codMonitor'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGrayBackgroundColor,
        body: Column(
          children: [
            BlocProvider(
              create: (_) => sl<MonitorDetailsBloc>()
                ..add(
                  SelectedMonitor(codMonitor: _monitorCode),
                ),
              child: DefaultTextStyle(
                  style: const TextStyle(
                    color: kDarkBlue,
                    letterSpacing: 0.2,
                    fontSize: 18,
                  ),
                  child: Expanded(
                    child: Stack(children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            repeat: ImageRepeat.noRepeat,
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/monitorbackground.jpg',
                            ),
                          ),
                        ),
                        // height: mq.height,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.9),
                                Colors.white,
                              ],
                              stops: const [
                                0.0,
                                0.5,
                                0.7
                              ]),
                        ),
                      ),
                      const MonitorDetailsView(),
                      Positioned(
                        top: 30,
                        left: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          width: 51.0,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: kMainPurpleColor,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
