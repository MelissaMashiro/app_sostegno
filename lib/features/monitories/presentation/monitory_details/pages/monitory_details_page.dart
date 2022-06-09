import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitories/presentation/monitory_details/bloc/monitory_details_bloc.dart';
import 'package:app_sostegno/features/monitories/presentation/monitory_details/widgets/monitory_details_view.dart';
import 'package:app_sostegno/injection_container.dart';

class MonitoryDetailsPage extends StatefulWidget {
  const MonitoryDetailsPage({Key? key}) : super(key: key);

  @override
  State<MonitoryDetailsPage> createState() => _MonitoryDetailsPageState();
}

class _MonitoryDetailsPageState extends State<MonitoryDetailsPage> {
  final AvailableMonitory _monitorySelected = Get.arguments['monitorySelected'];

  final int _personType = Get.arguments['personType'] ?? 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGrayBackgroundColor,
        body: Column(
          children: [
            PurpleHeader(
              title: 'Monitoría No.${_monitorySelected.id}',
              onPressed: () {
                Get.back();
              },
              icon: Icons.arrow_back,
            ),
            BlocProvider(
              create: (_) => sl<MonitoryDetailsBloc>(),
              child: MonitoryDetailsView(
                monitorySelected: _monitorySelected,
                personType: _personType,
              ),
            )
          ],
        ),
      ),
    );
  }
}
