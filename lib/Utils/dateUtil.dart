import 'package:intl/intl.dart';

class DateUtil {
  numberLiteral(val) => NumberFormat("##,##,###").format(val);

  dateformatymd(val) => DateFormat('yyyy-MM-dd').format(val);

  dateformatDefault(val) => DateFormat.yMMMMd().format(val);
}
