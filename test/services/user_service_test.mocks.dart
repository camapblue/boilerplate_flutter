// Mocks generated by Mockito 5.3.1 from annotations
// in boilerplate_flutter/test/services/user_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:repository/model/model.dart' as _i2;
import 'package:repository/repository/user_repository.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUser_0 extends _i1.SmartFake implements _i2.User {
  _FakeUser_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> signOut({String? deviceToken}) => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
          {#deviceToken: deviceToken},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> saveUser(
    _i2.User? user, {
    _i2.Authorization? authorization,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveUser,
          [user],
          {#authorization: authorization},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> clearAuthentication() => (super.noSuchMethod(
        Invocation.method(
          #clearAuthentication,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i2.User> getLatestLoggedInUser() => (super.noSuchMethod(
        Invocation.method(
          #getLatestLoggedInUser,
          [],
        ),
        returnValue: _i4.Future<_i2.User>.value(_FakeUser_0(
          this,
          Invocation.method(
            #getLatestLoggedInUser,
            [],
          ),
        )),
      ) as _i4.Future<_i2.User>);
  @override
  _i4.Future<void> registerDevice({
    required String? deviceToken,
    required int? deviceType,
    required String? deviceUdid,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerDevice,
          [],
          {
            #deviceToken: deviceToken,
            #deviceType: deviceType,
            #deviceUdid: deviceUdid,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
