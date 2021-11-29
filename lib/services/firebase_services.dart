import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contract_info.dart';

class FirebaseServices {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  void echo({
    required String functionName,
    required String variableName,
    required dynamic data,
  }) {
    // ignore: avoid_print
    print("FIREBASE_SERVICES $functionName $variableName: $data");
  }

  Future<bool> addContract(ContractInfo contract) async {
    try {
      instance.collection("contracts").add(contract.toMap());
      return true;
    } catch (error) {
      echo(functionName: "addContract", variableName: "error", data: error);
      return false;
    }
  }
}
