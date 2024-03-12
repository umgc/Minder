/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Patient type in your schema. */
class Patient extends amplify_core.Model {
  static const classType = const _PatientModelType();
  final String id;
  final String? _patientsFirstName;
  final String? _patientsLastName;
  final Caregiver? _caregiver;
  final List<Reminder>? _reminders;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  PatientModelIdentifier get modelIdentifier {
      return PatientModelIdentifier(
        id: id
      );
  }
  
  String get patientsFirstName {
    try {
      return _patientsFirstName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get patientsLastName {
    try {
      return _patientsLastName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Caregiver? get caregiver {
    return _caregiver;
  }
  
  List<Reminder>? get reminders {
    return _reminders;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Patient._internal({required this.id, required patientsFirstName, required patientsLastName, caregiver, reminders, createdAt, updatedAt}): _patientsFirstName = patientsFirstName, _patientsLastName = patientsLastName, _caregiver = caregiver, _reminders = reminders, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Patient({String? id, required String patientsFirstName, required String patientsLastName, Caregiver? caregiver, List<Reminder>? reminders, required String caregiverId}) {
    return Patient._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      patientsFirstName: patientsFirstName,
      patientsLastName: patientsLastName,
      caregiver: caregiver,
      reminders: reminders != null ? List<Reminder>.unmodifiable(reminders) : reminders);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Patient &&
      id == other.id &&
      _patientsFirstName == other._patientsFirstName &&
      _patientsLastName == other._patientsLastName &&
      _caregiver == other._caregiver &&
      DeepCollectionEquality().equals(_reminders, other._reminders);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Patient {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("patientsFirstName=" + "$_patientsFirstName" + ", ");
    buffer.write("patientsLastName=" + "$_patientsLastName" + ", ");
    buffer.write("caregiver=" + (_caregiver != null ? _caregiver!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Patient copyWith({String? patientsFirstName, String? patientsLastName, Caregiver? caregiver, List<Reminder>? reminders}) {
    return Patient._internal(
      id: id,
      patientsFirstName: patientsFirstName ?? this.patientsFirstName,
      patientsLastName: patientsLastName ?? this.patientsLastName,
      caregiver: caregiver ?? this.caregiver,
      reminders: reminders ?? this.reminders);
  }
  
  Patient copyWithModelFieldValues({
    ModelFieldValue<String>? patientsFirstName,
    ModelFieldValue<String>? patientsLastName,
    ModelFieldValue<Caregiver?>? caregiver,
    ModelFieldValue<List<Reminder>?>? reminders
  }) {
    return Patient._internal(
      id: id,
      patientsFirstName: patientsFirstName == null ? this.patientsFirstName : patientsFirstName.value,
      patientsLastName: patientsLastName == null ? this.patientsLastName : patientsLastName.value,
      caregiver: caregiver == null ? this.caregiver : caregiver.value,
      reminders: reminders == null ? this.reminders : reminders.value
    );
  }
  
  Patient.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _patientsFirstName = json['patientsFirstName'],
      _patientsLastName = json['patientsLastName'],
      _caregiver = json['caregiver']?['serializedData'] != null
        ? Caregiver.fromJson(new Map<String, dynamic>.from(json['caregiver']['serializedData']))
        : null,
      _reminders = json['reminders'] is List
        ? (json['reminders'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Reminder.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'patientsFirstName': _patientsFirstName, 'patientsLastName': _patientsLastName, 'caregiver': _caregiver?.toJson(), 'reminders': _reminders?.map((Reminder? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'patientsFirstName': _patientsFirstName,
    'patientsLastName': _patientsLastName,
    'caregiver': _caregiver,
    'reminders': _reminders,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<PatientModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<PatientModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final PATIENTSFIRSTNAME = amplify_core.QueryField(fieldName: "patientsFirstName");
  static final PATIENTSLASTNAME = amplify_core.QueryField(fieldName: "patientsLastName");
  static final CAREGIVER = amplify_core.QueryField(
    fieldName: "caregiver",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Caregiver'));
  static final REMINDERS = amplify_core.QueryField(
    fieldName: "reminders",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Reminder'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Patient";
    modelSchemaDefinition.pluralName = "Patients";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["caregiverId"], name: "byCaregiver")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.PATIENTSFIRSTNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.PATIENTSLASTNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Patient.CAREGIVER,
      isRequired: false,
      targetNames: ['caregiverId'],
      ofModelName: 'Caregiver'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Patient.REMINDERS,
      isRequired: false,
      ofModelName: 'Reminder',
      associatedKey: Reminder.PATIENT
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _PatientModelType extends amplify_core.ModelType<Patient> {
  const _PatientModelType();
  
  @override
  Patient fromJson(Map<String, dynamic> jsonData) {
    return Patient.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Patient';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Patient] in your schema.
 */
class PatientModelIdentifier implements amplify_core.ModelIdentifier<Patient> {
  final String id;

  /** Create an instance of PatientModelIdentifier using [id] the primary key. */
  const PatientModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'PatientModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PatientModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}