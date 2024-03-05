// ignore_for_file: prefer_final_fields, sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, prefer_is_empty, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gap/gap.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/notification_service.dart';
import 'package:mudarribe_trainer/views/chat/full_photo_page.dart';
import 'package:mudarribe_trainer/views/video/video_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mudarribe_trainer/models/message_chat.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/chat/constants.dart';
import 'package:mudarribe_trainer/views/chat/controller.dart';
import 'package:mudarribe_trainer/views/chat/pdf_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.arguments});

  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late final String currentUserId;

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";
  bool isDeleted = false;
  File? pdfFile;
  File? videoFile;
  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final notificationService = NotificationService();

  StreamSubscription<DocumentSnapshot>? chatSubscription;
  StreamSubscription<QuerySnapshot>? messageSubscription;

  late final ChatProvider chatProvider = context.read<ChatProvider>();

  @override
  void initState() {
    super.initState();
    fetchuserToken();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    readLocal();
  }

  String userToken = '';
  void fetchuserToken() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.arguments.peerId)
          .get();

      if (snapshot.exists) {
        setState(() {
          userToken = snapshot['firebaseToken'];
          print('userToken*******************');
          print(userToken);
        });
      } else {
        print('User not found');
      }
    } catch (error) {
      print('Error fetching user token: $error');
    }
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  @override
  void dispose() {
    chatSubscription?.cancel();
    messageSubscription?.cancel();
    super.dispose();
  }

  void readLocal() {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty == true) {
      currentUserId = FirebaseAuth.instance.currentUser!.uid;
    } else {
      // Get.offAll(() => const LoginScreen());
    }
    String peerId = widget.arguments.peerId;
    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }
    final docRef = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId);

    // Listen for changes in the document
    chatSubscription = docRef.snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        // Document exists, proceed with the update
        docRef.update({'trainerSeen': true}).then((_) {
          print('Update successful');
        }).catchError((error) {
          print('Error updating document: $error');
        });
      } else {
        // Document does not exist, handle accordingly
        print('Document does not exist');
      }
    });

    final collectionRef = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId);

    // Listen for changes in the messages collection
    final query = collectionRef.where('idFrom', isNotEqualTo: currentUserId);

    // Update the seen status for each message
    messageSubscription = query.snapshots().listen((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // Update the seen field for each document
        doc.reference.update({'seen': true}).then((_) {
          print('Update successful');
        }).catchError((error) {
          print('Error updating document: $error');
        });
      });
    });
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((err) {
      // Fluttertoast.showToast(msg: err.toString());
      UiUtilites.errorSnackbar('Error'.tr, err.toString());
      return null;
    });
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        bool userConfirmed = await showConfirmationDialog(Get.context!);
        if (userConfirmed) {
          setState(() {
            isLoading = true;
          });
          uploadFile();
        }
      }
    }
  }

  // void getSticker() {
  //   // Hide keyboard when sticker appear
  //   focusNode.unfocus();
  //   setState(() {
  //     isShowSticker = !isShowSticker;
  //   });
  // }

  Future getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    print(result);
    if (result != null) {
      List<File> pickedFiles = result.paths.map((path) => File(path!)).toList();
      if (pickedFiles.isNotEmpty) {
        pdfFile = pickedFiles.first;
        String? fileName = result.files.first.name;
        bool userConfirmed = await showConfirmationDialog(Get.context!);
        if (userConfirmed) {
          setState(() {
            isLoading = true;
          });
          uploadPdf(pdfFile!, fileName);
        }
      }
    }
  }

  Future getMp4() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      List<File> pickedFiles = result.paths.map((path) => File(path!)).toList();
      if (pickedFiles.isNotEmpty) {
        videoFile = pickedFiles.first;
        String? fileName = result.files.first.name;
        bool userConfirmed = await showConfirmationDialog(Get.context!);
        if (userConfirmed) {
          setState(() {
            isLoading = true;
          });
          uploadVideo(videoFile!, fileName);
        }
      }
    }
  }

  Future uploadVideo(File videoFile, String fileName) async {
    UploadTask uploadTask = chatProvider.uploadVideo(videoFile, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String videoUrl = await snapshot.ref.getDownloadURL();
      print(videoUrl);
      setState(() {
        isLoading = false;
        onSendMessage(videoUrl, TypeMessage.video);
      });
      Get.back();
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.back();
      print(e);
    }
  }

  Future uploadPdf(File pdfFile, String fileName) async {
    UploadTask uploadTask = chatProvider.uploadPdf(pdfFile, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String pdfUrl = await snapshot.ref.getDownloadURL();
      print(pdfUrl);
      setState(() {
        isLoading = false;
        onSendMessage(pdfUrl, TypeMessage.document);
      });
      Get.back();
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.back();
      print(e);
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = chatProvider.uploadFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, TypeMessage.image);
      });
      Get.back();
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });

      print(e);
      Get.back();
      // Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      notificationService.postNotification(
          title: 'Messages',
          body: 'New Message Received',
          receiverToken: userToken);
      textEditingController.clear();
      chatProvider.sendMessage(
          content, type, groupChatId, currentUserId, widget.arguments.peerId);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  get_text_between(text, start, end) {
    var index = text.indexOf(start);
    if (index == -1) {
      return "";
    }
    var index2 = text.indexOf(end, index + start.length);
    if (index2 == -1) {
      return "";
    }
    return text.substring(index + start.length, index2);
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == currentUserId) {
        // Right (my message)
        return Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: <Widget>[
                  messageChat.seen
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.done_all,
                              color: Get.isDarkMode ? white : Colors.black),
                        ) // Message seen
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.done,
                              color: Get.isDarkMode ? white : Colors.black),
                        ),
                  messageChat.type == TypeMessage.text
                      // Text
                      ? Container(
                          child: Text(
                            messageChat.content,
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          constraints: BoxConstraints(
                            maxWidth: 200,
                          ),
                          decoration: BoxDecoration(
                              color: Get.isDarkMode ? white : lightbgColor,
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(bottom: 10, right: 10),
                        )
                      : messageChat.type == TypeMessage.image
                          // Image
                          ? Container(
                              child: TextButton(
                                child: Material(
                                  child: Image.network(
                                    messageChat.content,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        width: 200,
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            // color: mainColor,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, object, stackTrace) {
                                      return Material(
                                        child: Image.asset(
                                          'images/img_not_available.jpeg',
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                      );
                                    },
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullPhotoPage(
                                        url: messageChat.content,
                                      ),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(0))),
                              ),
                              margin: EdgeInsets.only(bottom: 10, right: 10),
                            )
                          : messageChat.type == TypeMessage.document
                              ? InkWell(
                                  onTap: () {
                                    String remotePDFpath;
                                    createFileOfPdfUrl(messageChat.content)
                                        .then((f) {
                                      setState(() {
                                        remotePDFpath = f.path;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PDFScreen(path: remotePDFpath),
                                          ),
                                        );
                                      });
                                    });
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 60,
                                    margin:
                                        EdgeInsets.only(right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? white
                                            : lightbgColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.only(
                                                right: 4, left: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  borderTop,
                                                  borderbottom
                                                ],
                                                stops: [0.0, 1.0],
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/document.svg',
                                              fit: BoxFit.scaleDown,
                                            )),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                              get_text_between(
                                                  messageChat.content,
                                                  "/o/",
                                                  "?"),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : messageChat.type == TypeMessage.myplan
                                  ? Container(
                                      width: 250,
                                      margin: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Get.isDarkMode
                                              ? white
                                              : lightbgColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Plan Title: '.tr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                messageChat.content
                                                    .split("~~")[0]
                                                    .split(":")[1],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Amount: '.tr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                messageChat.content
                                                    .split("~~")[1]
                                                    .split(":")[1],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Plan Category: '.tr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                messageChat.content
                                                    .split("~~")[2]
                                                    .split(":")[1],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Plan Duration: '.tr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                messageChat.content
                                                    .split("~~")[5]
                                                    .split(":")[1],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          GradientButton(
                                            title: messageChat.content
                                                        .split("~~")[3]
                                                        .split(":")[1] ==
                                                    'true'
                                                ? 'Paid'.tr
                                                : 'Unpaid'.tr,
                                            onPressed: () {},
                                            selected: messageChat.content
                                                        .split("~~")[3]
                                                        .split(":")[1] ==
                                                    'true'
                                                ? true
                                                : false,
                                          ),
                                        ],
                                      ),
                                    )
                                  : messageChat.type == TypeMessage.rating
                                      ? Container(
                                          width: 250,
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? white
                                                  : lightbgColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Rating:'.tr,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    ' ' +
                                                        messageChat.content
                                                            .split("~~")[0]
                                                            .split(":")[1],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: borderbottom,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                              Gap(12),
                                              GradientButton(
                                                title: messageChat.content
                                                            .split("~~")[1]
                                                            .split(":")[1] ==
                                                        'true'
                                                    ? 'Rated '.tr
                                                    : 'Not Rated Yet'.tr,
                                                onPressed: () {},
                                                selected: messageChat.content
                                                            .split("~~")[1]
                                                            .split(":")[1] ==
                                                        'true'
                                                    ? true
                                                    : false,
                                              ),
                                            ],
                                          ),
                                        )
                                      : messageChat.type == TypeMessage.video
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoPlay(
                                                            path: messageChat
                                                                .content),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 250,
                                                height: 60,
                                                margin: EdgeInsets.only(
                                                    left: 10, bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Get.isDarkMode
                                                        ? white
                                                        : Colors.grey
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        margin: EdgeInsets.only(
                                                            right: 4, left: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(45),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                              borderTop,
                                                              borderbottom
                                                            ],
                                                            stops: [0.0, 1.0],
                                                          ),
                                                        ),
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .video_camera)),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                          get_text_between(
                                                              messageChat
                                                                  .content,
                                                              "/o/",
                                                              "?"),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox()
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              isLastMessageRight(index)
                  ? Container(
                      child: Text(
                        DateFormat('dd MMM kk:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageChat.timestamp))),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                      margin: EdgeInsets.only(right: 20, bottom: 10),
                    )
                  : SizedBox.shrink()
            ],
          ),
        );
      } else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          // child: Image.network(
                          //   widget.arguments.peerAvatar,
                          //   loadingBuilder: (BuildContext context, Widget child,
                          //       ImageChunkEvent? loadingProgress) {
                          //     if (loadingProgress == null) return child;
                          //     return Center(
                          //       child: CircularProgressIndicator(
                          //         color: Colors.grey[300],
                          //         value: loadingProgress.expectedTotalBytes !=
                          //                 null
                          //             ? loadingProgress.cumulativeBytesLoaded /
                          //                 loadingProgress.expectedTotalBytes!
                          //             : null,
                          //       ),
                          //     );
                          //   },
                          //   errorBuilder: (context, object, stackTrace) {
                          //     return Icon(
                          //       Icons.account_circle,
                          //       size: 35,
                          //       color: Colors.grey[300],
                          //     );
                          //   },
                          //   width: 35,
                          //   height: 35,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Icon(
                            Icons.account_circle,
                            size: 35,
                            color: Colors.grey[300],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                        )
                      : Container(width: 35),
                  messageChat.type == TypeMessage.text
                      ? Container(
                          child: Text(
                            messageChat.content,
                            style: TextStyle(color: white),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          constraints: BoxConstraints(
                            maxWidth: 200,
                          ),
                          decoration: BoxDecoration(
                              color: bgContainer,
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(left: 10),
                        )
                      : messageChat.type == TypeMessage.image
                          ? Container(
                              child: TextButton(
                                child: Material(
                                  child: Image.network(
                                    messageChat.content,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        width: 200,
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, object, stackTrace) =>
                                            Material(
                                      child: Image.asset(
                                        'assets/images/img_not_available.jpeg',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullPhotoPage(
                                          url: messageChat.content),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(0))),
                              ),
                              margin: EdgeInsets.only(left: 10),
                            )
                          : messageChat.type == TypeMessage.document
                              ? InkWell(
                                  onTap: () {
                                    String remotePDFpath;
                                    createFileOfPdfUrl(messageChat.content)
                                        .then((f) {
                                      setState(() {
                                        remotePDFpath = f.path;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PDFScreen(path: remotePDFpath),
                                          ),
                                        );
                                      });
                                    });
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 60,
                                    margin:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                        color: bgContainer,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.only(
                                                right: 4, left: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  borderTop,
                                                  borderbottom
                                                ],
                                                stops: [0.0, 1.0],
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/document.svg',
                                              fit: BoxFit.scaleDown,
                                            )),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                              get_text_between(
                                                  messageChat.content,
                                                  "/o/",
                                                  "?"),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : messageChat.type == TypeMessage.video
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VideoPlay(
                                                path: messageChat.content),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 250,
                                        height: 60,
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: bgContainer,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.only(
                                                    right: 4, left: 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      borderTop,
                                                      borderbottom
                                                    ],
                                                    stops: [0.0, 1.0],
                                                  ),
                                                ),
                                                child: Icon(CupertinoIcons
                                                    .video_camera)),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                  get_text_between(
                                                      messageChat.content,
                                                      "/o/",
                                                      "?"),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      child: Text(
                        DateFormat('dd MMM kk:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageChat.timestamp))),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                      margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
                    )
                  : SizedBox.shrink()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) ==
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get(FirestoreConstants.idFrom) !=
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new),
          ),

          title: Text(
            widget.arguments.peerNickname,
            style: TextStyle(
                color: Get.isDarkMode ? white : Colors.black,
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          // centerTitle: true,
        ),
        body: SafeArea(
          child: WillPopScope(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // List of messages
                    buildListMessage(),
                    // Input content
                    buildInput()
                  ],
                ),

                // Loading
                buildLoading()
              ],
            ),
            onWillPop: onBackPress,
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? LoadingView() : SizedBox.shrink(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          GestureDetector(
            onTap: () {
              _showSimpleBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              width: 30.0,
              color: Get.isDarkMode ? maincolor : Colors.white,
              child: Icon(Icons.attach_file, color: borderTop),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                width: 40.0,
                color: Get.isDarkMode ? maincolor : Colors.white,
                child: Icon(Icons.more_vert_outlined, color: borderTop)),
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, TypeMessage.text);
                },
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 15),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type Here...'.tr,
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                focusNode: focusNode,
                autofocus: true,
              ),
            ),
          ),

          // Button send message
          Material(
              child: InkWell(
                onTap: () =>
                    onSendMessage(textEditingController.text, TypeMessage.text),
                child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 8, left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [borderTop, borderbottom],
                        stops: [0.0, 1.0],
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/send.svg',
                      fit: BoxFit.scaleDown,
                    )),
              ),
              color: Get.isDarkMode ? maincolor : Colors.white),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[300]!, width: 0.5)),
          color: Get.isDarkMode ? maincolor : Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: chatProvider.getChatStream(groupChatId, _limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.length > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) =>
                          buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: listScrollController,
                    );
                  } else {
                    return Center(child: Text("No message here yet...".tr));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext builder) {
        return Container(
          width: double.infinity,
          // You can customize the appearance of your bottom sheet here
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.personalplan)!.then((returnedValue) {
                    if (returnedValue != null) {
                      print(
                          'Returned value from personalplan screen12: $returnedValue');
                      onSendMessage(returnedValue, TypeMessage.myplan);
                      Get.back();
                    }
                  });
                },
                child: GradientText2(
                  text: 'Personal Plan'.tr,
                  size: 16.0,
                ),
              ),
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: getImage,
                child: Text(
                  'Photos'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: getMp4,
                child: Text(
                  'Video'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: getPdf,
                child: Text(
                  'Document'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: () {
                  String content = 'rating:' + '0' + '~~isRating:' + 'false';
                  onSendMessage(content, TypeMessage.rating);
                  Get.back();
                },
                child: Text(
                  "Ask for Rating".tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSimpleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext builder) {
        return Container(
          width: double.infinity,
          // You can customize the appearance of your bottom sheet here
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: getImage,
                child: Text(
                  'Photos'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: getMp4,
                child: Text(
                  'Video'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: getPdf,
                child: Text(
                  'Document'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  color: bgContainer.withOpacity(0.45),
                  height: 0.5),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0f0a06),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File> createFileOfPdfUrl(pdf) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = pdf;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}

class ChatPageArguments {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;

  ChatPageArguments(
      {required this.peerId,
      required this.peerAvatar,
      required this.peerNickname});
}
