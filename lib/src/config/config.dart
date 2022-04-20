/// default dart class name if none provided in yaml file
const String dartClassName = 'EnvConfig';

/// default output path for dart class if none provided in yaml file
List<String> dartBuildTo = ['lib'];

/// default output path for dart class if none provided in yaml file
List<String> tsBuildTo = ['functions/src'];

/// name of the key field in yaml file
const String keysField = 'keys';

/// name of the value field in yaml file
const String valueField = 'value';

/// name of the build_to field in yaml file
const String buildToField = 'build_to';

/// name of the info field in yaml file
const String infoField = 'info';

/// name of the output_format field in yaml file
const String outputFormatsField = 'output_formats';

/// name of the flavors field in yaml file
const String flavorsField = 'flavors';

/// defauilt filename for typesctript constants
const String flavoredEnvFile = 'flavored_env';

/// defauilt typesctript file extension
const String tsExtension = '.g.ts';

/// defauilt dart file extension
const String dartExtension = '.g.dart';

/// default config file header
String configFileHeader({
  required String comment,
  required String flavorName,
}) =>
    '''
$comment AUTO-GENERATED - DO NOT MODIFY THIS FILE
$comment ----------------------------------------
$comment FLAVOR: $flavorName

''';

/// default yaml filename
const String yamlTemplateName = 'flavored_env.yaml';

/// template yaml content to kickstart customization
const String yamlTemplateContent = '''
output_formats:
  dotenv:
    # Dotenv output options
    build_to:
      - functions
  dart:
    # Dart output options
    build_to:
      - "lib/config"
    class_name: "EnvConfig"

  typescript:
    # Typescript output options
    build_to:
      - "functions/src"

flavors:
  default:
    keys:
      DEFAULT_TARGET_HOURS:
        value: 16
        info: Default target hours

      COLLECTION_USER_PROFILES:
        value: "users"
        info: collection of user profiles

      COLLECTION_AVATARS:
        value: "avatars"
        info: collection of user avatars

      COLLECTION_APP_USERS:
        value: "app-users"
        info: collection for app-wide information

      DOCUMENT_APP_USERS_TOTAL:
        value: "users-total"
        info: document holding total users

      COLLECTION_TRACKERS:
        value: "trackers"
        info: collection of active trackers

      DOCUMENT_APP_USERS_FASTING:
        value: "users-fasting"
        info: document holding total fasting users

      COLLECTION_USER_SESSIONS:
        value: "sessions"
        info: collection of sessions for user

      DEBUG_DELAY:
        value: 0
        info: A delay in milliseconds used for testing

      SLACK_WEBHOOK_BASE_URL:
        value: "https://hooks.slack.com/services/T037QP90QN9"
        info: Slack webhook base URL

  staging:
    keys:
      SLACK_SIGNUPS_WEBHOOK:
        value: "B038C5B2A15/3ysdlkf5SrJOF2pqoGvV078gHB"
        info: Slack webhook for user sign-up notification

      DEBUG_DELAY:
        value: 1000
        info: A delay in milliseconds used for testing

  development:
    keys:
      SLACK_SIGNUPS_WEBHOOK:
        value: "GEW7QTHPW77/SQqmocFslk32ORQXqR7qyqI"
        info: Slack webhook for user sign-up notification

      DEBUG_DELAY:
        value: 4000
        info: A delay in milliseconds used for testing

  production:
    keys:
''';
