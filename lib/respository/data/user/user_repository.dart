import 'dart:async';

import 'package:peto/modules/domain/auth/auth.dart';
import 'package:peto/respository/domain/user/user_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peto/utils/app_extensions.dart';

part 'end_points.dart';

final _firestore = FirebaseFirestore.instance;

final GoogleSignIn _googleSignIn = GoogleSignIn();

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Result<GoogleLoginSuccess, GoogleLoginFailure>> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        return Failure(GoogleLoginFailure());
      }

      final userRepository = UserRepositoryImpl();

      final userDetailsResponse = await userRepository.userDetails(
        request: UserDetailsRequest(
          uid: user.uid,
        ),
      );

      final completer = Completer<Result<GoogleLoginSuccess, GoogleLoginFailure>>();

      void onUserDetailsSuccess(UserDetailsSuccess success) {
        KAuth.instance.onLogIn(user.uid);
        KAppX.profile.update(success.userDetails);

        completer.complete(
          Success(
            GoogleLoginSuccess(
              userDetails: success.userDetails,
            ),
          ),
        );
      }

      void onUserDetailsFailure(UserDetailsFailure failure) async {
        final addUserDetails = await userRepository.updateUserDetails(
          request: UpdateUserDetailsRequest(
            userDetails: UserDetails(
              uid: user.uid,
              email: user.email,
              name: user.displayName,
              phoneNumber: user.phoneNumber,
              photoUrl: user.photoURL,
            ),
          ),
        );

        void onAddUserDetailsSuccess(UpdateUserDetailsSuccess success) {
          KAuth.instance.onLogIn(user.uid);
          KAppX.profile.update(success.userDetails);

          completer.complete(
            Success(
              GoogleLoginSuccess(
                userDetails: success.userDetails,
              ),
            ),
          );
        }

        void onAddUserDetailsFailure(UpdateUserDetailsFailure failure) {
          completer.complete(
            Failure(GoogleLoginFailure()),
          );
        }

        addUserDetails.resolve(onAddUserDetailsSuccess, onAddUserDetailsFailure);
      }

      userDetailsResponse.resolve(onUserDetailsSuccess, onUserDetailsFailure);

      return await completer.future;
    } catch (error) {
      return Failure(GoogleLoginFailure());
    }
  }

  @override
  Future<Result<UserDetailsSuccess, UserDetailsFailure>> userDetails({
    required UserDetailsRequest request,
  }) async {
    try {
      final query = _firestore.collection('users').doc(request.uid);

      final doc = await query.get();

      if (!doc.exists) {
        return Failure(UserDetailsFailure());
      }

      final data = doc.data();

      if (data == null) {
        return Failure(UserDetailsFailure());
      }

      return Success(
        UserDetailsSuccess(
          userDetails: UserDetails.fromJson(
            data,
          ),
        ),
      );
    } catch (error) {
      return Failure(UserDetailsFailure());
    }
  }

  @override
  Future<Result<UpdateUserDetailsSuccess, UpdateUserDetailsFailure>> updateUserDetails({
    required UpdateUserDetailsRequest request,
  }) async {
    try {
      final query = _firestore.collection('users').doc(
            request.userDetails.uid,
          );

      await query.set(request.toJson());

      return Success(
        UpdateUserDetailsSuccess(
          userDetails: request.userDetails,
        ),
      );
    } catch (error) {
      return Failure(UpdateUserDetailsFailure());
    }
  }

  @override
  Future<Result<GoogleLogoutSuccess, GoogleLogoutFailure>> googleLogout() async {
    try {
      await _googleSignIn.signOut();
      KAuth.instance.onLogOut();

      return Success(GoogleLogoutSuccess());
    } catch (error) {
      return Failure(GoogleLogoutFailure());
    }
  }
}
