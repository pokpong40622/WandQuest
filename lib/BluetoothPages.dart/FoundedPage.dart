import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wandquest/BluetoothPages.dart/WandQuestData.dart';
import 'package:wandquest/Pages/HomePage.dart';

class FoundedPage extends StatefulWidget {
  FoundedPage({super.key, this.scanResult,});
  final ScanResult? scanResult;

  @override
  State<FoundedPage> createState() => _FoundedPageState();
}

class _FoundedPageState extends State<FoundedPage> {

  void initState() {
    super.initState();
    Provider.of<WandQuestData>(context, listen: false).fromResultPage = false;
  }
  Map<String, BluetoothCharacteristic?> allBluetooth = {
    "MeasureWrite": null,
    "BrixInfoNotify": null,
    "RipenessInfoNotify": null,
    "BeltWrite": null,
    "BatteryNotify": null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F6857),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 250),
            Image.asset('assets/FoundedLogo.png', width: 138),
            const SizedBox(height: 10),
            Text(
              'Founded!',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 294),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(child: CircularProgressIndicator()),
                );

                try {
                  await FlutterBluePlus.stopScan();

                  var device = widget.scanResult?.device;
                  if (device == null) {
                    throw Exception("No device found in scan result.");
                  }

                  print("Connecting to device: ${device.id}");

                  // Connect if not already connected
                  var state = await device.connectionState.first;
                  if (state != BluetoothConnectionState.connected) {
                    await device.connect();
                  }

                  print("Device connected");

                  context.read<WandQuestData>().changeOptiripeDevice(device: device);

                  // Double-check connection
                  var currentState = await device.connectionState.first;
                  if (currentState != BluetoothConnectionState.connected) {
                    throw Exception(
                      "Device disconnected before discovering services",
                    );
                  }

                  var services = await device.discoverServices();

                  for (var s in services) {
                    if (s.serviceUuid.toString().length > 5) {
                      for (var c in s.characteristics) {
                        for (var d in c.descriptors) {
                          var descriptorValue = utf8.decode(await d.read());
                          print('Descriptor: $descriptorValue for characteristic ${c.uuid}');

                          if (descriptorValue.contains("MeasureWriteDescriptor")) {
                            allBluetooth["MeasureWrite"] = c;
                          } else if (descriptorValue.contains("BrixInfoNotifyDescriptor")) {
                            allBluetooth["BrixInfoNotify"] = c;
                          } else if (descriptorValue.contains("RipenessInfoNotifyDescriptor")) {
                            allBluetooth["RipenessInfoNotify"] = c;
                          } else if (descriptorValue.contains("BeltWriteDescriptor")) {
                            allBluetooth["BeltWrite"] = c;
                          } else if (descriptorValue.contains("BatteryNotifyDescriptor")) {
                            allBluetooth["BatteryNotify"] = c;
                          } else if (descriptorValue.contains("TookmaijaNotifyDescriptor")) {
                            allBluetooth["TookmaijaNotify"] = c;
                          } else if (descriptorValue.contains("TookmaijaWriteDescriptor")) {
                            allBluetooth["TookmaijaWrite"] = c;
                          }
                        }
                      }
                    }
                  }

                  // Update provider only if characteristics are found
                  if (allBluetooth["MeasureWrite"] != null) {
                    context.read<WandQuestData>().changeMeasureWrite(
                      characteristic: allBluetooth["MeasureWrite"]!,
                    );
                  }
                  if (allBluetooth["BrixInfoNotify"] != null) {
                    context.read<WandQuestData>().changeBrixInfoNotify(
                      characteristic: allBluetooth["BrixInfoNotify"]!,
                    );
                  }
                  if (allBluetooth["RipenessInfoNotify"] != null) {
                    context.read<WandQuestData>().changeRipenessInfoNotify(
                      characteristic: allBluetooth["RipenessInfoNotify"]!,
                    );
                  }
                  if (allBluetooth["BeltWrite"] != null) {
                    context.read<WandQuestData>().changeBeltWrite(
                      characteristic: allBluetooth["BeltWrite"]!,
                    );
                  }
                  if (allBluetooth["BatteryNotify"] != null) {
                    context.read<WandQuestData>().changeBatteryNotify(
                      characteristic: allBluetooth["BatteryNotify"]!,
                    );
                  }

                  if (allBluetooth["TookmaijaNotify"] != null) {
                    context.read<WandQuestData>().changeTookmaijaNotify(
                      characteristic: allBluetooth["TookmaijaNotify"]!,
                    );
                  }

                  if (allBluetooth["TookmaijaWrite"] != null) {
                    context.read<WandQuestData>().changeTookmaijaWrite(
                      characteristic: allBluetooth["TookmaijaWrite"]!,
                    );
                  }

                  Navigator.pop(context); // Remove loading dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                  Provider.of<WandQuestData>(context, listen: false).fromResultPage = false;
                  context.read<WandQuestData>().MeasureWrite?.write(
                    utf8.encode("S"),
                  );
                  
                } catch (e) {
                  Navigator.pop(context); // Remove loading dialog
                  print("Connection error: $e");

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Connection Error"),
                      content: const Text(
                        "Failed to connect or discover services. Please try again.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Container(
                width: 356,
                height: 66,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Connect',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF2F6857),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}