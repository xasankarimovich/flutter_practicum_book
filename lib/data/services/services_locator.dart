import 'package:buksam_flutter_practicum/data/services/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

 GetIt getIt = GetIt.instance;

void setUP(){
  getIt.registerFactory<FirebaseAuthService>(()=>FirebaseAuthService());
}