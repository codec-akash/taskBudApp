import 'package:intl/intl.dart';

class DateUtil {
  numberLiteral(val) => NumberFormat("##,##,###").format(val);

  dateformatymd(val) => DateFormat('yyyy-MM-dd').format(val);

  dateformatDefault1(val) => DateFormat().format(val);
  // dateformatDefault(val) => DateFormat("kk:mm:a").add_MMMMEEEEd().format(val);
  dateformatDefault(val) => DateFormat("MMM, d/y -").add_jm().format(val);
}
