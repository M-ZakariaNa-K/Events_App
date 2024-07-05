import 'package:get_storage/get_storage.dart';

String token = '5|W4G8NQCk7rVL35g6nq8d9RdGsx1X2YmdkdsvI4Sh4e0cd238';
final bool isUser = false;
final bool isHallOwner = true;
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
