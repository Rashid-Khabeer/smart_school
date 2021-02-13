import 'package:dio/dio.dart';
import 'package:retrofit/http.dart' as rt;
import 'package:smart_school/src/data/models/download_model.dart';
import 'package:smart_school/src/data/models/fee_model.dart';
import 'package:smart_school/src/data/models/home-work_model.dart';
import 'package:smart_school/src/data/models/hostel_model.dart';
import 'package:smart_school/src/data/models/lesson-plan_model.dart';
import 'package:smart_school/src/data/models/live-class_model.dart';
import 'package:smart_school/src/data/models/notice-board_model.dart';
import 'package:smart_school/src/data/models/online-exam_model.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/data/models/student-syllabus_model.dart';
import 'package:smart_school/src/data/models/time-table_model.dart';
import 'package:smart_school/src/data/models/transport_model.dart';
import 'package:smart_school/src/services/rest/_client.dart';

part 'rest_service.g.dart';

@rt.RestApi(baseUrl: '')
abstract class RestService {
  factory RestService() => _RestService(dioClient);

  @rt.POST('/auth/login')
  Future<SignInResponse> signIn(@rt.Body() SignInRequest data);

  @rt.POST('/webservice/logout')
  Future<SignOutResponse> signOut({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() SignOutRequest request,
  });

  @rt.POST('/webservice/getStudentProfile')
  Future<StudentProfile> getProfile({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/getHomework')
  Future<HomeWork> getHomeWork({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/fees')
  Future<Fee> getFee({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/liveclasses')
  Future<LiveClass> getLiveClass({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/livehistory')
  Future<LiveClassHistory> getLiveClassHistory({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() LiveClassRequest request,
  });

  @rt.POST('/webservice/class_schedule')
  Future<TimeTable> getTimeTable({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/getsyllabussubjects')
  Future<Syllabus> getSyllabus({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/getSubjectsLessons')
  Future<List<SyllabusDetail>> getSyllabusDetail({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() SyllabusDetailRequest request,
  });

  @rt.POST('/webservice/getOnlineExam')
  Future<OnlineExam> getOnlineExam({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/getlessonplan')
  Future<LessonPlan> getLessonPlans({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() LessonPlanRequest request,
  });

  @rt.POST('/webservice/getsyllabus')
  Future<LessonPlanDetails> getLessonPlanDetails({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() LessonPlanDetailsRequest request,
  });

  @rt.POST('/webservice/getDownloadsLinks')
  Future<Downloads> getDownloads({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() DownloadRequest request,
  });

  @rt.POST('/webservice/getNotifications')
  Future<NoticeBoard> getNoticeBoard({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() NoticeBoardRequest request,
  });

  @rt.POST('/webservice/getTransportRoute')
  Future<Transport> getTransport({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() NoticeBoardRequest request,
  });

  @rt.POST('/webservice/getHostelList')
  Future<Hostel> getHostel({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() NoticeBoardRequest request,
  });
}
