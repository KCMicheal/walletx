
import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';

TransactionModel transactionModelFromMap(String str) => TransactionModel.fromMap(json.decode(str));

String transactionModelToMap(TransactionModel data) => json.encode(data.toMap());

class TransactionModel {
  TransactionModel({
    required this.status,
    required this.message,
    required this.transactions,
  });

  String status;
  String message;
  List<Transactions> transactions;

  factory TransactionModel.fromMap(Map<String, dynamic> json) => TransactionModel(
    status: json['status'],
    message: json['message'],
    transactions: List<Transactions>.from(json['result'].map((x) => Transactions.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    'status': status,
    'message': message,
    'transactions': List<dynamic>.from(transactions.map((x) => x.toMap())),
  };
}

class Transactions {
  Transactions({
    required this.blockNumber,
    required this.timeStamp,
    required this.hash,
    required this.from,
    required this.to,
    required this.value,
    required this.contractAddress,
    required this.input,
    required this.type,
    required this.gas,
    required this.gasUsed,
    required this.traceId,
    required this.isError,
    required this.errCode,
  });

  String blockNumber;
  String timeStamp;
  String hash;
  String from;
  String to;
  String value;
  String contractAddress;
  String input;
  String type;
  String gas;
  String gasUsed;
  String traceId;
  String isError;
  String errCode;

  factory Transactions.fromMap(Map<String, dynamic> json) => Transactions(
    blockNumber: json['blockNumber'],
    timeStamp: DateFormat('h:mm a').format(DateTime.parse(json['timeStamp'])),
    hash: json['hash'],
    from: json['from'],
    to: json['to'],
    value: (double.tryParse(json['value'])! / pow(10, 18)).toStringAsFixed(3) ,
    contractAddress: json['contractAddress'],
    input: json['input'],
    type: json['type'],
    gas: (double.tryParse(json['gas'])! / pow(10, 18)).toStringAsFixed(3),
    gasUsed: json['gasUsed'],
    traceId: json['traceId'],
    isError: json['isError'],
    errCode: json['errCode'],
  );

  Map<String, dynamic> toMap() => {
    'blockNumber': blockNumber,
    'timeStamp': timeStamp,
    'hash': hash,
    'from': from,
    'to': to,
    'value': value,
    'contractAddress': contractAddress,
    'input': input,
    'type': type,
    'gas': gas,
    'gasUsed': gasUsed,
    'traceId': traceId,
    'isError': isError,
    'errCode': errCode,
  };
}
