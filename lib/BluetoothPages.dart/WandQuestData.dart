import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'; 

class Bluetoothdata extends ChangeNotifier {
  BluetoothCharacteristic? MeasureWrite;
  BluetoothCharacteristic? BrixInfoNotify;
  BluetoothCharacteristic? RipenessInfoNotify;
  BluetoothCharacteristic? BeltWrite;
  BluetoothCharacteristic? BatteryNotify;
  BluetoothCharacteristic? TookmaijaNotify;
  BluetoothCharacteristic? TookmaijaWrite;
  BluetoothDevice? OptiripeMain;

  bool _isConnected = false;

  // ✅ Getter
  bool get isConnected => _isConnected;

  String _GlobalBrix = "";
  String _GlobalRipeness = "";
  String _GlobalTime = "";
  bool _fromResultPage = false;
  int _totalitem = 0;

  String get GlobalBrix => _GlobalBrix;
  String get GlobalRipeness => _GlobalRipeness;
  String get GlobalTime => _GlobalTime;
  bool get fromResultPage => _fromResultPage;
  int get totalitem => _totalitem;

  // ✅ Setter with notifyListeners
  set isConnected(bool value) {
    if (_isConnected != value) {
      _isConnected = value;
      notifyListeners();
    }
  }

  set GlobalBrix(String value) {
    if (_GlobalBrix != value) {
      _GlobalBrix = value;
      notifyListeners();
    }
  }

  set GlobalRipeness(String value) {
    if (_GlobalRipeness != value) {
      _GlobalRipeness = value;
      notifyListeners();
    }
  }

  set GlobalTime(String value) {
    if (_GlobalTime != value) {
      _GlobalTime = value;
      notifyListeners();
    }
  }

  set fromResultPage(bool value) {
    if (_fromResultPage != value) {
      _fromResultPage = value;
      notifyListeners();
    }
  }

  set totalitem(int value) {
    if (_totalitem != value) {
      _totalitem = value;
      notifyListeners();
    }
  }

  Future<void> signOut({required BluetoothDevice device}) async {
    try {
      await device.disconnect();
      _isConnected = false; // Update connection status on disconnect
    } catch (e) {
      print("Error while disconnecting: $e");
    }

    OptiripeMain = null;
    MeasureWrite = null;
    BrixInfoNotify = null;
    RipenessInfoNotify = null;
    BeltWrite = null;
    BatteryNotify = null; // Corrected: Assign null

    isConnected = false;

    notifyListeners();
  }

  void changeOptiripeMainDevice({required BluetoothDevice device}) {
    OptiripeMain = device;

    // Listen to the connection state of VIA2025
    OptiripeMain?.state.listen((BluetoothConnectionState state) {
      if (state == BluetoothConnectionState.connected) {
        // Mark as connected when the device is connected
        isConnected = true;
      } else if (state == BluetoothConnectionState.disconnected) {
        // Mark as disconnected when the device is disconnected
        isConnected = false;
      }
    });

    // Initially mark as connected when a device is chosen
    isConnected = true;

    notifyListeners();
  }

  void changeOptiripeDevice({required BluetoothDevice device}) {
    OptiripeMain = device;
    _isConnected = true; // Assuming this means a successful connection
    notifyListeners();
  }

  void changeMeasureWrite({required BluetoothCharacteristic characteristic}) {
    MeasureWrite = characteristic;
    notifyListeners();
  }

  void changeBrixInfoNotify({required BluetoothCharacteristic characteristic}) {
    BrixInfoNotify = characteristic;
    notifyListeners();
  }

  void changeRipenessInfoNotify({required BluetoothCharacteristic characteristic}) {
    RipenessInfoNotify = characteristic;
    notifyListeners();
  }

  void changeBeltWrite({required BluetoothCharacteristic characteristic}) {
    BeltWrite = characteristic;
    notifyListeners();
  }

  void changeBatteryNotify({required BluetoothCharacteristic characteristic}) {
    BatteryNotify = characteristic;
    notifyListeners();
  }

  void changeTookmaijaNotify({required BluetoothCharacteristic characteristic}) {
    TookmaijaNotify = characteristic;
    notifyListeners();
  }

  void changeTookmaijaWrite({required BluetoothCharacteristic characteristic}) {
    TookmaijaWrite = characteristic;
    notifyListeners();
  }
  // Method to manually update connection status if needed
  void setConnectionStatus(bool status) {
    _isConnected = status;
    notifyListeners();
  }
}