class APIs {
  static const base =
      "https://test-alpha-ecom.developmentalphawizz.com/api/v2/delivery-man/";
  static const v1Base =
      "https://test-alpha-ecom.developmentalphawizz.com/api/v1/";

  static const sendOtp = "${base}auth/send-otp";
  static const sendOtpReg = "${base}auth/register-otp";
  static const register = "${base}auth/register";
  static const uploadProfileImage = "${base}edit-profile-image";
  static const loginMail = "${base}auth/login";
  static const profile = "${base}info";
  static const orders = "${base}current-orders?delivery_type=all";
  static const staticPages = "${base}static-pages";
  static const alphaOrders =
      "${base}current-orders?delivery_type=alpha_delivery";
  static const ordersDetail = "${base}order-details?order_id=";
  static const newOrders = "${base}new-orders";
  static const allOrders =
      "${base}all-status-orders?delivery_type=all&order_status=";
  static const orderAction = "${base}order-accept-reject";
  static const updatePaymentStatus = "${base}update-order-status";
  static const reviews = "${base}review-list?limit=25&offset=0";
  static const scheduleDelivery = "${base}update-expected-delivery";
  static const notifications = "${base}notifications?limit=20&offset=0";
  static const chatMessages =
      "${base}messages/get-message/admin/0?offset=0&limit=10000";
  static const transactionHistory =
      "${base}wallet_transaction_history?offset=0&limit=25";
  static const withdrawRequests =
      "${base}withdraw-list-by-approved?offset=0&limit=25";

  static const cancelOrder = "${base}update-order-cancel-status";
  static const withdrawMoney = "${base}withdraw-request";
  static const sendChat = "${base}messages/send-message/admin";
  static const editVehicleProfile = "${base}edit-vehicle-profile";
  static const editPassword = "${base}edit-password";
  static const resetPassword = "${base}auth/reset-password";
  static const deleteAccount = "${base}delete-account";

  static const editAddress = "${base}edit-address";
  static const editDrivingProfile = "${base}edit-driving-profile";
  static const editBankInfo = "${base}edit-bank_info";

  //v1
  static const countryList = "${v1Base}countries";
  static const stateList = "${v1Base}states?country_id=";
  static const citiesList = "${v1Base}cities?state_id=";
}
