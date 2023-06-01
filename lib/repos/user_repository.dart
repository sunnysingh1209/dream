import 'dart:async';
import 'dart:convert';

import 'package:dream_game/helper/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

final navigatorKeyHome = GlobalKey<NavigatorState>();

class UserRepository {
  UserModel? user;

  Future<UserModel?> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    //await prefs.clear();
    if (prefs.containsKey(AppConstants.CURRENT_USER)) {
      //  _user =User.fromJson( json.decode(await prefs.get('current_user'));
      var userMap = json.decode(prefs.getString(AppConstants.CURRENT_USER)!)
          as Map<String, dynamic>;
      user = UserModel.fromJson(userMap);
      // user = UserModel('eee01d64-a5dd-11ed-afa1-0242ac120002');
    } else {
      return user;
    }
    return user;
  }

  Future<void> setCurrentUser(String jsonString) async {
    try {
      if (json.decode(jsonString) != null) {
        var prefs = await SharedPreferences.getInstance();
        // var user = User.fromJson(json.decode(jsonString)['result']);
        // await prefs.setString("apiKey", user.apiKey!);

        await prefs
            .setString(
                AppConstants.CURRENT_USER, json.encode(json.decode(jsonString)))
            .then((value) {
          //print('user saved ');
          updateUserInstance();
        });
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  void updateUserInstance() {
    user = null;
    getCurrentUser();
  }

  void clearuserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      prefs.remove('current_user');
      // prefs.remove(AppConstants.VERSION_INFO);
    }
    /* if (prefs.containsKey('disclosure')) {
      prefs.remove('disclosure');
    }*/
    // prefs.clear();
  }

  Future<UserModel?> getCurrentUser() async {
    return user;
  }

  Future<dynamic?> userWallet() async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/wallet';

      final client = http.Client();

      print(url);
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> cancelWithdrawlReqest({
    String? id,
  }) async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/withdrawalcancel/${id}';

      print(url);

      final client = http.Client();

      final response = await client.delete(
        Uri.parse(url),
        // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
        },
      );
      if (response.statusCode == 200) {
        return response;
      }

      print('sfsdf' + response.body);
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> withdrawlRequest({
    required Map<String, dynamic> data,
  }) async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/withdrawalrequest';

      print(url);

      final client = http.Client();

      final response = await client.post(Uri.parse(url),
          // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
          },
          body: json.encode(data));
      if (response.statusCode == 200) {
        return response;
      }

      print('sfsdf' + response.body);
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> gamePlayGames() async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}GamePlay/games';

      final client = http.Client();

      print(url);
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> getActivePlayGames() async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/getactiveplayedgames';

      final client = http.Client();

      print(url);
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> getUserTransaction() async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/gettransactions';

      final client = http.Client();

      print(url);
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> placeBetApi({
    required Map<String, dynamic> data,
  }) async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/playgame';

      print(url);
      print(json.encode(data));

      final client = http.Client();

      final response = await client.post(Uri.parse(url),
          // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
          },
          body: json.encode(data));
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> getProfile() async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}Profile/getprofile';

      final client = http.Client();

      print(url);
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}Profile/updateprofile';

      print(url);
      print(json.encode(data));

      final client = http.Client();

      final response = await client.put(Uri.parse(url),
          // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
          },
          body: json.encode(data));
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> getPaymentGateway() async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/getpaymentgateway';

      final client = http.Client();

      print(url);
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }

  Future<dynamic?> uploadTransImage(
      {required Map<String, String> data, required String filePath}) async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/transactionimage';

      print(url);
      print(data);

      //for multipartrequest
      var request = http.MultipartRequest('POST', Uri.parse(url));

      //for token
      request.headers.addAll(
          {"Authorization": "Bearer ${user!.data!.tokenResponse!.token}"});

      //for image and videos and files

      if (filePath.toString() != '') {
        request.files.add(await http.MultipartFile.fromPath("image", filePath));
      }

      request.fields.addAll(data);
      // request.fields['timings'] = '{}';
      print('request ${request.url}  ${request.fields}');
      //for completeing the request
      var response = await request.send();

      //for getting and decoding the response into json format
      var responsed = await http.Response.fromStream(response);

      print('response ${jsonDecode(responsed.body)}');
      if (response.statusCode == 200) {
        print("SUCCESS");
        return responsed;
      }
      return responsed;
    } catch (e) {
      print('exception $e');
    }
  }

  Future<dynamic?> transactionRequest({
    required Map<String, dynamic> data,
  }) async {
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}User/transactionrequest';

      print(url);
      print(json.encode(data));

      final client = http.Client();

      final response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user?.data?.tokenResponse?.token}'
          },
          body: json.encode(data));
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    } catch (e) {
      print('exception $e');
      return e;
    }
  }
}
