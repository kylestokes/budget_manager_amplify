/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Budget type in your schema. */
@immutable
class Budget extends Model {
  static const classType = const _BudgetModelType();
  final String id;
  final String name;
  final double spent;
  final double amountLeft;
  final double setAmount;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Budget._internal(
      {@required this.id,
      this.name,
      this.spent,
      this.amountLeft,
      this.setAmount});

  factory Budget(
      {String id,
      String name,
      double spent,
      double amountLeft,
      double setAmount}) {
    return Budget._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        spent: spent,
        amountLeft: amountLeft,
        setAmount: setAmount);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Budget &&
        id == other.id &&
        name == other.name &&
        spent == other.spent &&
        amountLeft == other.amountLeft &&
        setAmount == other.setAmount;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Budget {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("spent=" + (spent != null ? spent.toString() : "null") + ", ");
    buffer.write("amountLeft=" +
        (amountLeft != null ? amountLeft.toString() : "null") +
        ", ");
    buffer.write(
        "setAmount=" + (setAmount != null ? setAmount.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Budget copyWith(
      {String id,
      String name,
      double spent,
      double amountLeft,
      double setAmount}) {
    return Budget(
        id: id ?? this.id,
        name: name ?? this.name,
        spent: spent ?? this.spent,
        amountLeft: amountLeft ?? this.amountLeft,
        setAmount: setAmount ?? this.setAmount);
  }

  Budget.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        spent = json['spent'],
        amountLeft = json['amountLeft'],
        setAmount = json['setAmount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'spent': spent,
        'amountLeft': amountLeft,
        'setAmount': setAmount
      };

  static final QueryField ID = QueryField(fieldName: "budget.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField SPENT = QueryField(fieldName: "spent");
  static final QueryField AMOUNTLEFT = QueryField(fieldName: "amountLeft");
  static final QueryField SETAMOUNT = QueryField(fieldName: "setAmount");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Budget";
    modelSchemaDefinition.pluralName = "Budgets";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Budget.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Budget.SPENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Budget.AMOUNTLEFT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Budget.SETAMOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));
  });
}

class _BudgetModelType extends ModelType<Budget> {
  const _BudgetModelType();

  @override
  Budget fromJson(Map<String, dynamic> jsonData) {
    return Budget.fromJson(jsonData);
  }
}
