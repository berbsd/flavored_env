# `flavored_env`

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![coverage][coverage_badge]][ci_link]
[![pub package][pub_badge]][pub_link]
[![ci][ci_badge]][ci_link]


Generate and synchronize dotenv and dart configuration classes for your firebase application.

Flavored_env is useful if you need to maintain a common set of constants between your cloud functions and your flutter application. It generates dotenv files for your cloud function deployments as well as corresponding dart class for your application. It supports flavors and the ability to create copies in multiple locations. 

The tools was developed for a personal project to help keep constants in sync during development. Hopefully it can be helpful to others. Do let me know if you are interested in additional features. 

# Features 

* Manage all application and cloud constants in single file
* Create dotenv and Dart classes from configuration
* Supports multiple flavors, copies and locations

## Installation

This package is intended to support development of Dart projects with
[`package:build`][]. In general, put it under [dev_dependencies][], in your
[`pubspec.yaml`][pubspec].

```yaml
dev_dependencies:
  build_runner:
```

### Built-in Commands

The `flavord_env` package exposes a binary by the same name, which can be
invoked using `dart run flavored_env <command>`.

The available commands are

- `create-yaml`: create a sample flavored_env.yaml file.
- `generate`: generate the configuration files based on yaml file
  edits and does rebuilds as necessary.

### flavored_env.yaml 

Create a template ```flavored_env.yaml``` in your project root by running:

```pub run flavored_env --create-yaml```

The default sample will look like this

```yaml
# flavored_env example

output_formats:
  dotenv:
    # Dotenv output options
    build_to:
      - functions
  dart:
    # Dart output options
    build_to:
      - "functions/lib/config"
    class_name: "FlavoredEnv"

  typescript:
    # Typescript output options
    build_to:
      - "functions/src"

flavors:
  default:
    keys:
      COLLECTION_USER_PROFILES:
        value: "users"
        info: collection of user profiles

      COLLECTION_AVATARS:
        value: "avatars"
        info: collection of user avatars

      COLLECTION_USER_SESSIONS:
        value: "sessions"
        info: collection of sessions for user

      DEBUG_DELAY:
        value: 0
        info: A delay in milliseconds used for testing


  staging:
    keys:
      DEBUG_DELAY:
        value: 1000
        info: A delay in milliseconds used for testing

  development:
    keys:
      DEBUG_DELAY:
        value: 4000
        info: A delay in milliseconds used for testing

  production:
    keys:

```

After config is specified in YAML file run following command

```pub run flavored_env --generate```


## Yaml Specification

`dotenv_to` to indicate the list of relative paths where to create the dotenv files.

`class_to` to indicate the list of relative paths where to create the dart files. 

`class_name` to specivy the name of the class to use, default to ```EnvConfig```

`flavors` to specify each flavor or development environment

`default` environment (optional) is used for the base configuration. Its content will be used to generate _.env.default_. When generating the dart files for other flavors, the keys from the default environment that are not overriden are merged to make sure all constants are available to your flutter app. 

`keys` to specify the list of constants for the specific environment. Each key is specified by its name and can take two attributes; `value` that represents the constant value to use and `info` that provides one line descriptions that will be used as comments in the generated files. 

Upon generation, the key names will be converted to camel case for the dart files and upper case separated by underscore for the dotenv to match normal conventions. 

Any `environment` listed in the file will translate into _.env._`environment` and env_config_`environment`.dart in each of the specified locations. 


### Limitations

* Destination paths are relative only. No absolute paths
* Destination paths must exist and are not created
* Opiniated format for keys in dart and dotenv for now


[ci_badge]: https://github.com/berbsd/flavored_env/actions/workflows/flavored_env.yaml/badge.svg?branch=main
[ci_link]: https://github.com/berbsd/flavored_env/actions
[coverage_badge]: https://raw.githubusercontent.com/berbsd/flavored_env/main/coverage_badge.svg
[pub_badge]: https://img.shields.io/pub/v/flavored_env.svg
[pub_link]: https://pub.dartlang.org/packages/flavored_env
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT






[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[mason]: https://pub.dev/packages/mason_cli


