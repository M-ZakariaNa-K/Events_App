import 'package:events_app/User_App/model/resently_added_model.dart';
import 'package:get_storage/get_storage.dart';

// String token = '6|chFSeGAoVQgrSfQL0XE43LCOwXxc2AAYjW2TSkHf2b67f793';
//organizer
String token = '2|Oso2onHeVvlTm62ciXWj48syL3shRiwkwVWSqkMh997b7172';
//hall
// String token = '26|cEqiEEXRlQoTDNL38ATR0CxJTiVL4mZcm4ds6cyv501d7667';
const bool isUser = true;
const bool isHallOwner = false;
Map<String, dynamic> showStartDateMap = {
  "date": "",
};
Map<String, dynamic> showEndDateMap = {
  "date": "",
};
String userEmail = '';
String baseUrl = 'http://10.0.2.2:8000/api';
String photoBaseUrl = 'http://10.0.2.2:8000/storage/';
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

//NOTE(from ZAKARIA): I use a SARED VARAIBLE becuse when i make the first request the book controller termenated
//and rebuild it's self => so the selectedImagesaPaths become empty when i book
// so i saved is value in shared var
List<String> sharedSelectedPublicEventImagePaths = [];
//=================For Search=================
int sharedSelectedSearchIdentifier = 0;
//=================For New ON THE APP=================
List<RecentlyAddedDataModel>? sharedResntlyOrganizerAddedItems = [];
List<RecentlyAddedDataModel>? sharedResntlyLoungeAddedItems = [];
//===================For organizer ========================
