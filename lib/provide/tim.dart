import 'package:flutter/material.dart';


class TimProvide extends ChangeNotifier {
  
  List<dynamic> allConversation = [];
  List<dynamic> currentMessageList = [];
  int currentPeer =  2434830;

  void updateAllConversation(data) {
    allConversation = data;
    notifyListeners();
  }

  void setMessageList(list) {
    currentMessageList = list;
    notifyListeners();
  }
}