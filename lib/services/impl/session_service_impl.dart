// ignore_for_file: constant_identifier_names

import 'package:boilerplate_flutter/services/services.dart';
import 'package:repository/model/authorization.dart';
import 'package:repository/model/user.dart';
import 'package:repository/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _FirstTimeLaunchingKey = 'key_first_time_launching';
const _BeInGuestModeKey = 'key_be_in_guest_mode';

class SessionServiceImpl implements SessionService {
  final UserRepository _userRepository;

  SessionServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> getLoggedInUser({bool forceToUpdate = false}) async {
    if (!forceToUpdate) {
      return _userRepository.getLoggedInUser();
    }
    return _userRepository.getLatestLoggedInUser();
  }

  @override
  Authorization? getLoggedInAuthorization() {
    return _userRepository.getLoggedInAuthorization();
  }

  @override
  Future<bool> isFirstTimeLaunching() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_FirstTimeLaunchingKey) ?? false);
  }

  @override
  Future<void> markDoneFirstTimeLaunching() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_FirstTimeLaunchingKey, true);
  }

  @override
  Future<bool> isInGuestMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_BeInGuestModeKey) ?? false;
  }

  @override
  Future<void> markBeInGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_BeInGuestModeKey, true);
  }

  @override
  Future<void> markExistGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_BeInGuestModeKey, false);
  }
}
