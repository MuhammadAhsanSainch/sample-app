class AppConstants {
  // Private Constructor to Prevent Instantiation
  AppConstants._();
  // Static Constant Fields
  static const double padding = 15;
  static const String icons = 'assets/icons';
  static const String images = 'assets/images';

  ///Icons
  static const String appLogoBlack = '$icons/app-logo-black.png';
  static const String appLogoBlackTablet = '$icons/app-logo-black-tablet.png';
  static const String appointment = '$icons/appointments.svg';
  static const String homeBottom = '$icons/home-bottom.svg';
  static const String salesBottom = '$icons/sales.svg';
  static const String employeesBottom = '$icons/employees.svg';
  static const String messagesBottom = '$icons/messages.svg';
  static const String editIcon = '$icons/pencil.svg';
  static const String trashIcon = '$icons/trash1.svg';
  static const String invoiceIcon = '$icons/invoice.svg';
  static const String emptyProfilePicture = '$icons/emptyProfileImage.jpg';
  static const String emptyProfilePictureSvg = '$icons/emptyProfileImage.svg';
  static const String sendIcon = '$icons/send.svg';


  /// Network Image
  static const String userImage =
      'https://randomuser.me/api/portraits/men/1.jpg';

  /// Drawer Icons
  static const String bankingReportsIcon = '$icons/banking-reports-icon.svg';
  static const String barberEquipmentIcon = '$icons/barber-equipment-icon.svg';
  static const String branchManagementIcon =
      '$icons/branch-management-icon.svg';
  static const String calendarManagementIcon =
      '$icons/calendar-management-icon.svg';
  static const String checkInOutIcon = '$icons/check-in-out-icon.svg';
  static const String commissionTipsIcon = '$icons/commission-tips-icon.svg';
  static const String communicationsHubIcon =
      '$icons/communications-hub-icon.svg';
  static const String complaintTrackerIcon =
      '$icons/complaint-tracker-icon.svg';
  static const String adminNotificationIcon= '$icons/admin-notification.svg';
  static const String documentRequestIcon = '$icons/document-request-icon.svg';
  static const String employeeHrModuleIcon =
      '$icons/employee-hr-module-icon.svg';
  static const String employeeManagementIcon =
      '$icons/employee-management-icon.svg';
  static const String employeeRetentionIcon =
      '$icons/employee-retention-icon.svg';
  static const String googleReviewTrackIcon =
      '$icons/google-review-track-icon.svg';
  static const String leaveTrackerIcon = '$icons/leave-tracker-icon.svg';
  static const String maintenanceLogisticsIcon =
      '$icons/maintainance-logistics-icon.svg';
  static const String monthlyFocusIcon = '$icons/monthly-focus-icon.svg';
  static const String municipalityFilesIcon =
      '$icons/municipality-files-icon.svg';
  static const String operationsReportIcon =
      '$icons/operations-report-icon.svg';
  static const String payrollModuleIcon = '$icons/payroll-module-icon.svg';
  static const String pettyCashIcon = '$icons/petty-cash-icon.svg';
  static const String productSalesReportIcon =
      '$icons/product-sales-report-icon.svg';
  static const String logoutIcon='$icons/logout.svg';

  static const String appLogoWhite = '$icons/app-logo-white.svg';
  static const String leaveRequested = '$icons/leaveRequested.svg';
  static const String leaveApproved = '$icons/leaveApproved.svg';
  static const String leaveRejected = '$icons/leaveRejected.svg';
  static const String uploadFileIcon = '$icons/file-upload-logo.svg';
  static const String downloadOutlineLogo = '$icons/download-outline-logo.svg';
  static const String totalEmployees = '$icons/total-employees.svg';
  static const String retentionRate = '$icons/retention-rate.svg';
  static const String employeeExperience = '$icons/employee-experience.svg';
  static const String averageTenure = '$icons/average-tenure.svg';
  static const String excelLogo = '$icons/excel-logo.svg';
  static const String csvLogo = '$icons/csv.svg';
  static const String pdfLogo = '$icons/pdf.svg';

  static const String employeeGoal = '$icons/employee_goal.svg';
  static const String progress = '$icons/progress.svg';
  static const String reviewsAchieved = '$icons/reviews_achieved.svg';

  static const String home = '$icons/home.svg';
  static const String menuModern = '$icons/menu.svg';
  static const String menuFormal = '$icons/menu-formal.svg';
  static const String filter = '$icons/filter.svg';
  static const String add = '$icons/add-circle.svg';
  static const String download = '$icons/download.svg';
  static const String documentDownload = '$icons/document-download.svg';
  static const String uploadDocIcon = '$icons/upload-image-icon.svg';
  static const String search = '$icons/search.svg';
  static const String light = '$icons/light.svg';
  static const String dark = '$icons/dark.svg';
  static const String edit = '$icons/edit.svg';
  static const String view = '$icons/view.svg';
  static const String delete = '$icons/trash.svg';
  static const String remove = '$icons/remove.svg';
  static const String date = '$icons/date.svg';
  static const String time = '$icons/time.svg';
  static const String location = '$icons/location.svg';
  static const String phone = '$icons/phone.svg';
  static const String notification = '$icons/notification.svg';
  static const String notificationFilled = '$icons/notification-filled.svg';
  static const String dateFilter = '$icons/date-filter.svg';
  static const String sort = '$icons/sort.svg';
  static const String profile = '$icons/profile-circle.png';
  static const String profilePicture = '$icons/profileImage.svg';
  static const String person = '$icons/profile-circle.svg';
  static const String pause = '$icons/pause.svg';
  static const String reset = '$icons/reset.svg';
  static const String lock = '$icons/lock.svg';
  static const String eye = '$icons/eye.svg';
  static const String chartLineUp = '$icons/chart-line-up.svg';
  static const String chartLineDown = '$icons/chart-line-down.svg';
  static const String eyeSlash = '$icons/eye-slash.svg';
  static const String noDataFound = '$icons/no-data-found.png';
  static const String done = '$icons/done-icon.svg';
  static const String warning = '$icons/warning-icon.svg';

  /// Sales Reports Icons
  static const String monthlyPerformance = '$icons/monthly-performance.svg';
  static const String dailyDales = '$icons/daily-sales.svg';
  static const String productStock = '$icons/product-stock.svg';
  static const String individualPerformance = '$icons/individual-performance.svg';
  static const String teamPerformance = '$icons/team-performance.svg';


  // text-fields input whitelisting
  static const Pattern emailFilterPattern = r'[a-zA-Z0-9@._-]';
  static const Pattern passwordFilterPattern =
      r'[a-zA-Z0-9!#\$%^&*()=+~`<>,/?:;"|\\@._-]';
  static const Pattern nameFilterPattern = r'[a-zA-Z]+|\s';
  static const Pattern numberFilterPattern = r'[0-9]';
}
