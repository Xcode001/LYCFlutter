import 'package:flutter/material.dart';
import 'package:flutter_lyc/utils/configs.dart';
import 'package:flutter_lyc/base/mystyle.dart';
import 'package:flutter_lyc/ui/comment/data/review.dart';
import 'package:flutter_lyc/ui/comment/data/reply.dart';
import 'package:flutter_lyc/ui/comment/presenter/comment_eidt_presenter.dart';
import 'package:flutter_lyc/ui/comment/contract/comment_edit_contract.dart';

class CommentEditDialogPage extends StatefulWidget {
  final Review mReview;
  final Reply mReply;
  final int mArticleId;
  final int mDoctorId;
  final int mReviewId;
  final OnCommentUpdateListener listener;

  CommentEditDialogPage(
    this.listener, {
    this.mReview,
    this.mReply,
    this.mArticleId,
    this.mDoctorId,
    this.mReviewId,
  });

  @override
  CommentEditDialogPageState createState() {
    // TODO: implement createState
    return new CommentEditDialogPageState();
  }
}

class CommentEditDialogPageState extends State<CommentEditDialogPage>
    implements CommentEditContract {
  String updateMessage;
  CommentEditPresenter mPresenter;
  String message;
  OnCommentUpdateListener commentUpdateListener;

  CommentEditDialogPageState() {
    mPresenter = new CommentEditPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    commentUpdateListener = widget.listener;
    message = widget.mReview != null ? widget.mReview.mesg : widget.mReply.mesg;
  }

  _cancelClick(BuildContext context) {
    Navigator.pop(context);
  }

  _updateClick(BuildContext context) {
    if (widget.mReview != null) {
      if (widget.mReview.doctor != null) {
        mPresenter.updateComment(Configs.TEST_CODE, widget.mReview.doctor,
            widget.mReview.id, updateMessage);
      } else if (widget.mReview.article != null) {
        mPresenter.updateArticleComment(Configs.TEST_CODE,
            widget.mReview.article, widget.mReview.id, updateMessage);
      }
    }

    if (widget.mReply != null) {
      if (widget.mArticleId != null) {
        print('Article Reply Edit${widget.mArticleId}');
        mPresenter.updateArticleCommentReply(
            Configs.TEST_CODE,
            widget.mArticleId,
            widget.mReviewId,
            widget.mReply.id,
            updateMessage);
      } else if (widget.mDoctorId != null) {
        mPresenter.updateCommentReply(Configs.TEST_CODE, widget.mDoctorId,
            widget.mReviewId, updateMessage, widget.mReply.id);
      }
    }
  }

  InputDecoration getDecoration(String hintText) {
    return new InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: MyStyle.layoutBackground,
        contentPadding: const EdgeInsets.all(MyStyle.double10),
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(color: MyStyle.defaultGrey, width: 1.0),
            gapPadding: 0.5));
  }

  @override
  Widget build(BuildContext context) {
    print('Comment Edit Dialog');
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: MyStyle.colorWhite,
        leading: new IconButton(
            icon: new Icon(Icons.clear, color: MyStyle.colorBlack),
            onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: new Text(
          'Edit',
          style: new TextStyle(
              color: MyStyle.colorBlack, fontSize: MyStyle.font16),
        ),
      ),
      body: new Container(
        padding: const EdgeInsets.symmetric(horizontal: MyStyle.double16, vertical: MyStyle.double16),
        color: MyStyle.colorWhite,
        child: new Container(
          child: new Column(
            children: <Widget>[
              new TextFormField(
                initialValue: message,
                autovalidate: true,
                obscureText: false,
                decoration: getDecoration(''),
                onFieldSubmitted: (String val) {
                  print('Field Submitted');
                  setState(() {
                    updateMessage = val;
                  });
                },
                onSaved: (String val) {
                  print('on Save$val');
                  updateMessage = val;
                },
              ),
              new Container(
                  margin: const EdgeInsets.only(top: MyStyle.double16),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.only(right: MyStyle.double4),
                          child: new RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              onPressed: () => _cancelClick(context),
                              child: new Text('Cancel',
                                  style: new TextStyle(
                                      fontSize: MyStyle.font14,
                                      color: MyStyle.colorBlack)),
                              color: MyStyle.layoutBackground)),
                      new RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          onPressed: () => _updateClick(context),
                          child: new Text('Update',
                              style: new TextStyle(
                                  fontSize: MyStyle.font14,
                                  color: MyStyle.colorWhite)),
                          color: MyStyle.colorAccent)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dismissDialog() {
    print('Dismiss Dialog');
    Navigator.pop(context);
    commentUpdateListener.onSuccess(updateMessage);
  }

  @override
  void showMessage(String message) {
    print('Message >>$message');
  }
}

abstract class OnCommentUpdateListener {
  void onSuccess(String comment);
}
