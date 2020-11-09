import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:repository/repository.dart';

abstract class SocialNetworkConnect {
  Future<SocialAccount> logIn({AccountType type});

  Future<SocialProfile> getUserProfile({SocialAccount socialAccount});

  Future<List<String>> getSocialFriendIds({SocialAccount socialAccount});

  Future<void> signOut({@required AccountType type});
}