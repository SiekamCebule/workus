import 'dart:io';

bool get platformIsDesktop {
  return Platform.isFuchsia || Platform.isWindows || Platform.isMacOS || Platform.isLinux;
}
