class Setting {
  bool? status;
  Data? data;

  Setting({this.status, this.data});

  Setting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? androidPrivacyPolicy;
  String? androidTermsAndCondition;
  String? androidAppShareLink;
  String? androidDefaultPage;
  String? androidAppPublishingControl;
  String? androidLiveVersionCode;
  String? androidAdsType;
  String? androidClickControl;
  String? androidGappId;
  String? androidGappopenAdsCode;
  String? androidGbannerAdsCode;
  String? androidGinterstitialAdsCode;
  String? androidGnativeAdsCode;
  String? androidGrewardedAdsCode;
  String? androidVersionName;
  String? androidVersionCode;
  String? androidForceUpdate;
  String? androidAppUrl;
  String? androidButtonText;
  String? androidDescription;
  String? iosPrivacyPolicy;
  String? iosTermsAndCondition;
  String? iosAppShareLink;
  String? iosAppRatingLink;
  String? iosDefaultPage;
  String? iosAppPublishingControl;
  String? iosLiveVersionCode;
  String? iosAdsType;
  String? iosClickControl;
  String? iosGappId;
  String? iosGappopenAdsCode;
  String? iosGbannerAdsCode;
  String? iosGinterstitialAdsCode;
  String? iosGnativeAdsCode;
  String? iosGrewardedAdsCode;
  String? iosVersionName;
  String? iosVersionCode;
  String? iosForceUpdate;
  String? iosAppUrl;
  String? iosButtonText;
  String? iosDescription;
  String? ip;

  Data(
      {this.androidPrivacyPolicy,
      this.androidTermsAndCondition,
      this.androidAppShareLink,
      this.androidDefaultPage,
      this.androidAppPublishingControl,
      this.androidLiveVersionCode,
      this.androidAdsType,
      this.androidClickControl,
      this.androidGappId,
      this.androidGappopenAdsCode,
      this.androidGbannerAdsCode,
      this.androidGinterstitialAdsCode,
      this.androidGnativeAdsCode,
      this.androidGrewardedAdsCode,
      this.androidVersionName,
      this.androidVersionCode,
      this.androidForceUpdate,
      this.androidAppUrl,
      this.androidButtonText,
      this.androidDescription,
      this.iosPrivacyPolicy,
      this.iosTermsAndCondition,
      this.iosAppShareLink,
      this.iosAppRatingLink,
      this.iosDefaultPage,
      this.iosAppPublishingControl,
      this.iosLiveVersionCode,
      this.iosAdsType,
      this.iosClickControl,
      this.iosGappId,
      this.iosGappopenAdsCode,
      this.iosGbannerAdsCode,
      this.iosGinterstitialAdsCode,
      this.iosGnativeAdsCode,
      this.iosGrewardedAdsCode,
      this.iosVersionName,
      this.iosVersionCode,
      this.iosForceUpdate,
      this.iosAppUrl,
      this.iosButtonText,
      this.iosDescription,
      this.ip});

  Data.fromJson(Map<String, dynamic> json) {
    androidPrivacyPolicy = json['android_privacy_policy'];
    androidTermsAndCondition = json['android_terms_and_condition'];
    androidAppShareLink = json['android_app_share_link'];
    androidDefaultPage = json['android_default_page'];
    androidAppPublishingControl = json['android_app_publishing_control'];
    androidLiveVersionCode = json['android_live_version_code'];
    androidAdsType = json['android_ads_type'];
    androidClickControl = json['android_click_control'];
    androidGappId = json['android_gapp_id'];
    androidGappopenAdsCode = json['android_gappopen_ads_code'];
    androidGbannerAdsCode = json['android_gbanner_ads_code'];
    androidGinterstitialAdsCode = json['android_ginterstitial_ads_code'];
    androidGnativeAdsCode = json['android_gnative_ads_code'];
    androidGrewardedAdsCode = json['android_grewarded_ads_code'];
    androidVersionName = json['android_version_name'];
    androidVersionCode = json['android_version_code'];
    androidForceUpdate = json['android_force_update'];
    androidAppUrl = json['android_app_url'];
    androidButtonText = json['android_button_text'];
    androidDescription = json['android_description'];
    iosPrivacyPolicy = json['ios_privacy_policy'];
    iosTermsAndCondition = json['ios_terms_and_condition'];
    iosAppShareLink = json['ios_app_share_link'];
    iosAppRatingLink = json['ios_app_rating_link'];
    iosDefaultPage = json['ios_default_page'];
    iosAppPublishingControl = json['ios_app_publishing_control'];
    iosLiveVersionCode = json['ios_live_version_code'];
    iosAdsType = json['ios_ads_type'];
    iosClickControl = json['ios_click_control'];
    iosGappId = json['ios_gapp_id'];
    iosGappopenAdsCode = json['ios_gappopen_ads_code'];
    iosGbannerAdsCode = json['ios_gbanner_ads_code'];
    iosGinterstitialAdsCode = json['ios_ginterstitial_ads_code'];
    iosGnativeAdsCode = json['ios_gnative_ads_code'];
    iosGrewardedAdsCode = json['ios_grewarded_ads_code'];
    iosVersionName = json['ios_version_name'];
    iosVersionCode = json['ios_version_code'];
    iosForceUpdate = json['ios_force_update'];
    iosAppUrl = json['ios_app_url'];
    iosButtonText = json['ios_button_text'];
    iosDescription = json['ios_description'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['android_privacy_policy'] = androidPrivacyPolicy;
    data['android_terms_and_condition'] = androidTermsAndCondition;
    data['android_app_share_link'] = androidAppShareLink;
    data['android_default_page'] = androidDefaultPage;
    data['android_app_publishing_control'] = androidAppPublishingControl;
    data['android_live_version_code'] = androidLiveVersionCode;
    data['android_ads_type'] = androidAdsType;
    data['android_click_control'] = androidClickControl;
    data['android_gapp_id'] = androidGappId;
    data['android_gappopen_ads_code'] = androidGappopenAdsCode;
    data['android_gbanner_ads_code'] = androidGbannerAdsCode;
    data['android_ginterstitial_ads_code'] = androidGinterstitialAdsCode;
    data['android_gnative_ads_code'] = androidGnativeAdsCode;
    data['android_grewarded_ads_code'] = androidGrewardedAdsCode;
    data['android_version_name'] = androidVersionName;
    data['android_version_code'] = androidVersionCode;
    data['android_force_update'] = androidForceUpdate;
    data['android_app_url'] = androidAppUrl;
    data['android_button_text'] = androidButtonText;
    data['android_description'] = androidDescription;
    data['ios_privacy_policy'] = iosPrivacyPolicy;
    data['ios_terms_and_condition'] = iosTermsAndCondition;
    data['ios_app_share_link'] = iosAppShareLink;
    data['ios_app_rating_link'] = iosAppRatingLink;
    data['ios_default_page'] = iosDefaultPage;
    data['ios_app_publishing_control'] = iosAppPublishingControl;
    data['ios_live_version_code'] = iosLiveVersionCode;
    data['ios_ads_type'] = iosAdsType;
    data['ios_click_control'] = iosClickControl;
    data['ios_gapp_id'] = iosGappId;
    data['ios_gappopen_ads_code'] = iosGappopenAdsCode;
    data['ios_gbanner_ads_code'] = iosGbannerAdsCode;
    data['ios_ginterstitial_ads_code'] = iosGinterstitialAdsCode;
    data['ios_gnative_ads_code'] = iosGnativeAdsCode;
    data['ios_grewarded_ads_code'] = iosGrewardedAdsCode;
    data['ios_version_name'] = iosVersionName;
    data['ios_version_code'] = iosVersionCode;
    data['ios_force_update'] = iosForceUpdate;
    data['ios_app_url'] = iosAppUrl;
    data['ios_button_text'] = iosButtonText;
    data['ios_description'] = iosDescription;
    data['ip'] = ip;
    return data;
  }
}
