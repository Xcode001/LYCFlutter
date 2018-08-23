import 'package:flutter_lyc/ui/doctors/data/doctor.dart';
import 'package:flutter_lyc/ui/comment/data/comment.dart';
import 'package:flutter_lyc/ui/home/data/booking.dart';
import 'package:flutter_lyc/ui/doctors/data/active_booking.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_profile.g.dart';

@JsonSerializable()
class DoctorProfile extends Object with _$DoctorProfileSerializerMixin {
  Doctor doctor;
  ActiveBooking activeBooking;
  List<Booking> booking;
  Comment reviews;

  DoctorProfile(this.doctor, this.activeBooking/*, this.booking, this.reviews*/);


  @override
  String toString() {
    return 'DoctorProfile{doctor: $doctor, activeBooking: $activeBooking, booking: $booking, reviews: $reviews}';
  }

  factory DoctorProfile.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileFromJson(json);
}
