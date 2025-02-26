
import 'package:dsr_clone/environment/base_config.dart';

import 'environment.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiClient => 'MOBILE';

  @override
  String get env => Environment.PROD;

  @override
  String get baseurl => 'https://azureimossuat.azurewebsites.net';
  

  @override
  String get defaultToken => 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InN0cmluZyIsInN1YiI6InN0cmluZyIsImp0aSI6IjY0ZTI3Yjc1LWU1MjQtNDk1YS1hYjcwLWYzNWJjMjgzODkxMSIsImF1ZCI6IiIsImlzcyI6IiIsImlhdCI6MTcxMjczNDkyMCwibmJmIjoxNzEyNzM0OTIwLCJleHAiOjE3MTI3Mzg1MjAsInBsYXRmb3JtIjoibW9iaWxlIn0.XcE9pWlOeSM8hBKfffOd7xPpTcXgmLfjsgkmWfZYf4w';

  @override
  bool get reportErrors => false;

  @override
  int get timeout => 1;
}
