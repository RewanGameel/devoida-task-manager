class Constants {
  //ADD BASE URL HERE
  static String appBaseUrl = 'https://api.qwizeen.io/';
  static const String stageBaseUrl = 'https://stage.stagingserver.io/';
  static const String devBaseUrl = 'https://.dev.stagingserver.io/';
  static const String qCBaseUrl = 'https://.qc.stagingserver.io/';

  //FIRESTORE COLLECTION KEYS
  static const String PROJECTS_COLLECTION_KEY = 'projects';
  static const String TASKS_COLLECTION_KEY = 'tasks';
  static const String USERS_COLLECTION_KEY = 'users';

  static String empty = '';
  static bool isEmpty = false;
  static String apiToken = '';
  static int zero = 0;
  static double zeroDec = 0.0;
  static int apiTimeout = 200000;
  static int dataDelayMilliseconds = 200;
  static int tokenRefreshThreshold = 2;
}
