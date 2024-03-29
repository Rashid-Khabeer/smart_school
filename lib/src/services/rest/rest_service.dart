import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart' as rt;
import 'package:smart_school/src/data/models/attendance_model.dart';
import 'package:smart_school/src/data/models/download_model.dart';
import 'package:smart_school/src/data/models/examination_model.dart';
import 'package:smart_school/src/data/models/fee_model.dart';
import 'package:smart_school/src/data/models/forgot-password_model.dart';
import 'package:smart_school/src/data/models/home-work_model.dart';
import 'package:smart_school/src/data/models/hostel_model.dart';
import 'package:smart_school/src/data/models/lesson-plan_model.dart';
import 'package:smart_school/src/data/models/library_model.dart';
import 'package:smart_school/src/data/models/live-class_model.dart';
import 'package:smart_school/src/data/models/modules_model.dart';
import 'package:smart_school/src/data/models/notice-board_model.dart';
import 'package:smart_school/src/data/models/notification_model.dart';
import 'package:smart_school/src/data/models/online-exam_model.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/data/models/student-syllabus_model.dart';
import 'package:smart_school/src/data/models/tasks_model.dart';
import 'package:smart_school/src/data/models/teachers_model.dart';
import 'package:smart_school/src/data/models/time-table_model.dart';
import 'package:smart_school/src/data/models/transport_model.dart';
import 'package:smart_school/src/services/rest/_client.dart';

part 'rest_service.g.dart';

@rt.RestApi(baseUrl: '')
abstract class RestService {
  factory RestService() => _RestService(dioClient);

  @rt.POST('/auth/login')
  Future<SignInResponse> signIn(@rt.Body() SignInRequest data);

  @rt.POST('/webservice/forgot_password')
  Future<ForgotPasswordResponse> forgotPassword({
    @rt.Body() ForgotPasswordRequest request,
  });

  @rt.POST('/webservice/logout')
  Future<SignOutResponse> signOut({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() SignOutRequest request,
  });

  @rt.POST('/webservice/getModuleStatus')
  Future<Modules> getModule({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() ModuleRequest request,
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

  @rt.POST('/webservice/addaa')
  @rt.MultiPart()
  Future<dynamic> addHomeWork({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Part() File file,
    // ignore: non_constant_identifier_names
    @rt.Part() String student_id,
    // ignore: non_constant_identifier_names
    @rt.Part() String homework_id,
    @rt.Part() String message,
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

  @rt.POST('/webservice/getAttendenceRecords')
  Future<Attendance> getAttendance({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() AttendanceRequest request,
  });

  @rt.POST('/webservice/getExamList')
  Future<Examination> getExamination({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.POST('/webservice/getExamSchedule')
  Future<ExamSchedule> getExamSchedule({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() ExamScheduleRequest request,
  });

  @rt.POST('/webservice/getExamResult')
  Future<ExamResult> getExamResult({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() ExamResultRequest request,
  });

  @rt.POST('/webservice/getTeachersList')
  Future<Teachers> getTeachersList({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() TeachersRequest request,
  });

  @rt.POST('/webservice/addStaffRating')
  Future<RatingResponse> teacherRate({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() TeacherRatingRequest request,
  });

  @rt.POST('/webservice/getNotifications')
  Future<NoticeBoard> getNoticeBoard({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() NoticeBoardRequest request,
  });

  @rt.POST('/webservice/getTransportRoute')
  Future<List<Transport>> getTransport({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() StudentRequest request,
  });

  @rt.GET('/webservice/getHostelList')
  Future<Hostel> getHostel({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
  });

  @rt.POST('/webservice/getHostelDetails')
  Future<HostelDetail> getHostelDetail({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() HostelDetailRequest request,
  });

  @rt.POST('/webservice/getTask')
  Future<Tasks> getTasks({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() TasksRequest request,
  });

  @rt.POST('/webservice/addTask')
  Future<RatingResponse> addTask({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() AddTask request,
  });

  @rt.POST('/webservice/updateTask')
  Future<RatingResponse> updateTask({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() UpdateTask request,
  });

  @rt.POST('/webservice/deleteTask')
  Future<RatingResponse> deleteTask({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() DeleteTask request,
  });

  @rt.POST('/webservice/getNotifications')
  Future<Notifications> getNotifications({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() NotificationRequest request,
  });

  @rt.POST('/webservice/getLibraryBookIssued')
  Future<dynamic> getIssuedBooks({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
    @rt.Body() LibraryRequest request,
  });

  @rt.GET('/webservice/getLibraryBooks')
  Future<LibraryBooks> getBooks({
    @rt.Header('User-Id') String userId,
    @rt.Header('Authorization') String authKey,
  });
}
