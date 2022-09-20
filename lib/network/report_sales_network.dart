import 'package:basalon/modal/report_model.dart';

import '../services/api_provider/api_provider.dart';

class ReportSalesNetwork {
  ReportModel? reportModel;

  Future getReportSales(range, userId) async {
    try {
      final response = await ApiProvider.get(
          'get_report_sales?user_id=$userId&range=$range');
      final result = ReportModel.fromJson(response['body']);
      reportModel = result;
      print(response);
      print(reportModel?.data?.chart?.chart);
      print(reportModel?.data?.chart?.chart?.length);
    } catch (e) {
      print('nhi aayi reports !!!!!!!!!!');
      print(e);
    }
    return reportModel;
  }
}
