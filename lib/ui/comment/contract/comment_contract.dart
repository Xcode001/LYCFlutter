import 'package:flutter_lyc/base/data/pagination.dart';
import 'package:flutter_lyc/ui/comment/data/review.dart';
import 'package:flutter_lyc/ui/comment/data/reply.dart';

abstract class CommentContract {
  void showComments(List<Review> r);

  void showMoreComments(List<Review> r);

  void pagination(Pagination p);

  void updateReview(int position, Review review);

  void insertNewComment(Review r);

  void insertNewReply(Reply r);
}
