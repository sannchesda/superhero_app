class ApiRoute {
  /// Register
  static const String selfRegister = "user/store";
  static const String register = "user-detail/store";

  /// Login
  static const String validatePhoneNumber = "auth/verify-phone-number";
  static const String sendOtp = "otp/request";
  static const String verifyOtp = "auth/otp_verification";

  /// User
  static const String userDetail = "user/detail";
  static const String updateUserDetail = "user-detail/update";

  /// Master Data
  static const String userTitles = "user-titles";
  static const String organizations = "organizations";
  static const String positions = "org-positions";
  static const String partyPositions = "party-positions";
  static const String provinces = "address/provinces";
  static const String missionDescription = "post-activity-categories";
  static const String eventCategory = "event-categories";
  static const String saveUserTitle = "user-title/store";
  static const String saveOrganization = "organization/store";
  static const String savePosition = "org-position/store";
  static const String savePartyPosition = "party-position/store";
  static const String saveMissionDescription = "post-activity-category/store";
  static const String saveEventCategories = "event-categories/store";

  static String districts(String provinceId) {
    return "address/provinces/$provinceId/districts";
  }

  static String communes(String districtId) {
    return "address/provinces/district/$districtId/communes";
  }

  static String villages(String communesId) {
    return "address/provinces/district/commune/$communesId/village";
  }

  /// Member
  static const String addMember = "member/store";

  static String getListMembers({
    required int perPage,
    required int page,
    String search = "",
  }) {
    return "members?perPage=$perPage&page=$page&search=$search";
  }

  static String memberDetail(String userId) => "user-detail/show/$userId";

  static const String editMemberDetail = "user-detail/update";

  /// Activity
  static const String addActivity = "activity/post";

  static String userActivities({
    required int perPage,
    required int page,
    String search = "",
  }) {
    return "user/activities?perPage=$perPage&page=$page&search=$search";
  }

  ///activity/:id
  static String getActivityById(int missionId) {
    return "activity/$missionId";
  }

  /// activitiesByUser
  static String getActivityByUser({
    required int perPage,
    required int page,
    String search = "",
    required int userId,
    required String startDate,
    required String endDate,
  }) {
    return "post-activities-filter-by-user"
        "?perPage=$perPage&"
        "page=$page&"
        "search=$search&"
        "user_id=$userId&"
        "start_date=$startDate&"
        "end_date=$endDate";
  }

  /// Image
  static const String uploadImage = "media/store";

  /// Summary Data (Filter / Member Below data)
  /// summary
  static String summary(String startDate, String endDate) {
    return "post-activities-filter?start_date=$startDate&end_date=$endDate";
  }

  static String summaryDetail(String startDate, String endDate) {
    return "post-activities-filter-detail?start_date=$startDate&end_date=$endDate";
  }

  /// Id Card
  static const String insertIdCard = "card/store";
  static const String getIdCard = "card/user";

  /// User File
  static const String uploadUserFile = "user/file-upload";

  static String getUserFiles(int perPage, int page, {String search = ""}) {
    return "user/personal_documents/?perPage=$perPage&page=$page&search=$search";
  }

  static String deleteFile(int fileId) {
    return "user/personal_documents/$fileId";
  }

  /// Report
  static const String memberReport = "dashboard";

  /// Calendar
  static const String addEvent = "schedule-event/store";
  static const String updateEvent = "schedule-event/update";

  static String deleteEvent({required String eventId}) {
    return "schedule-event/destroy/$eventId";
  }

  static String getScheduleEvent({
    required String month,
    required String year,
    required String type,
    String userId = "",
  }) {
    return "schedule-event/calender-schedule-events"
        "?month=$month"
        "&year=$year"
        "&type=$type"
        "&user_id=$userId";
  }

  static String getScheduleEventDetail({
    required String month,
    required String year,
    String type = "ALL",
    String userId = "",
  }) {
    return "schedule-event/list"
        "?month=$month"
        "&year=$year"
        "&type=$type"
        "&user_id=$userId";
  }

  static String getEventDetail({required String eventId}) {
    return "schedule-event/paticipants/$eventId";
  }
}
