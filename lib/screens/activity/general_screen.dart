import 'dart:async';
import 'dart:io';
import 'package:basalon/blocs/application_bloc.dart';
import 'package:basalon/network/google_map.dart';
import 'package:basalon/network/my_activity_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import '../../constant/login_user.dart';
import '../../network/create_event_network.dart';
import '../../network/get_update_profile_network.dart';
import '../../widgets/custom_icons.dart';
import '../../widgets/date_helper.dart';
import '../../widgets/file_picker_helper.dart';
import '../preview/preview_event_detail.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.743902, -71.170009);
const double CAMERA_ZOOM = 2;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class GeneralScreen extends StatefulWidget {
  GeneralScreen({Key? key, this.id}) : super(key: key);
  int? id;

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();

  List<TextEditingController> controllerList = [];
  List<TextEditingController> chooseBeforeControllerLIst = [
    TextEditingController()
  ];
  List<TextEditingController> nameTicketControllerList = [
    TextEditingController(text: 'כרטיס רגיל')
  ];
  List<TextEditingController> priceTicketControllerList = [
    TextEditingController()
  ];
  List<TextEditingController> numOfTicketControllerList = [
    TextEditingController()
  ];
  List<TextEditingController> descTicketControllerList = [
    TextEditingController()
  ];

  void validate() {
    if (formkey.currentState != null) if (formkey.currentState!.validate() &&
        formkey.currentState != null) {
      print('VALIDATED');
      application.validate();
      print('Not Valid');
    }
  }

  StreamSubscription? locationSubscription;
  bool isRemoveDp = false;
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = {};

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('${application.searchResult?[0].placeId}'),
          position: LatLng(22.5448131, 88.3403691),
        ),
      );
    });
  }

  late LatLng currentLocation;
  late LatLng destinationLocation;

  File? imgFilePicture;
  String? imgDataPicture;
  File? imgfile;
  String? imgData;
  late double width = MediaQuery.of(context).size.width;
  String? dropDownValue;

  // List of items in our dropdown menu
  var categoryItems = kCategoryList;
  var items = ktimeList;
  var checkData;
  var klatitude;
  var klongitude;
  var editData;
  GetUserActivity _getUserActivity = GetUserActivity();

  checkboxfunction(checkData) async {
    Map<String, dynamic>.from(checkData).forEach((key, v) {
      print(checkData);
      print("jksahdjb,");
      if (checkData[key] == '1') {
        isSunday = true;
      } else if (checkData[key] == '2') {
        isMonday = true;
      } else if (checkData[key] == '3') {
        isTuesday = true;
      } else if (checkData[key] == '4') {
        isWednesday = true;
      } else if (checkData[key] == '5') {
        isThursday = true;
      } else if (checkData[key] == '6') {
        isFriday = true;
      } else if (checkData[key] == '7') {
        isSaturday = true;
      }
    });

    setState(() {});
  }

  getEditDetail() async {
    if (widget.id != null) {
      print("mnbcjxbjsa");
      print(widget.id);
      editData =
          await _getUserActivity.getUserEditActivityDetails(widget.id, context);
      print("zmn");
      startingTime =
          editData['data']['activity']['calendar_recurrence_start_time'];
      endingTime = editData['data']['activity']['calendar_recurrence_end_time'];
      _dropDownValue = editData['data']['activity']['activity_repeat'];
      userPhoneController.text = editData['data']['author_data']['phone'];
      chooseDateBeforeController.text =
          editData['data']['activity']['stop_sell'];
      checkData = editData['data']['activity']['recurrence_bydays'];
      print(checkData);
      print("kjks");
      print(editData['data']['activity']['recurrence_bydays']);
      checkboxfunction(checkData);
      dobtextEditingController.text =
          editData['data']['activity']['calendar_start_date'];

      nameEventController.text = editData['data']['title'];
      dropDownValue = editData['data']['event_category'][0]['name'];
      eventContentController.text = editData['data']['content'];
      locationController.text = editData['data']['map_address'];
      videoController.text = editData['data']['link_video'];
      imagesListEdit = editData['data']['gallery'];
      startDOBtextEditingController.text =
          editData['data']['disable_date'][0]['start_date'] != null
              ? editData['data']['disable_date'][0]['start_date']
              : "";
      endDOBtextEditingController.text =
          editData['data']['disable_date'][0]['end_date'] != null
              ? editData['data']['disable_date'][0]['end_date']
              : "";
      firstnameController.text = editData['data']['author_data']['first_name'];
      lastnameController.text = editData['data']['author_data']['last_name'];
      for (int index = 0;
          index < editData['data']['no_of_ticket'].length;
          index++) {
        print("shauk");

        // editViewArray.add(true);
        // showTicket.add(false);
        // nameTicketControllerList.add(TextEditingController(text: 'כרטיס רגיל'));
        // priceTicketControllerList.add(TextEditingController(text: ''));
        // descTicketControllerList.add(TextEditingController(text: ''));
        // numOfTicketControllerList.add(TextEditingController(text: ''));

        // nameTicketControllerList[index].text = editData['data']['no_of_ticket'][index]['name_ticket'] ??
        //     '';
        // priceTicketControllerList[index].text = editData['data']['no_of_ticket'][index]['price_ticket'] ??
        //     '';
        // numOfTicketControllerList[index].text = editData['data']['no_of_ticket'][index]['number_total_ticket']??
        //     '';
        // descTicketControllerList[index].text = editData['data']['no_of_ticket'][index]['private_desc_ticket'] ??
        //     '';

        ticketAddArray.add(0);
        editViewArray.add(true);
        showTicket.add(false);
        nameTicketControllerList.add(TextEditingController(
            text: editData['data']['no_of_ticket'][index]['name_ticket'] ??
                'כרטיס רגיל'));
        priceTicketControllerList.add(TextEditingController(
            text:
                editData['data']['no_of_ticket'][index]['price_ticket'] ?? ''));
        descTicketControllerList.add(TextEditingController(
            text: editData['data']['no_of_ticket'][index]
                    ['number_total_ticket'] ??
                ''));
        numOfTicketControllerList.add(TextEditingController(
            text: editData['data']['no_of_ticket'][index]
                    ['private_desc_ticket'] ??
                ''));

        print("kjhdkjssdkksx");
        print(editData['data']['no_of_ticket'][index]['name_ticket']);

        // addTicket;
        // print(editData['data']['no_of_ticket'][i]['name_ticket']);
        // priceTicketControllerList[i].text =
        //     editData['data']['no_of_ticket'][i]['name_ticket'];
      }
      setState(() {});
      print(editData['data']['no_of_ticket']);
      print("editDataticket");
      print("all data");
      print(nameTicketControllerList.length);
      print(priceTicketControllerList.length);
      print(descTicketControllerList.length);
      print(numOfTicketControllerList.length);

      print("lol1");
      print(editData['data']['no_of_ticket']);
      print("lol2");
      print(priceTicketControllerList);
      print("lol3");
      // print(editData['data']['map_address']);
      print(editData['data']['thumbnail_event']);
      setState(() {});
      print("dropklrjlkew");
      // print(editData['data']['event_category'][0]['name']);
      print(nameTicketControllerList[0]);
      print("data aaya2");
      print(editData['data']['activity']['recurrence_bydays']);
      print("data aaya3");
      // print(widget.id);
      print(editData);
    }
  }

  @override
  void initState() {
    print('genereal init');

    cyclicalAndArray.add(cyclicalAndArray.length + 1);
    print(widget.id);
    // print(application.myActivityEditPage);
    getEditDetail();
    // checkboxfunction();
    setCustomMarker();
    print("sjkhdsjka");
    super.initState();
    final application = Provider.of<ApplicationBloc>(context, listen: false);
    locationSubscription = application.selectedLocation.stream.listen((place) {
      print(place);
      if (place != null) {
        _goToPlace(place);
      }
    });
    // set up initial location
    setInitialLocation();
    //set up the marker location
    setSourceAndDestinationMarkerIcons();

    application.setMarker();
    setState(() {
      showText = false;
    });

    if (widget.id == null) {
      ticketAddArray.add(0);
    }

    if (widget.id != null &&
        application.myActivityEditPage?.data?.noOfTicket?.length == 1) {
      showTicket[0] = true;
    }
    print(widget.id);
    print("mnajkas");
    print(application.myActivityEditPage);
    print("mnajkas");
    // if (widget.id != null && editData != null) {
    //   print("for1");
    //   for (int i = 0; i < editData['data']['no_of_ticket'].length; i++) {
    //     print("for1");
    // addTicketForEdit();
    //     print("for1");
    //   }
    // }

    defaultAddSpecificdates();
    firstnameController.text = application.nameFromFacebook != null
        ? application.nameFromFacebook.split(' ').first
        : firstnameController.text;
    lastnameController.text = application.nameFromFacebook != null
        ? application.nameFromFacebook.split(' ').last
        : firstnameController.text;
    _updateAndGetUserProfile.getProfileData(
        LoginUser.shared?.userId! ?? application.idFromLocalProvider);
    Future.delayed(const Duration(seconds: 2), () => fillDetail());
  }

  addTicketForEdit() {
    ticketAddArray.add(0);
    print("add1");
    editViewArray.add(true);
    print("add2");
    showTicket.add(false);
    print("add3");
    nameTicketControllerList.add(TextEditingController(text: 'כרטיס רגיל'));
    print("add4");
    priceTicketControllerList.add(TextEditingController(text: ''));
    print("add5");
    descTicketControllerList.add(TextEditingController(text: ''));
    print("add6");
    numOfTicketControllerList.add(TextEditingController(text: ''));
    print("add7");
  }

  editTicketForEdit() {
    ticketAddArray.add(0);
    print("edit1");
    editViewArray.add(true);
    showTicket.add(false);
    nameTicketControllerList.add(TextEditingController(text: 'כרטיס רגיל'));
    priceTicketControllerList.add(TextEditingController(text: ''));
    descTicketControllerList.add(TextEditingController(text: ''));
    numOfTicketControllerList.add(TextEditingController(text: ''));
  }

  DateTime? yourTime;

  Future<void> defaultAddSpecificdates() async {
    setState(() {
      timeOptionAddArray.add(timeOptionAddArray.length + 1);
    });
  }

  late BitmapDescriptor customIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/CustomMarker.png',
    );
  }

  List<Marker> markers = [];

  initialize() {
    Marker marker = Marker(
        markerId: MarkerId('value'),
        position: LatLng(application.currentLocation!.latitude,
            application.currentLocation!.longitude),
        infoWindow: InfoWindow(
          title: 'demo dmeo',
        ),
        icon: BitmapDescriptor.defaultMarker);
    setState(() {
      markers.add(marker);
    });
  }

  dynamic locationLat;
  dynamic locationLng;

  void setSourceAndDestinationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        "assets/images/iconMap.png");

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        "assets/images/iconMap.png");
  }

  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  galleryImage() {
    for (int i = 0; i < imagesList.length; i++) {
      imagesList[i];
    }
    print(imagesList);
  }

  final translator = GoogleTranslator();
  dynamic translatedData;
  List<Asset> imagesList = <Asset>[];
  List<MultipartFile> multipartImageList = <MultipartFile>[];
  late final CreateEventNetwork _createEventNetwork = CreateEventNetwork(
    nameEventController: application.previewTitleProvider,
    // categoryController: application.previewCategoryProvider,
    categoryController: activeRadio == 0 ? 'online' : 'classic',
    selectCategory: categoryController.text,
    eventContentController: application.previewContentProvider,
    addressController: application.previewMapAddressProvider,
    videoController: videoController.text,
    imagePath: imgFilePicture?.path,
    filename: imgDataPicture,
    galleryImages: multipartImageList,
    // ticketPriceController: ticketPriceController.text,
    // ticketDescriptionController: ticketDescriptionController.text,
    // totalTicketController: totalTicketController.text,
    discountCodeController: discountCodeController.text,
    discountAmountController: discountAmountController.text,
    // firstnameController: firstnameController.text,
    // lastnameController: lastnameController.text,
    // userAddressController: userAddressController.text,
    // userImage: userImageController.text,
    // userDescription: userDescriptionController.text,
    // userPhoneController: userPhoneController.text,
    recurrenceIntervalController: _dropDownValue,
    recurrenceByDaysController: _dropDownValue,
    // optionCalenderController: dobtextEditingController.text,
    optionCalenderController: optionCalender,
    startTimeController: startingTime,
    endTimeController: endingTime,
    recurrenceFrequencyController: _dropDownValueWeekly,
    calendarRecurrenceBookBefore: chooseDateBeforeController.text,
    calenderEndDate: endDOBtextEditingController.text,
    calenderStartDate: startDOBtextEditingController.text != ''
        ? startDOBtextEditingController.text
        : dobtextEditingController.text,
    disableStartDate: startDOBtextEditingController.text,
    disableEndDate: endDOBtextEditingController.text,
    isFriday: isFriday == true ? '5' : null,
    isMonday: isMonday == true ? '1' : null,
    isSaturday: isSaturday == true ? '6' : null,
    isSunday: isSunday == true ? '0' : null,
    isThursday: isThursday == true ? '4' : null,
    isTuesday: isTuesday == true ? '2' : null,
    isWednesday: isWednesday == true ? '3' : null,
    latitude: klatitude,
    longitude: klongitude,
    bankOwnerController: bankOwnerController.text,
    bankNumberController: bankNumberController.text,
    bankNameController: bankNameController.text,
    bankBranchController: bankBranchController.text,
  );

  final UpdateAndGetUserProfile _updateAndGetUserProfile =
      UpdateAndGetUserProfile();
  String? authorImage;

  fillDetail() {
    userAddressController.text =
        application.getUserDataProfileProvider?.data?.authorEmail ?? '';

    firstnameController.text =
        application.getUserDataProfileProvider?.data?.firstName ??
            application.nameFromFacebook ??
            '';

    lastnameController.text =
        application.getUserDataProfileProvider?.data?.lastName ??
            application.nameFromFacebook ??
            '';

    userPhoneController.text =
        application.getUserDataProfileProvider?.data?.userPhone ??
            application.nameFromFacebook ??
            '';
    userDescriptionController.text =
        application.getUserDataProfileProvider?.data?.description ??
            application.nameFromFacebook ??
            '';
    authorImage = application.getUserDataProfileProvider != null
        ? application.getUserDataProfileProvider!.data!.authorImage!
        : "";
    bankOwnerController.text =
        application.getUserDataProfileProvider?.data?.userBankOwner ??
            application.nameFromFacebook ??
            '';
    bankNumberController.text =
        application.getUserDataProfileProvider?.data?.userBankNumber ??
            application.nameFromFacebook ??
            '';
    bankNameController.text =
        application.getUserDataProfileProvider?.data?.userBankName ??
            application.nameFromFacebook ??
            '';
    bankBranchController.text =
        application.getUserDataProfileProvider?.data?.userBankBranch ??
            application.nameFromFacebook ??
            '';

    if (widget.id != null && application.myActivityEditPage != null) {
      nameEventController.text =
          application.myActivityEditPage?.data?.title ?? '';

      eventContentController.text =
          application.myActivityEditPage?.data?.content ?? '';
      locationController.text =
          application.myActivityEditPage?.data?.mapAddress ?? '';
      videoController.text =
          application.myActivityEditPage?.data?.linkVideo ?? '';
      print('++++++++++++++++++++++++++++++');
      print(application.myActivityEditPage?.data?.noOfTicket);

      print(application.myActivityEditPage?.data?.disableDate[0]['start_date']);

      firstnameController.text =
          application.myActivityEditPage!.data!.authorData!.firstName!;
      startingTime = application
          .myActivityEditPage!.data!.activity?.calendarRecurrenceStartTime;
      endingTime = application
          .myActivityEditPage!.data!.activity?.calendarRecurrenceEndTime;
      print(endingTime);

      startDOBtextEditingController.text =
          application.myActivityEditPage?.data?.disableDate[0]['start_date'] ??
              '';
      endDOBtextEditingController.text =
          application.myActivityEditPage?.data?.disableDate[0]['end_date'] ??
              '';

      lastnameController.text =
          application.myActivityEditPage!.data!.authorData!.lastName!;
      userAddressController.text =
          application.myActivityEditPage!.data!.authorData!.email!;
      userPhoneController.text =
          application.myActivityEditPage!.data!.authorData!.phone!;
      userDescriptionController.text =
          application.myActivityEditPage!.data!.authorData!.description!;

      bankOwnerController.text = (application.myActivityEditPage!.data != null
          ? application.myActivityEditPage!.data?.payment?.accountHolder
          : '')!;
      bankNumberController.text = (application.myActivityEditPage!.data != null
          ? application.myActivityEditPage!.data?.payment?.accountNo
          : '')!;
      bankNameController.text = (application.myActivityEditPage!.data != null
          ? application.myActivityEditPage!.data?.payment?.bankName
          : '')!;
      bankBranchController.text = (application.myActivityEditPage!.data != null
          ? application.myActivityEditPage!.data?.payment?.branch
          : '')!;

      print(
          'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz${application.myActivityEditPage?.data?.gallery}');

      // ticketPriceController.text =
      //     application.myActivityEditPage?.data?.markerPrice != null
      //         ? application.myActivityEditPage!.data!.markerPrice
      //             .toString()
      //             .replaceAll('₪', '')
      //         : '';
      // if (application.myActivityEditPage!.data!.noOfTicket!.isNotEmpty) {
      //   totalTicketController.text = application
      //       .myActivityEditPage!.data!.noOfTicket![0].numberTotalTicket!;
      //   ticketDescriptionController.text = application
      //       .myActivityEditPage!.data!.noOfTicket![0].privateDescTicket!;
      // }

      startingTime = application
          .myActivityEditPage?.data?.activity?.calendarRecurrenceStartTime;

      endingTime = application
          .myActivityEditPage?.data?.activity?.calendarRecurrenceEndTime;

      dobtextEditingController.text =
          application.myActivityEditPage!.data!.date!;

      discountCodeController.text =
          application.myActivityEditPage?.data?.coupon?[0].discountCode ?? '';

      print(
          'ppppppppppppppppppppppppppppppppppppppp${application.myActivityEditPage?.data?.coupon}');
      discountAmountController.text = application
              .myActivityEditPage?.data?.coupon?[0].discountAmoutNumber ??
          '';

      isSunday = application
          .myActivityEditPage!.data!.activity!.recurrenceBydays!
          .contains('0');
      isMonday = application
          .myActivityEditPage!.data!.activity!.recurrenceBydays!
          .contains('1');
      isTuesday = application
          .myActivityEditPage!.data!.activity!.recurrenceBydays!
          .contains('2');
      isWednesday = application
          .myActivityEditPage!.data!.activity!.recurrenceBydays!
          .contains('3');
      isThursday = application
          .myActivityEditPage!.data!.activity!.recurrenceBydays!
          .contains('4');
      isFriday = application
          .myActivityEditPage!.data!.activity!.recurrenceBydays!
          .contains('5');
      isSaturday = application
          .myActivityEditPage!.data!.activity!.recurrenceBydays!
          .contains('6');
      dobtextEditingController.text =
          application.myActivityEditPage!.data!.activity!.calendarStartDate!;
      chooseDateBeforeController.text =
          application.myActivityEditPage!.data!.activity!.stopSell!;
      imagesListEdit = application.myActivityEditPage!.data!.gallery;
      dropDownValue =
          application.myActivityEditPage?.data?.eventCategory?[0].name;
      ticketID.add(application.myActivityEditPage?.data?.noOfTicket);
      print(
          'imagesListEdit imagesListEdit imagesListEdit imagesListEdit imagesListEdit');
      print(imagesListEdit);

      setState(() {});
    }
  }

  List ticketID = [];
  final updateaandgetuserprofile = UpdateAndGetUserProfile();
  List? imagesListEdit;

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: imagesList,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      debugPrint("$e");
    }

    if (!mounted) return;

    setState(() {
      imagesList = resultList;
    });

    multipartImageList = [];

    for (Asset asset in imagesList) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: asset.name,
      );
      multipartImageList.add(multipartFile);
      print("all images arewwwwwwww");
      print(multipartImageList);
    }
  }

  List<dynamic>? removeIndexImage = [];

  Widget buildGridView() {
    print('imagesList');
    print(imagesList);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
            imagesList.isNotEmpty
                ? imagesList.length
                : imagesListEdit!.isNotEmpty
                    ? imagesListEdit!.length
                    : 0, (index) {
          // var asset = imagesList[index];
          // var img = imagesListEdit![index];

          return Stack(children: [
            if (imagesList.isNotEmpty)
              AssetThumb(
                asset: imagesList[index],
                width: 300,
                height: 300,
              ),
            if (imagesList.isEmpty)
              Image.network(
                imagesListEdit![index]['url'].toString(),
                width: 300,
                height: 300,
              ),
            Positioned(
                right: 0,
                left: 110,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (removeIndexImage != null &&
                            imagesListEdit != null) {
                          removeIndexImage!
                              .add(imagesListEdit![index]['id'].toString());
                        }
                        imagesList.isNotEmpty
                            ? imagesList.removeAt(index)
                            : imagesListEdit?.removeAt(index);
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromRGBO(233, 108, 96, 1),
                    )))
          ]);
        }),
      ),
    );
  }

  late List<bool> showTicket = [widget.id != null ? true : false];
  List<int> activityAddArray = [];
  bool showDetail = true;

// Custom Widgets for respective screens
  Widget addTicket(
    VoidCallback onDeleteTap,
    VoidCallback onEditTap,
    int index,
  ) {
    print('addTicket addTicket addTicket');
    print(index);
    print(ticketAddArray.length);
    print('------');
    print(application.myActivityEditPage?.data?.noOfTicket);

    if (widget.id != null && showDetail) {
      nameTicketControllerList[index].text =
          editData['data']['no_of_ticket'][index]['name_ticket'] ?? '';
      priceTicketControllerList[index].text =
          editData['data']['no_of_ticket'][index]['price_ticket'] ?? '';
      numOfTicketControllerList[index].text =
          editData['data']['no_of_ticket'][index]['number_total_ticket'] ?? '';
      descTicketControllerList[index].text =
          editData['data']['no_of_ticket'][index]['private_desc_ticket'] ?? '';
    }

    return Column(
      children: [
        Container(
          width: width - 25,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(109, 109, 109, 1)),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onDeleteTap,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            showTicket[index] = false;
                          });
                          print('edit uuuuuuuuuuu');
                          onEditTap();
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                    // Expanded(child: Text("sds")),
                    Expanded(
                        child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.airplane_ticket_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            onChanged: (v) {
                              showDetail = false;
                            },
                            controller: nameTicketControllerList[index],
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              showTicket[index] == false
                  ? Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Container(
                        // height: 640,
                        width: width - 25,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(234, 234, 234, 1)),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15, top: 15),
                                  child: Text('מחיר לכרטיס בש"ח',
                                      style: ktextStyleBold),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              216, 216, 216, 1))),
                                  child: TextFormField(
                                      // validator: (value) {
                                      //   if (value!.isEmpty || value == null) {
                                      //     return '*required';
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      // onChanged: (value) {
                                      //   setState(() {
                                      //     ticketPriceController.text = value;
                                      //   });
                                      //   print(value);
                                      // },
                                      onChanged: (v) {
                                        showDetail = false;
                                      },
                                      controller:
                                          priceTicketControllerList[index],
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.top,
                                      // textAlign: TextAlign.end,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        // hintText: '0',
                                      )),
                                ),
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15, top: 15),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'סה"כ',
                                        style: ktextStyleBold,
                                        children: [
                                          TextSpan(
                                            text: ' מספר הכרטיסים',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              216, 216, 216, 1))),
                                  child: TextFormField(
                                      onChanged: (v) {
                                        showDetail = false;
                                      },
                                      controller:
                                          numOfTicketControllerList[index],
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        // hintText: '10',
                                      )),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                  "הוסיפו פרטים שיעזרו לרוכשים להגיע לפעילות שלכם - מס' כניסה לבניין, קוד כניסה או כל פרט אחר שיכול לעזור.",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 13),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                  "אם מדובר בפעילות אונליין נא להוסיף לכאן את הלינק",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 13),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                  "(כל מה שתכתבו כאן יחשף רק למי שקנה כרטיס ולא יופיע באתר/אפליקציה)",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 13),
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              216, 216, 216, 1))),
                                  child: TextFormField(
                                      onChanged: (v) {
                                        showDetail = false;
                                      },
                                      controller:
                                          descTicketControllerList[index],
                                      maxLines: 10,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        hintText: '',
                                      )),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showTicket[index] = true;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: width / 2.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(
                                            112, 168, 49, 1)),
                                    child: const Center(
                                        child: Text('שמירת כרטיס',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget addSpecificDates(VoidCallback onTap, int index) {
    print('----------------');
    print(endingTime);
    return Form(
      key: formkey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    const Text(
                      'פעילות מתחילה מ:',
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Column(
                      children: [
                        // Text(application.myActivityEditPage.toString()),
                        // Text(endingTime.toString()),
                        // Text(editData!= null
                        //     ? editData['success'].toString()
                        //     : "hjd"),
                        // Text(application.myActivityEditPage.toString()),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(216, 216, 216, 1))),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  isExpanded: true,
                                  menuMaxHeight: 300,
                                  hint: startingTime == null
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'HH:MM',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            // startingTime!,
                                            startingTime.toString(),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                  iconSize: 30.0,
                                  style: const TextStyle(color: Colors.black),
                                  items: items.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    print("value is");
                                    print(val);
                                    setState(
                                      () {
                                        startingTime = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (startingTime == null && isValidatedTime)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              validateFields(),
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: const Text('ועד'),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(216, 216, 216, 1))),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  isExpanded: true,
                                  menuMaxHeight: 300,
                                  hint: endingTime == null
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'HH:MM',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            endingTime.toString(),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                  iconSize: 30.0,
                                  style: const TextStyle(color: Colors.black),
                                  items: ktimeList.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        endingTime = val as String?;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (endingTime == null && isValidatedTime)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              validateFields(),
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('שבועות'),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                menuMaxHeight: 300,
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _dropDownValue,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                iconSize: 30.0,
                                style: const TextStyle(color: Colors.black),
                                items: ['1', '2', '3', '4', '5'].map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                      // editData['data']['activity']['calendar_recurrence_end_time']
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _dropDownValue = val as String;
                                    },
                                  );
                                  print("mansj");
                                  print(val);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     margin: EdgeInsets.all(10),
                    //     width: 100,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(5)),
                    //         border: Border.all(
                    //             color: const Color.fromRGBO(216, 216, 216, 1))),
                    //     child: Directionality(
                    //       textDirection: TextDirection.rtl,
                    //       child: DropdownButtonHideUnderline(
                    //         child: ButtonTheme(
                    //           alignedDropdown: true,
                    //           child: DropdownButton(
                    //             isExpanded: true,
                    //             menuMaxHeight: 300,
                    //             hint: _dropDownValueWeekly == null
                    //                 ? Text('Weekly', style: ktextStyle)
                    //                 : Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Text(
                    //                       _dropDownValueWeekly!,
                    //                       style: const TextStyle(
                    //                           color: Colors.black),
                    //                     ),
                    //                   ),
                    //             iconSize: 30.0,
                    //             style: const TextStyle(color: Colors.black),
                    //             items:
                    //                 ['Daily', 'Weekly', 'Monthly', 'Yearly'].map(
                    //               (val) {
                    //                 return DropdownMenuItem<String>(
                    //                   value: val,
                    //                   child: Text(val),
                    //                 );
                    //               },
                    //             ).toList(),
                    //             onChanged: (val) {
                    //               setState(
                    //                 () {
                    //                   _dropDownValueWeekly = val as String?;
                    //                 },
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 10),
                    const Text(
                      'פעילות זו חוזרת על עצמה כל',
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('רביעי'),
                    Container(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isWednesday,
                        onChanged: (bool? value) {
                          // This is where we update the state when the checkbox is tapped
                          setState(() {
                            isWednesday = value!;
                          });
                          print(value);
                        },
                      ),
                    ),
                    SizedBox(width: 29),
                    Text('שלישי'),
                    Container(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isTuesday,
                        onChanged: (bool? value) {
                          // This is where we update the state when the checkbox is tapped
                          setState(() {
                            isTuesday = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 29),
                    Text('שני'),
                    Container(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isMonday,
                        onChanged: (bool? value) {
                          // This is where we update the state when the checkbox is tapped
                          setState(() {
                            isMonday = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 29),
                    Text('ראשון'),
                    Container(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isSunday,
                        onChanged: (bool? value) {
                          // This is where we update the state when the checkbox is tapped
                          setState(() {
                            isSunday = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('שבת'),
                    Container(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isSaturday,
                        onChanged: (bool? value) {
                          // This is where we update the state when the checkbox is tapped
                          setState(() {
                            isSaturday = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 24),
                    Text('שישי'),
                    Container(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isFriday,
                        onChanged: (bool? value) {
                          // This is where we update the state when the checkbox is tapped
                          setState(() {
                            isFriday = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 24),
                    Text('חמישי'),
                    Container(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isThursday,
                        onChanged: (bool? value) {
                          // This is where we update the state when the checkbox is tapped
                          setState(() {
                            isThursday = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var date =
                            await selectDate(isDob: true, context: context);
                        if (date != "null") {
                          setState(() {
                            dobtextEditingController.text =
                                convertSingleDate(date);
                          });
                        }
                      },
                      child: Container(
                        child: ReceivingPaymentFields(
                          obscureText: false,
                          controller: dobtextEditingController,
                          onTap: () async {
                            var date =
                                await selectDate(isDob: true, context: context);
                            if (date != "null") {
                              setState(() {
                                dobtextEditingController.text =
                                    convertSingleDate(date);
                              });
                            }
                            print(dobtextEditingController.text);
                          },
                        ),

                        // TextFormField(
                        //   key: formkey,
                        //   // validator: validate(),
                        //   textAlign: TextAlign.center,
                        //   controller: dobtextEditingController,
                        //   // initialValue: "fhg",
                        //   onTap: () async {
                        //     var date =
                        //     await selectDate(isDob: true, context: context);
                        //     if (date != "null") {
                        //       setState(() {
                        //         dobtextEditingController.text =
                        //             convertSingleDate(date);
                        //       });
                        //     }
                        //   },
                        // ),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        // padding: EdgeInsets.only(left: 15),
                        width: 120,
                        // height: 100,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'הפעילות מתחילה החל מתאריך',
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'כמה דקות לפני תחילת הפעילות תרצו שמכירת הכרטיסים תיפסק? (השתדלו שמספר הדקות יהיה נמוך - רצוי 0-30 דקות)',
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: const Color.fromRGBO(216, 216, 216, 1))),
                  child: TextField(
                      controller: chooseDateBeforeController,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.end,
                      //controller: socialText,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        hintText: (timeOptionAddArray[index] - 1).toString(),
                      )),
                ),
                const SizedBox(height: 10),
                Text(
                  'האם ישנם תאריכים מסויימים שלא תוכלו לקיים את הפעילות?',
                  style: ktextStyleBold,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListView.builder(
                      itemCount: activityAddArray.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print("this is start time");
                        print(startingTime);
                        return addActivity(() {
                          activityAddArray.removeAt(index);
                          setState(() {});
                        }, () {
                          editViewArray[index] = !editViewArray[index];
                          height = editViewArray[index] ? 700 : 60;
                          setState(() {});
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          activityAddArray.add(1);
                          editViewArray.add(true);
                        });
                      },
                      child: Container(
                        height: 40,
                        width: width / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(112, 168, 49, 1)),
                        child: const Center(
                            child: Text('הוספה',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addActivity(VoidCallback onDeleteTap, VoidCallback onEditTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromRGBO(216, 216, 216, 1))),
              child: TextField(
                controller: startDOBtextEditingController,
                onTap: () async {
                  var date = await selectDate(isDob: true, context: context);
                  if (date != "null") {
                    setState(() {
                      startDOBtextEditingController.text =
                          convertSingleDate(date);
                    });
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: CustomIconButton(
                        onpressed: () async {
                          var date =
                              await selectDate(isDob: true, context: context);
                          if (date != "null") {
                            setState(() {
                              startDOBtextEditingController.text =
                                  convertSingleDate(date);
                            });
                          }
                        },
                        icon: Icons.calendar_today),
                    // disable: true,
                    // width: screenWidth(context) * 0.4,
                    //context: context,
                    hintText: 'd-m-Y'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(': ועד'),
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromRGBO(216, 216, 216, 1))),
              child: TextField(
                controller: endDOBtextEditingController,
                onTap: () async {
                  var date = await selectDate(isDob: true, context: context);
                  if (date != "null") {
                    setState(() {
                      endDOBtextEditingController.text =
                          convertSingleDate(date);
                    });
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: CustomIconButton(
                        onpressed: () async {
                          var date =
                              await selectDate(isDob: true, context: context);
                          if (date != "null") {
                            setState(() {
                              endDOBtextEditingController.text =
                                  convertSingleDate(date);
                            });
                          }
                        },
                        icon: Icons.calendar_today),
                    // disable: true,
                    // width: screenWidth(context) * 0.4,
                    //context: context,
                    hintText: 'd-m-Y'),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            onDeleteTap();
            endDOBtextEditingController.clear();
            startDOBtextEditingController.clear();
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(233, 108, 96, 1),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: const Center(
                child: Text('X',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white))),
          ),
        ),
      ],
    );
  }

  List<String> startDOBtextEditingText = [];

  List<String> startTimeManual = [''];
  List<String> endTimeManual = [''];

  Widget addCyclicalActivity(
    VoidCallback onDeleteTap,
    int index,
    TextEditingController dobtextEditingControllerManual0,
  ) {
    print('addCyclicalActivity addCyclicalActivity addCyclicalActivity');
    print(index);
    print(startTimeManual);
    print(endTimeManual);

    String start;
    String end;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // const Text(': Activity Starting From'),
              if (activeRadio2 == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: width / 3,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        216, 216, 216, 1))),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: dobtextEditingControllerManual0,
                              onTap: () async {
                                var date = await selectDate(
                                    isDob: true, context: context);
                                if (date != "null") {
                                  setState(() {
                                    dobtextEditingControllerManual0.text =
                                        convertSingleDate(date);
                                    startDOBtextEditingText.add(
                                        dobtextEditingControllerManual0.text);
                                  });
                                }
                              },
                            )),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'תאריך הפעילות',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: width,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                menuMaxHeight: 300,
                                hint: (startTimeManual[index] == '')
                                    ? Text(
                                        'HH:MM',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    : Text(
                                        startTimeManual[index],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                iconSize: 30.0,
                                style: const TextStyle(color: Colors.black),
                                items: items.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  return setState(
                                    () {
                                      // startingTimeManual = val as String?;
                                      print('ye konsa time h ');
                                      print(value.runtimeType);
                                      start = value as String;

                                      startTimeManual[index] = start;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: Text(
                          'ועד:',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: const Color.fromRGBO(216, 216, 216, 1))),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                menuMaxHeight: 300,
                                hint: (endTimeManual[index] == '')
                                    ? Text(
                                        'HH:MM',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    : Text(
                                        endTimeManual[index],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                iconSize: 30.0,
                                style: const TextStyle(color: Colors.black),
                                items: items.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    // endingTimeManual = val as String?;
                                    // endTimeManual.add(val as String);
                                    print('ye konsa time h ');
                                    print(value.runtimeType);
                                    end = value as String;

                                    endTimeManual[index] = end;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'החל מ:',
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: TextField(
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          textAlign: TextAlign.end,
                          controller: chooseBeforeControllerLIst[index],
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            //hintText: timeOptionAddArray[index].toString(),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'כמה דקות לפני תחילת הפעילות תרצו שמכירת הכרטיסים תיפסק? (השתדלו שמספר הדקות יהיה נמוך - רצוי 0-30 דקות)',
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  onDeleteTap();
                  dobtextEditingControllerManual0.clear();
                  startTimeManual.removeAt(index);
                  endTimeManual.removeAt(index);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(233, 108, 96, 1),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: const Center(
                      child: Text('X',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  int activeRadio = 1;
  int activeRadio2 = 1;
  TextEditingController nameEventController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController eventContentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController videoController = TextEditingController();

  TextEditingController discountCodeController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController dobtextEditingController = TextEditingController();

  TextEditingController startDOBtextEditingController = TextEditingController();
  TextEditingController endDOBtextEditingController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController UsersurNameController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userImageController = TextEditingController();
  TextEditingController userDescriptionController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController bankBranchController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController bankOwnerController = TextEditingController();
  TextEditingController chooseDateBeforeController = TextEditingController();

  final Completer<GoogleMapController> _mapController = Completer();

  PlatformFile? files;
  late final bool isEdit;
  List<Marker> positionMarkers = <Marker>[];
  List<int> ticketAddArray = [];
  List<bool> editViewArray = [true];
  double height = 700;
  bool coupon = false;
  String optionCalender = 'auto';
  String optionCalender2 = 'auto';
  String? startingTime;
  String? startingTimeManual;
  String? endingTime;
  String? endingTimeManual;
  String _dropDownValue = '1';
  String? _dropDownValueWeekly;
  List<int> timeOptionAddArray = [];
  List<int> cyclicalAndArray = [];

  bool isMonday = false;
  bool isTuesday = false;
  bool isWednesday = false;
  bool isThursday = false;
  bool isFriday = false;
  bool isSaturday = false;
  bool isSunday = false;
  var facebookImage;

  bool showText = false;
  ScrollController _scrollController = ScrollController(
    initialScrollOffset: 1050.0,
    keepScrollOffset: false,
  );

  String validateFields() {
    return '*field is required';
  }

  bool isValidated = false;
  bool isValidatedTime = false;
  var currentFocus;

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

//Main Screens in Create Events
  Widget generalActivity(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: _scrollController,
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text('פרטים כלליים',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      ReceivingPaymentFieldColumn(
                        controller: nameEventController,
                        label: ' כותרת הפעילות',
                        hintText: 'כותרת הפעילות',
                        obscureText: false,
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                  text: 'קטגוריה',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red)),
                                  ]),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                                    ),
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          // value: categoryController,
                                          isExpanded: true,
                                          // if(dropDownValue != null)
                                          value: dropDownValue,
                                          menuMaxHeight: 560,
                                          // hint: dropDownValue == null
                                          // ? const Padding(
                                          //         padding: EdgeInsets.all(8.0),
                                          //         child: Text(
                                          //           'ביחרו קטגוריה',
                                          //           style: TextStyle(
                                          //               color: Colors.grey),
                                          //         ),
                                          //       )
                                          //     : Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(8.0),
                                          //         child: Text(
                                          //           dropDownValue!,
                                          //           style: const TextStyle(
                                          //               color: Colors.black),
                                          //         ),
                                          //       ),
                                          iconSize: 30.0,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          items: categoryItems.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                alignment:
                                                    Alignment.centerRight,
                                                value: val,
                                                child: Text(
                                                  val,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              dropDownValue = val as String?;
                                              categoryController.text =
                                                  dropDownValue!
                                                      .replaceAll(
                                                          'אירוח קולינרי', '112')
                                                      .replaceAll(
                                                          'הופעה/מופע', '110')
                                                      .replaceAll(
                                                          'הרצאה', '101')
                                                      .replaceAll(
                                                          'מפגש חברתי', '105')
                                                      .replaceAll(
                                                          'סדנת בישול/אפיה',
                                                          '109')
                                                      .replaceAll(
                                                          'סדנת גוף/נפש', '114')
                                                      .replaceAll(
                                                          'סדנת יצירה', '102')
                                                      .replaceAll(
                                                          'פעילות לילדים',
                                                          '111');
                                            });

                                            print(
                                                'cat value cat value cat value cat value');
                                            print(val);
                                            print(dropDownValue
                                                ?.replaceAll(
                                                    'אירוח קולינרי', '112')
                                                .replaceAll('הופעה/מופע', '110')
                                                .replaceAll('הרצאה', '101')
                                                .replaceAll('מפגש חברתי', '105')
                                                .replaceAll(
                                                    'סדנת בישול/אפיה', '109')
                                                .replaceAll(
                                                    'סדנת גוף/נפש', '114')
                                                .replaceAll('סדנת יצירה', '102')
                                                .replaceAll(
                                                    'פעילות לילדים', '111'));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (dropDownValue == null && isValidated)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      validateFields(),
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'תארו את הפעילות בצורה מפורטת ככל הניתן:',
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        216, 216, 216, 1))),
                            child: TextField(
                                textDirection: TextDirection.rtl,
                                controller: eventContentController,
                                maxLines: 10,
                                textAlignVertical: TextAlignVertical.top,
                                // textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 10, right: 10),
                                  hintText: '',
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(),
                          child: Text('סוג הארוע',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Radio(
                                  value: 0,
                                  groupValue: activeRadio,
                                  onChanged: (int? value) {
                                    setState(() {
                                      activeRadio = value!;
                                    });
                                    print('----------------');
                                    print(value);
                                  },
                                ),
                              ),
                              const Text('אונליין'),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Radio(
                                  value: 1,
                                  groupValue: activeRadio,
                                  onChanged: (int? value) {
                                    setState(() {
                                      activeRadio = value!;
                                    });
                                  },
                                ),
                              ),
                              const Text('מיקום פיזי')
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (activeRadio == 1)
                        ReceivingPaymentFieldColumn(
                          controller: locationController,
                          label: 'הזינו כתובת מלאה, כולל מספר בית',
                          // hintText: 'הזינו כתובת מלאה, כולל מספר בית',
                          obscureText: false,
                          onChange: (v) {
                            application.searchPlaces(v);
                            setState(() {});
                          },
                          onFieldSubmit: (v) {
                            application.searchPlaces(v);
                          },
                        ),
                      if (application.searchResult != null &&
                          application.searchResult?.length != 0 &&
                          locationController.text.isNotEmpty)
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  15.0, // Move to right 10  horizontally
                                  15.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          height: 200,
                          width: double.infinity,
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                              itemCount: application.searchResult!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  visualDensity: VisualDensity.compact,
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  trailing: Icon(Icons.location_on),
                                  onTap: () async {
                                    print('list tile dabao');
                                    locationController.text = application
                                        .searchResult?[index].description;
                                    application.setSelectedLocation(
                                        application
                                            .searchResult![index].placeId!,
                                        context);
                                    setState(() {});
                                  },
                                  title: application.searchResult == null
                                      ? CupertinoActivityIndicator()
                                      : Text(
                                          "${application.searchResult?[index].description}",
                                          // "$translatedData",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.start,
                                        ),
                                );
                              }),
                        ),
                    ],
                  ),
                ),
              ),
              if (activeRadio == 1)
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: SizedBox(
                        height: 300,
                        width: 358,
                        child: GoogleMap(
                          mapToolbarEnabled: true,
                          gestureRecognizers: Set()
                            ..add(Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer())),
                          markers: {
                            Marker(
                              markerId: MarkerId(application
                                          .searchResult?.length !=
                                      0
                                  ? '${application.searchResult?[0].placeId}'
                                  : 'someId'),
                              infoWindow: InfoWindow(title: 'google maps test'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRose),
                              position: LatLng(
                                application.currentLocation?.latitude != null
                                    ? application.currentLocation!.latitude
                                    : 35.0,
                                application.currentLocation?.longitude != null
                                    ? application.currentLocation!.longitude
                                    : 40.0,
                              ),
                            ),
                            Marker(
                              markerId: MarkerId(application
                                          .searchResult?.length !=
                                      0
                                  ? '${application.searchResult?[0].placeId}'
                                  : 'someId'),
                              infoWindow:
                                  InfoWindow(title: 'google maps test2'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue),
                              position: LatLng(
                                  klatitude != null ? klatitude : 36.4219983,
                                  klongitude != null ? klongitude : -122.084),
                            ),
                          },
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                application.currentLocation?.latitude != null
                                    ? application.currentLocation!.latitude
                                    : 38.0,
                                application.currentLocation?.longitude != null
                                    ? application.currentLocation!.longitude
                                    : 50.0),
                            zoom: 14,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                            // print(GoogleMapController);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Container(
                width: width / 2.5,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: MaterialButton(
                  height: 50,
                  onPressed: () async {
                    validate();
                    // errorAlertMessage('errorMessage', context);
                    application.previewContentProvider =
                        eventContentController.text;
                    application.previewMapAddressProvider =
                        locationController.text;
                    application.previewTitleProvider = nameEventController.text;
                    application.previewCategoryProvider =
                        categoryController.text;
                    // application.previewImageProvider = imgfile;
                    // application.previewGalleryProvider = imagesList;
                    //EasyLoading.show();
                    await _createEventNetwork.postCreateEventsGeneral(
                        context,
                        LoginUser.shared?.userId! ??
                            application.idFromLocalProvider,
                        widget.id,
                        removeIndexImage!.isNotEmpty
                            ? removeIndexImage
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                                .replaceAll(' ', '')
                            : null);
                    application.showPreview = true;

                    if (dropDownValue == null) {
                      validateFields();
                      setState(() {
                        isValidated = true;
                      });
                    }
                  },
                  color: const Color.fromRGBO(112, 168, 49, 1),
                  child: const Center(
                      child: Text(
                    'שמירה והמשך',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pictureScreen(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        reverse: true,
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 250),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Text(
                        'תמונה ראשית',
                        style: ktextStyleBoldMedium,
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        '(התמונה צריכה להיות מלבנית לרוחב, מומלץ ביחס של 600X400)',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Container(
              //     alignment: Alignment.centerRight,
              //     child: Image.file(
              //       imgFilePicture!,
              //       height: 150,
              //       width: 150,
              //       fit: BoxFit.contain,
              //     )),
              // Text(imgFilePicture.toString()),
              // editData != null
              // ?
              Container(
                alignment: Alignment.centerRight,
                child: editData != null &&
                        editData['data']['thumbnail_event'] != null &&
                        imgFilePicture == null
                    ? Image.network(
                        '${editData['data']['thumbnail_event']}',
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain,
                      )
                    : imgFilePicture != null
                        ? Image.file(
                            imgFilePicture!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.contain,
                          )
                        : SizedBox(),
              ),
              // : SizedBox(),

              SizedBox(
                height: 10,
              ),
              //  (filetextEditingController.text.isEmpty)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    width: 140,
                    child: MaterialButton(
                      height: 50,
                      onPressed: () async {
                        await pickPicture(context: context).then((value) {
                          print("value dsajhbsadh");
                          print(value);
                          if (value.isNotEmpty) {
                            setState(() {
                              imgFilePicture = value[0];
                              imgDataPicture = value[1];
                            });
                          }
                        });
                        setState(() {});
                      },
                      color: const Color.fromRGBO(112, 168, 49, 1),
                      child: const Center(
                          child: Text(
                        'הוספת תמונה',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text('תמונות נוספות',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              const SizedBox(height: 20),

              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        width: 140,
                        child: MaterialButton(
                          height: 50,
                          onPressed: loadAssets,
                          color: const Color.fromRGBO(112, 168, 49, 1),
                          child: const Center(
                              child: Text(
                            'הוספת תמונות',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                  ),
                  if (imagesList.isNotEmpty || imagesListEdit != null)
                    Container(
                        height: 100,
                        //  alignment: Alignment.centerRight,
                        child: buildGridView())
                ],
              ),

              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text('סרטון וידאו',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color.fromRGBO(216, 216, 216, 1))),
                      child: TextField(
                          onTap: () {
                            setState(() {
                              showText = true;
                            });
                            print(showText);
                          },
                          controller: videoController,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          // textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10),
                            hintText: 'https://',
                          )),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'הוספת לינק לסרטון וידאו למשל: https://www.youtube.com/watch?v=5wZ9LcEbulg\nאו: https://player.vimeo.com/video/23534361',
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom / 1.5),
                child: GestureDetector(
                  onTap: () async {
                    application.previewImageProvider = imgFilePicture;
                    application.previewGalleryProvider = imagesList;
                    // _createEventNetwork.postCreateEventsGeneral(context);
                    application.validate();

// print("iop");
// print(multipartImageList);
// return;

                    //EasyLoading.show();
                    await _createEventNetwork.postCreateEventsMedia(
                      context,
                      widget.id,
                      imgFilePicture?.path,
                      imgDataPicture,
                      videoController.text,
                      removeIndexImage!.isNotEmpty
                          ? removeIndexImage
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceAll(' ', '')
                          : null,
                      multipartImageList,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    width: width / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(112, 168, 49, 1)),
                    child: const Center(
                        child: Text('שמירה והמשך',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 17))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ticketScreen(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 100,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 25),
              ListView.builder(
                addAutomaticKeepAlives: false,
                itemCount: ticketAddArray.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print('list view builder');

                  return addTicket(
                    () {
                      ticketAddArray.removeAt(index);
                      setState(() {});
                    },
                    () {
                      editViewArray[index] = !editViewArray[index];
                      height = editViewArray[index] == true ? 700 : 60;
                      setState(() {});
                    },
                    index,
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    ticketAddArray.add(0);
                    editViewArray.add(true);
                    showTicket.add(false);
                    nameTicketControllerList
                        .add(TextEditingController(text: 'כרטיס רגיל'));
                    priceTicketControllerList
                        .add(TextEditingController(text: ''));
                    descTicketControllerList
                        .add(TextEditingController(text: ''));
                    numOfTicketControllerList
                        .add(TextEditingController(text: ''));
                  });
                },
                child: Container(
                  height: 50,
                  width: width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(112, 168, 49, 1)),
                  child: const Center(
                    child: Text(
                      'הוספת כרטיס נוסף',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              coupon == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              width: 220,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          216, 216, 216, 1))),
                              child: TextField(
                                  controller: discountCodeController,
                                  maxLines: 1,
                                  textAlignVertical: TextAlignVertical.top,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    hintText: 'קוד קופון',
                                  )),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.only(right: 15, left: 15),
                            child: Text(
                              'קוד הקופון צריך להכיל 5 תווים לפחות',
                              textAlign: TextAlign.right,
                              style: TextStyle(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 15, left: 15),
                            child: Text(
                              'נא להשתמש באותיות באנגלית ומספרים בלבד (ללא תווים מיוחדים)',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              216, 216, 216, 1))),
                                  child: TextField(
                                      controller: discountAmountController,
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        hintText: '5',
                                      )),
                                ),
                              ),
                              const Text(
                                ':סכום ההנחה בשקלים',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 170,
                            child: MaterialButton(
                              height: 50,
                              onPressed: () {
                                setState(() {
                                  coupon = false;
                                });
                              },
                              color: const Color.fromRGBO(233, 108, 96, 1),
                              child: const Center(
                                  child: Text(
                                'הסרת קופון',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )),
                            ),
                          ),
                        ])
                  : Container(),
              coupon == true
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          coupon = true;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: width / 2.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(112, 168, 49, 1)),
                        child: const Center(
                            child: Text('הוספת קופון הנחה',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))),
                      ),
                    ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    application.previewTicketProvider =
                        priceTicketControllerList[0].text;
                    application.validate();
                    // _createEventNetwork.postCreateEventsTicket(context);
                    // _createEventNetwork.postCreateEventsTicketCoupon(context);
                    //EasyLoading.show();
                    await _createEventNetwork.postCreateEventsTicket(
                        context,
                        priceTicketControllerList,
                        numOfTicketControllerList,
                        descTicketControllerList,
                        widget.id,
                        nameTicketControllerList,
                        ticketID);
                    await _createEventNetwork.postCreateEventsTicketCoupon(
                        context,
                        discountCodeController.text,
                        discountAmountController.text,
                        widget.id);
                  },
                  child: Container(
                    height: 50,
                    width: width / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(112, 168, 49, 1)),
                    child: const Center(
                        child: Text(
                      'שמירה והמשך',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget activityItemScreen(BuildContext context) {
    if (application.myActivityEditPage != null) {
      print(application
          .myActivityEditPage!.data!.activity!.calendarRecurrenceStartTime);
    }
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    'אפשרויות זמנים:',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Radio(
                            value: 0,
                            groupValue: activeRadio2,
                            onChanged: (int? value) {
                              print(value);
                              setState(() {
                                activeRadio2 = value!;
                                optionCalender = 'manual';
                              });
                              print('optionCalender postCreateEventsCalender');
                              print(optionCalender);
                            },
                          ),
                        ),
                        const Text('תאריכים ספציפיים'),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Radio(
                            value: 1,
                            groupValue: activeRadio2,
                            onChanged: (int? value) {
                              print(
                                  '$value oooooooooooooooooooooopppppppppppppppp');
                              setState(() {
                                activeRadio2 = value!;
                                // optionCalender = 'auto';
                              });
                              print(optionCalender);
                            },
                          ),
                        ),
                        const Text('פעילות מחזורית ')
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // if (activeRadio == 0)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Expanded(
              //         flex: 2,
              //         child: Align(
              //           alignment: Alignment.centerRight,
              //           child: Container(
              //               width: width / 3,
              //               decoration: BoxDecoration(
              //                   borderRadius:
              //                       const BorderRadius.all(Radius.circular(5)),
              //                   color: Colors.white,
              //                   border: Border.all(
              //                       color: const Color.fromRGBO(
              //                           216, 216, 216, 1))),
              //               child: TextField(
              //                 textAlign: TextAlign.center,
              //                 controller: dobtextEditingController,
              //                 onTap: () async {
              //                   var date = await selectDate(
              //                       isDob: true, context: context);
              //                   if (date != "null") {
              //                     setState(() {
              //                       dobtextEditingController.text =
              //                           convertSingleDate(date);
              //                     });
              //                   }
              //                 },
              //               )),
              //         ),
              //       ),
              //       Expanded(
              //         child: Text(
              //           'תאריך הפעילות',
              //           textAlign: TextAlign.right,
              //         ),
              //       ),
              //     ],
              //   ),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: activeRadio == 1
                    ? timeOptionAddArray.length
                    : cyclicalAndArray.length,
                itemBuilder: (context, index) {
                  // List<String> manualStartTime = [];
                  // List<String> manualEndTime = [];
                  TextEditingController dobtextEditingControllerManual0 =
                      TextEditingController();

                  controllerList.add(dobtextEditingControllerManual0);
                  return activeRadio2 == 1
                      ? addSpecificDates(() {
                          timeOptionAddArray.removeAt(index);
                          setState(() {});
                        }, index)
                      : addCyclicalActivity(
                          () {
                            cyclicalAndArray.removeAt(index);
                            setState(() {});
                          },
                          index,
                          controllerList[index],
                        );
                },
              ),

              if (activeRadio == 0)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        print('sssssssssssss');
                        setState(() {
                          cyclicalAndArray.add(cyclicalAndArray.length + 1);
                          chooseBeforeControllerLIst
                              .add(TextEditingController());
                          startTimeManual.add('');
                          endTimeManual.add('');
                        });
                      },
                      child: Container(
                        height: 50,
                        width: width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(112, 168, 49, 1)),
                        child: const Center(
                            child: Text('הוספת תאריך נוסף',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 170,
                child: MaterialButton(
                  height: 50,
                  onPressed: () async {
                    if (startingTime == null || endingTime == null) {
                      validateFields();
                      setState(() {
                        isValidatedTime = true;
                      });
                    }
                    application.previewDateProvider =
                        dobtextEditingController.text;
                    print("sdskz");
                    print(activeRadio2);
                    if (optionCalender2 == 'auto') {
                      validate();
                      print("auto wala chala");

                      //EasyLoading.show();
                      application.validate();
                      await _createEventNetwork.postCreateEventsCalender(
                        context,
                        optionCalender,
                        startingTime,
                        endingTime,
                        dobtextEditingController.text,
                        _dropDownValue,
                        _dropDownValueWeekly,
                        isSunday == true ? '0' : null,
                        isMonday == true ? '1' : null,
                        isTuesday == true ? '2' : null,
                        isWednesday == true ? '3' : null,
                        isThursday == true ? '4' : null,
                        isFriday == true ? '5' : null,
                        isSaturday == true ? '6' : null,
                        chooseDateBeforeController.text,
                        chooseBeforeControllerLIst,
                        startDOBtextEditingController.text,
                        endDOBtextEditingController.text,
                        widget.id,
                        startDOBtextEditingText,
                        startTimeManual,
                        endTimeManual,
                      );
                    } else {
                      print('mannuuaall!!!');
                      //EasyLoading.show();
                      application.validate();
                      await _createEventNetwork.postCreateEventsCalender(
                        context,
                        optionCalender,
                        startingTime,
                        endingTime,
                        dobtextEditingController.text,
                        _dropDownValue,
                        _dropDownValueWeekly,
                        isSunday == true ? '0' : null,
                        isMonday == true ? '1' : null,
                        isTuesday == true ? '2' : null,
                        isWednesday == true ? '3' : null,
                        isThursday == true ? '4' : null,
                        isFriday == true ? '5' : null,
                        isSaturday == true ? '6' : null,
                        chooseDateBeforeController.text,
                        chooseBeforeControllerLIst,
                        startDOBtextEditingController.text,
                        endDOBtextEditingController.text,
                        widget.id,
                        startDOBtextEditingText,
                        startTimeManual,
                        endTimeManual,
                      );
                    }
                    // //EasyLoading.show();
                    // _createEventNetwork.postCreateEventsCalender(context);
                  },
                  color: const Color.fromRGBO(112, 168, 49, 1),
                  child: const Center(
                      child: Text(
                    'שמירה והמשך',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileActivityScreen(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 25),
                Container(
                    height: 200,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: imgfile != null
                        ? Image.file(
                            imgfile!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.contain,
                          )
                        : authorImage != null
                            ? Image.network(
                                authorImage!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.contain,
                              )
                            : application.myActivityEditPage?.data?.authorData
                                        ?.authorImg !=
                                    null
                                ? Image.network(
                                    '${application.myActivityEditPage?.data?.authorData?.authorImg}',
                                    fit: BoxFit.fill,
                                  )
                                : application.imageFromFacebook != null
                                    ? Image.network(
                                        '${application.imageFromFacebook}',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/images/dummy_user.png')),

                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          imgfile = null;
                          application.imageFromFacebook = null;
                          _updateAndGetUserProfile
                              .getUserData?.data?.authorImage = null;
                          authorImage = null;
                        });
                      },
                      child: Text(
                        'הסרת תמונה',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var fileList =
                            await pickPicture(context: context).then((value) {
                          print("akjsjjaka");
                          print(value);
                          if (value.isNotEmpty) {
                            setState(() {
                              imgfile = value[0];
                              imgData = value[1];
                            });
                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        width: width / 2.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(112, 168, 49, 1)),
                        child: const Center(
                            child: Text(
                          'הוספת תמונה',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // const Text('גודל מומלץ 400x400 פיקסלים',
                //     style: TextStyle(fontSize: 18)
                // ),
                SizedBox(
                  height: 30,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        ReceivingPaymentFields(
                          controller: firstnameController,
                          obscureText: false,
                          label: 'שם פרטי',
                          showRequired: false,
                          showLabel: true,
                          // hintText: 'שֵׁם',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ReceivingPaymentFields(
                          controller: lastnameController,
                          obscureText: false,
                          label: 'שם משפחה',
                          showRequired: false,
                          showLabel: true,

                          // hintText: 'שֵׁם',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ReceivingPaymentFields(
                          controller: userAddressController,
                          obscureText: false,
                          label: 'דואר אלקטורני',
                          showRequired: false,
                          showLabel: true,
                          // hintText: 'שֵׁם',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ReceivingPaymentFields(
                          controller: userPhoneController,
                          obscureText: false,
                          label: 'טלפון נייד',
                          showRequired: false,
                          showLabel: true,
                          // hintText: 'שֵׁם',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ReceivingPaymentFields(
                          controller: userDescriptionController,
                          maxLine: 10,
                          obscureText: false,
                          label: 'ספרו על עצמכם',
                          showLabel: true,
                          // hintText: 'שֵׁם',
                          showRequired: false,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 35),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      application.previewFirstnameProvider =
                          firstnameController.text;
                      application.previewLastnameProvider =
                          lastnameController.text;
                      application.previewAuthorDescriptionrovider =
                          userDescriptionController.text;
                      application.previewAuthorImagerovider = imgfile;
                      validate();
                      //EasyLoading.show();

                      await updateaandgetuserprofile.getUpdateUserData(
                          LoginUser.shared?.userId! ??
                              application.idFromLocalProvider,
                          firstnameController.text,
                          lastnameController.text,
                          userAddressController.text,
                          userPhoneController.text,
                          userDescriptionController.text,
                          imgfile?.path,
                          imgData,
                          context,
                          isRemoveDp);
                    },
                    child: Container(
                      height: 50,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(112, 168, 49, 1)),
                      child: const Center(
                          child: Text(
                        'שמירה והמשך',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget receivingPaymentActivity(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'פרטי חשבון בנק',
                          style: ktextStyleBoldMedium,
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          '(על מנת שנוכל להעביר לכם את התשלום)',
                          style: ktextStyle,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      ReceivingPaymentFields(
                        showLabel: true,
                        controller: bankOwnerController,
                        obscureText: false,
                        label: 'שם בעל/ת חשבון',
                        showRequired: false,

                        // hintText: 'Account Holder Name',
                      ),
                      const SizedBox(height: 20),
                      ReceivingPaymentFields(
                        showLabel: true,
                        controller: bankNumberController,
                        obscureText: false,
                        label: 'מספר חשבון',
                        showRequired: false,

                        // hintText: 'Account Number',
                      ),
                      const SizedBox(height: 20),
                      ReceivingPaymentFields(
                        showLabel: true,
                        controller: bankNameController,
                        obscureText: false,
                        label: 'שם הבנק',
                        showRequired: false,

                        // hintText: 'Bank Name',
                      ),
                      const SizedBox(height: 20),
                      ReceivingPaymentFields(
                        showLabel: true,
                        controller: bankBranchController,
                        obscureText: false,
                        label: 'סניף',
                        showRequired: false,
                        // hintText: 'Branch',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                    visible: application.showPreview,
                    replacement: SizedBox(
                      width: 100,
                    ),
                    child: Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PreviewEventDetailScreen()));
                        },
                        child: Container(
                          height: 80,
                          // width: 180,
                          padding: EdgeInsets.symmetric(vertical: 15),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(112, 168, 49, 1)),
                          child: const Center(
                              child: Text(
                            ' תצוגה מקדימה של הפעילות',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        await _createEventNetwork.postCreateEventsUserPayment(
                            context,
                            LoginUser.shared?.userId! ??
                                application.idFromLocalProvider,
                            bankOwnerController.text,
                            bankNumberController.text,
                            bankNameController.text,
                            bankBranchController.text);
                        // validate();
                        // if (nameEventController.text.isNotEmpty &&
                        //     categoryController.text.isNotEmpty &&
                        //     bankOwnerController.text.isNotEmpty &&
                        //     bankNumberController.text.isNotEmpty &&
                        //     bankBranchController.text.isNotEmpty &&
                        //     bankNameController.text.isNotEmpty) {
                        //   // //EasyLoading.show();
                        //   // await _createEventNetwork.postCreateEventsGeneral(
                        //   //     context,
                        //   //     LoginUser.shared?.userId! ??
                        //   //         application.idFromLocalProvider,
                        //   //     widget.id);
                        //   // await _createEventNetwork
                        //   //     .postCreateEventsTicket(context);
                        //   // await _createEventNetwork
                        //   //     .postCreateEventsTicketCoupon(context);
                        //   // await _createEventNetwork
                        //   //     .postCreateEventsCalender(context);
                        //   // await _createEventNetwork
                        //   //     .postCreateEventsUpdateProfile(
                        //   //   context,
                        //   //   LoginUser.shared?.userId! ??
                        //   //       application.idFromLocalProvider,
                        //   // );
                        //
                        //   await _createEventNetwork.postCreateEventsUserPayment(
                        //       context,
                        //       LoginUser.shared?.userId! ??
                        //           application.idFromLocalProvider,
                        //       bankOwnerController.text,
                        //       bankNumberController.text,
                        //       bankNameController.text,
                        //       bankBranchController.text);
                        // } else {
                        //   errorAlertMessage(
                        //       'Some fields are missing !!', context);
                        // }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        height: 80,
                        // width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(112, 168, 49, 1)),
                        child: const Center(
                            child: Text(
                          'העברת פעילות לבדיקה',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // application.dispose();
    locationSubscription?.cancel();
    _scrollController.dispose();
    lastnameController.dispose();
    firstnameController.dispose();
    startDOBtextEditingController.dispose();
    endDOBtextEditingController.dispose();
    discountCodeController.dispose();
    categoryController.dispose();
    chooseDateBeforeController.dispose();
    bankBranchController.dispose();
    bankNameController.dispose();
    bankNumberController.dispose();
    bankOwnerController.dispose();
    nameEventController.dispose();
    // ticketPriceController.dispose();
    // ticketDescriptionController.dispose();
    discountAmountController.dispose();
    userAddressController.dispose();
    userDescriptionController.dispose();
    userImageController.dispose();
    userPhoneController.dispose();
    videoController.dispose();
    nameTicketControllerList.clear();
    priceTicketControllerList.clear();
    descTicketControllerList.clear();
    numOfTicketControllerList.clear();
    super.dispose();
  }

  void errorAlertMessage(String errorMessage, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ApplicationBloc _applicationBloc = ApplicationBloc();
  late final application = Provider.of<ApplicationBloc>(context);

  @override
  Widget build(BuildContext context) {
    print("jkhsxajk");
    print(optionCalender);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${widget.id == null ? 'יצירת פעילות חדשה' : 'Edit Event'}',
              textAlign: TextAlign.end,
              style: ktextStyleLarge,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      application.currentIndex = 1;
                      setState(() {});
                      print('6');
                    },
                    child: Container(
                      height: 50,
                      width: width / 5.5,
                      margin: const EdgeInsets.only(right: 5, left: 8),
                      color: application.currentIndex == 1
                          ? const Color.fromRGBO(233, 108, 96, 1)
                          : const Color.fromRGBO(197, 197, 197, 1),
                      child: Center(
                          child: Text(
                        'קבלת תשלום',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: application.currentIndex == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      application.currentIndex = 2;
                      setState(() {});
                      print('5');
                    },
                    child: Container(
                      height: 50,
                      width: width / 5.5,
                      margin: const EdgeInsets.only(right: 5),
                      color: application.currentIndex == 2
                          ? const Color.fromRGBO(233, 108, 96, 1)
                          : const Color.fromRGBO(197, 197, 197, 1),
                      child: Center(
                          child: Text('פרופיל',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: application.currentIndex == 2
                                    ? Colors.white
                                    : Colors.black,
                              ))),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      application.currentIndex = 3;
                      setState(() {});
                      print('4');
                    },
                    child: Container(
                      height: 50,
                      width: width / 5.5,
                      margin: const EdgeInsets.only(right: 5),
                      color: application.currentIndex == 3
                          ? const Color.fromRGBO(233, 108, 96, 1)
                          : const Color.fromRGBO(197, 197, 197, 1),
                      child: Center(
                          child: Text('זמני הפעילות',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: application.currentIndex == 3
                                    ? Colors.white
                                    : Colors.black,
                              ))),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      application.currentIndex = 4;
                      print('ticket');
                      setState(() {});
                      print('3');
                    },
                    child: Container(
                      height: 50,
                      width: width / 5.5,
                      margin: const EdgeInsets.only(right: 5),
                      color: application.currentIndex == 4
                          ? const Color.fromRGBO(233, 108, 96, 1)
                          : const Color.fromRGBO(197, 197, 197, 1),
                      child: Center(
                          child: Text('כרטיסים',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: application.currentIndex == 4
                                    ? Colors.white
                                    : Colors.black,
                              ))),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      application.currentIndex = 5;
                      print('ticket');
                      setState(() {});
                      print('2');
                    },
                    child: Container(
                      height: 50,
                      width: width / 5.5,
                      margin: const EdgeInsets.only(right: 5),
                      color: application.currentIndex == 5
                          ? const Color.fromRGBO(233, 108, 96, 1)
                          : const Color.fromRGBO(197, 197, 197, 1),
                      child: Center(
                          child: Text('תמונות',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: application.currentIndex == 5
                                    ? Colors.white
                                    : Colors.black,
                              ))),
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    application.currentIndex = 6;
                    setState(() {});
                    print('1');
                  },
                  child: Container(
                    height: 50,
                    width: width / 5.5,
                    color: application.currentIndex == 6
                        ? const Color.fromRGBO(233, 108, 96, 1)
                        : const Color.fromRGBO(197, 197, 197, 1),
                    child: Center(
                        child: Text('כללי',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: application.currentIndex == 6
                                  ? Colors.white
                                  : Colors.black,
                            ))),
                  ),
                ))
              ],
            ),
          ),
          if (application.currentIndex == 1) receivingPaymentActivity(context),
          if (application.currentIndex == 2) profileActivityScreen(context),
          if (application.currentIndex == 4) ticketScreen(context),
          if (application.currentIndex == 5) pictureScreen(context),
          if (application.currentIndex == 6) generalActivity(context),
          if (application.currentIndex == 3) activityItemScreen(context),
          // if (application.currentIndex == 3) ActivityItemScreen(),
        ],
      ),
    );
  }

  Future<void> _goToPlace(place) async {
    print('ye rhi place');
    print(place.lat);
    print(place.lng);
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(place.lat, place.lng), zoom: 15),
      ),
    );
    setState(() {
      klatitude = place.lat;
      klongitude = place.lng;
      application.previewLatProvider = place.lat;
      application.previewLngProvider = place.lng;
    });
  }
}

//ignore: missing_return
