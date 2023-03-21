String time() {
  int m = DateTime.now().minute;
  int h = DateTime.now().hour;
  int d = DateTime.now().day;
  int n = DateTime.now().month;
  int y = DateTime.now().year;

  String min = m > 9 ? '$m' : '0$m';
  String hr = h > 9 ? '$h' : '0$h';
  String day = d > 9 ? '$d' : '0$d';
  String mounth = n > 9 ? '$n' : '0$n';
  String yr = y > 9 ? '$y' : '0$y';

  return '$day/$mounth/$yr  $hr:$min';
}
