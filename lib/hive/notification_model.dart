import 'package:hive/hive.dart';
// name should be same as this class.dart
part 'notification_model.g.dart';

//unique id
@HiveType(typeId: 0)
class NotificationModel {
//unique id
  @HiveField(0)
  final String title;
//unique id
  @HiveField(1)
  final String detail;
//unique id
  @HiveField(2)
  final bool isCompleted;
  @HiveField(3)
  final String url;
  NotificationModel(
      {required this.title,
      required this.detail,
      required this.isCompleted,
      required this.url});
}
