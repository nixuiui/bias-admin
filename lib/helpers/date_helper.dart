import 'package:intl/intl.dart';

class DateHelper {
  
  DateTime? date;
  DateTime? startDate;
  DateTime? endDate;

  DateHelper({
    this.date,
    this.startDate,
    this.endDate
  });

  String? format({bool range = false}) {
    return formatDate(range: range, pattern: 'yyyy-MM-dd');
  }
  
  String? format2({bool range = false}) {
    return formatDate(range: range, pattern: 'EEEE, dd MMMM y');
  }
  
  String? format3({bool range = false}) {
    return formatDate(range: range, pattern: 'dd/MM/yyyy');
  }
  
  String? format4({bool range = false}) {
    return formatDate(range: range, pattern: 'dd MMMM y');
  }
  
  String? format5({bool range = false}) {
    return formatDate(range: range, pattern: 'yyyy-MM-dd HH:mm:ss');
  }

  String? formatDate({bool range = false, String? pattern}) {
    if(range) {
      if(startDate == null || endDate == null) return null;
      var start = DateFormat(pattern, 'id').format(startDate!);
      var end = DateFormat(pattern, 'id').format(endDate!);
      return '$start - $end';
    } else {
      if(date == null) return null;
      return DateFormat(pattern, 'id').format(date!);
    }
  }
  
}
