import 'package:envied/envied.dart';

part 'env.g.dart';  // This line is crucial for code generation

@Envied(path: '.env')  // Specifies the location of your .env file
abstract class Env {
  @EnviedField(varName: 'SERVER_URL', obfuscate: true)  // Obfuscates the value of the environment variable
  static String serverUrl = _Env.serverUrl;  // The generated code will provide access to this variable
}

