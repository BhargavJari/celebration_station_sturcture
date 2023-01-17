class ApiEndPoints{
  static const String baseUrl ="https://celebrationstation.in/";
  static const String getUrl ="get_ajax/";
  static const String postUrl ="post_ajax/";
  static const String loginApi ="${baseUrl}${getUrl}login/";
  static const String updateProfileApi ="${baseUrl}${postUrl}update_profile/";
  static const String getProfileRecordApi ="${baseUrl}${getUrl}get_profile_record/";
  static const String addEnquiryApi ="${baseUrl}${postUrl}add_enquiry/";
  static const String getAllApi ="${baseUrl}${getUrl}get_all_enquiry/";
}
