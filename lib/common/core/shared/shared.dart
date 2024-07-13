import 'package:events_app/User_App/model/resently_added_model.dart';
import 'package:get_storage/get_storage.dart';

String token = '6|chFSeGAoVQgrSfQL0XE43LCOwXxc2AAYjW2TSkHf2b67f793';
const bool isUser = true;
const bool isHallOwner = false;
String userEmail = '';
String baseUrl = 'http://10.0.2.2:8000/api';
// String baseUrl = 'http://127.0.0.1:8000/api';
final box = GetStorage();
String createPasswordEmail = '';
//=================For reservation====================
var starthourShared = 0;
var startminuteShared = 0;
var endhourShared = 0;
var endminuteShared = 0;
//second slide page
int sharedServiceId = 0;
//=================For New ON THE APP=================
List<RecentlyAddedDataModel>? sharedResntlyOrganizerAddedItems = [];
List<RecentlyAddedDataModel>? sharedResntlyLoungeAddedItems = [];
