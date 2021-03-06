import 'package:flutter_lyc/ui/home/repository/home_repository.dart';
import 'package:flutter_lyc/ui/home/repository/home_data_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_profile_data_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_profile_repository.dart';
import 'package:flutter_lyc/ui/home/repository/feature_articles_repository.dart';
import 'package:flutter_lyc/ui/home/repository/feature_articles_data_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_list_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_list_data_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_booking_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_booking_data_repository.dart';
import 'package:flutter_lyc/ui/home/repository/health_education_repository.dart';
import 'package:flutter_lyc/ui/home/repository/health_education_data_repository.dart';
import 'package:flutter_lyc/ui/home/repository/user_booking_repository.dart';
import 'package:flutter_lyc/ui/home/repository/user_booking_data_repository.dart';
import 'package:flutter_lyc/ui/home/repository/user_saved_repository.dart';
import 'package:flutter_lyc/ui/home/repository/user_saved_data_repository.dart';
import 'package:flutter_lyc/ui/home/repository/user_activity_repository.dart';
import 'package:flutter_lyc/ui/home/repository/user_activity_data_repository.dart';
import 'package:flutter_lyc/ui/article/repository/article_details_repository.dart';
import 'package:flutter_lyc/ui/article/repository/article_details_data_repository.dart';
import 'package:flutter_lyc/ui/article/repository/video_details_repository.dart';
import 'package:flutter_lyc/ui/article/repository/video_details_data_repository.dart';
import 'package:flutter_lyc/ui/comment/repository/comment_reply_repository.dart';
import 'package:flutter_lyc/ui/comment/repository/comment_reply_data_repository.dart';
import 'package:flutter_lyc/ui/comment/repository/comment_repository.dart';
import 'package:flutter_lyc/ui/comment/repository/comment_data_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_filter_repository.dart';
import 'package:flutter_lyc/ui/doctors/repository/doctor_filter_data_repository.dart';
import 'package:flutter_lyc/ui/home/repository/health_education_filter_repository.dart';
import 'package:flutter_lyc/ui/home/repository/health_education_filter_data_repository.dart';
import 'package:flutter_lyc/ui/service/repository/services_repository.dart';
import 'package:flutter_lyc/ui/service/repository/services_data_repository.dart';
import 'package:flutter_lyc/ui/service/repository/sub_services_details_repository.dart';
import 'package:flutter_lyc/ui/service/repository/sub_services_details_data_repository.dart';
import 'package:flutter_lyc/ui/notification/repository/notification_data_repository.dart';
import 'package:flutter_lyc/ui/notification/repository/notification_repository.dart';
import 'package:flutter_lyc/ui/about/repository/about_data_repository.dart';
import 'package:flutter_lyc/ui/about/repository/about_repository.dart';
import 'package:flutter_lyc/ui/chat/repository/chat_repository.dart';
import 'package:flutter_lyc/ui/chat/repository/chat_data_repository.dart';
import 'package:flutter_lyc/ui/otheruser/repository/other_user_repository.dart';
import 'package:flutter_lyc/ui/otheruser/repository/other_user_data_repository.dart';
import 'package:flutter_lyc/ui/comment/repository/comment_eidt_data_repository.dart';
import 'package:flutter_lyc/ui/comment/repository/comment_eidt_repository.dart';
import 'package:flutter_lyc/ui/home/repository/profile_info_repository.dart';
import 'package:flutter_lyc/ui/home/repository/profile_info_data_repository.dart';
import 'package:flutter_lyc/ui/login/repository/login_repository.dart';
import 'package:flutter_lyc/ui/login/repository/login_data_repository.dart';
import 'package:flutter_lyc/ui/home/repository/location_repository.dart';
import 'package:flutter_lyc/ui/home/repository/location_data_repository.dart';
import 'package:flutter_lyc/ui/base/repository/home_container_repository.dart';
import 'package:flutter_lyc/ui/base/repository/home_container_data_repository.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  HomeContractRepository get homeContractRepository {
    return new HomeDataRepository();
  }

  HomeContainerRepository get homeContainerRepository{
    return new HomeContainerDataRepository();
  }

  DoctorProfileRepository get doctorProfileRepository {
    return new DoctorProfileDataRepository();
  }

  FeatureArticlesRepository get featureArticlesRepository {
    return new FeatureArticlesDataRepository();
  }

  DoctorListRepository get doctorListRepository {
    return new DoctorListDataRepository();
  }

  DoctorBookingRepository get doctorBookingRepository {
    return new DoctorBookingDataRepository();
  }

  HealthEducationRepository get healthEducationRepository {
    return new HealthEducationDataRepository();
  }

  UserBookingRepository get userBookingRepository {
    return new UserBookingDataRepository();
  }

  UserSavedRepository get userSavedRepository {
    return new UserSavedDataRepository();
  }

  UserActivityRepository get userActivityRepository {
    return new UserActivityDataRepository();
  }

  ArticleDetailsRepository get articleDetailsRepository {
    return new ArticleDetailsDataRepository();
  }

  VideoDetailsRepository get videoDetailsRepository {
    return new VideoDetailsDataRepository();
  }

  CommentReplyRepository get commentReplyRepository {
    return new CommentReplyDataRepository();
  }

  CommentRepository get commentRepository {
    return new CommentDataRepository();
  }

  DoctorFilterRepository get doctorFilterRepository {
    return new DoctorFilterDataRepository();
  }

  HealthEducationFilterRepository get healthEducationFilterRepository {
    return new HealthEducationFilterDataRepository();
  }

  ServicesRepository get servicesRepository {
    return new ServicesDataRepository();
  }

  SubServicesDetailsRepository get subServicesDetailsRepository {
    return new SubServicesDetailsDataRepository();
  }

  NotificationRepository get notificationRepository {
    return new NotificationDataRepository();
  }

  AboutRepository get aboutRepository {
    return new AboutDataRepository();
  }

  ChatRepository get chatRepository {
    return new ChatDataRepository();
  }

  OtherUserRepository get otherUserRepository {
    return new OtherUserDataRepository();
  }

  CommentEditRepository get commentEditRepository {
    return new CommentEditDataRepository();
  }

  ProfileInfoRepository get profileInfoRepository {
    return new ProfileInfoDataRepository();
  }

  LoginRepository get loginRepository{
    return new LoginDataRepository();
  }

  LocationRepository get locationRepository{
    return new LocationDataRepository();
  }

}
//DI
