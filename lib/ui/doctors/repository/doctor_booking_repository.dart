import 'dart:async';
import 'package:flutter_lyc/ui/doctors/data/active_booking.dart';
import 'package:flutter_lyc/ui/doctors/data/booking_request.dart';
import 'package:flutter_lyc/ui/doctors/data/schedule.dart';
import 'package:flutter_lyc/base/data/message.dart';

abstract class DoctorBookingRepository {
  Future<ActiveBooking> getBookingDetail(String accessCode, int doctorId);

  Future<ActiveBooking> checkBooking(String accessCode, int doctorId, DateTime date,
      List<Schedule> scheduleList);

  Future<BookingRequest> requestBooking(String accessCode, int doctorId, int schedule,
      String date);

  Future<Message> cancelBooking(String accessCode, int doctorId, int bookingId);

  void setActiveBooking(ActiveBooking activeBooking);

  void setAvailableDates(List<Schedule>scheduleList);
}