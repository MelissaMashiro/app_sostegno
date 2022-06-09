
class MonitorDetails {
  MonitorDetails({
    required this.codigo,
    required this.name,
    required this.semester,
    required this.materiasList,
    required this.totalMonitories,
  });

  String codigo;
  String name;
  int semester;
  List<String> materiasList;
  int totalMonitories;
}
