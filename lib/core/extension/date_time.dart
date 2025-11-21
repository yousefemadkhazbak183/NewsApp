extension DateTimeFormat on DateTime {
  String formatDateTime() {
    final differenceTime = DateTime.now().difference(this);

    if (differenceTime.inMinutes < 60) {
      return "${differenceTime.inMinutes} m ago.";
    }
    if (differenceTime.inHours < 24) {
      return "${differenceTime.inHours} h ago.";
    }
    return "${differenceTime.inDays} d ago.";
  }
}
