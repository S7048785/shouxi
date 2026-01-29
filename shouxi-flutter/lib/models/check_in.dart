/// 当天签到信息
class CheckInInfo {
  bool is_checkin;
  DateTime checkin_time;

  CheckInInfo({
    required this.is_checkin,
    required this.checkin_time,
  });
}

/// 签到统计
class CheckStats {
  int total;
  int monthCount;
  bool todayCheckedIn;

  CheckStats({
    required this.total,
    required this.monthCount,
    required this.todayCheckedIn,
  });

  factory CheckStats.fromJson(Map<String, dynamic> json) => CheckStats(
    total: json['total'],
    monthCount: json['month_count'],
    todayCheckedIn: json['today_checked_in'],
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'month_count': monthCount,
    'today_checked_in': todayCheckedIn,
  };
}
