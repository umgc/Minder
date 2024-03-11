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


/** This is an auto generated class representing the Reminder type in your schema. */
class Reminder extends amplify_core.Model {
  static const classType = const _ReminderModelType();
  final String id;
  final String? _eventType;
  final amplify_core.TemporalDateTime? _dateTime;
  final String? _description;
  final Patient? _patient;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ReminderModelIdentifier get modelIdentifier {
      return ReminderModelIdentifier(
        id: id
      );
  }
  
  String get eventType {
    try {
      return _eventType!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime get dateTime {
    try {
      return _dateTime!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get description {
    return _description;
  }
  
  Patient? get patient {
    return _patient;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Reminder._internal({required this.id, required eventType, required dateTime, description, patient, createdAt, updatedAt}): _eventType = eventType, _dateTime = dateTime, _description = description, _patient = patient, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Reminder({String? id, required String eventType, required amplify_core.TemporalDateTime dateTime, String? description, Patient? patient}) {
    return Reminder._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      eventType: eventType,
      dateTime: dateTime,
      description: description,
      patient: patient);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reminder &&
      id == other.id &&
      _eventType == other._eventType &&
      _dateTime == other._dateTime &&
      _description == other._description &&
      _patient == other._patient;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Reminder {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("eventType=" + "$_eventType" + ", ");
    buffer.write("dateTime=" + (_dateTime != null ? _dateTime!.format() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("patient=" + (_patient != null ? _patient!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Reminder copyWith({String? eventType, amplify_core.TemporalDateTime? dateTime, String? description, Patient? patient}) {
    return Reminder._internal(
      id: id,
      eventType: eventType ?? this.eventType,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      patient: patient ?? this.patient);
  }
  
  Reminder copyWithModelFieldValues({
    ModelFieldValue<String>? eventType,
    ModelFieldValue<amplify_core.TemporalDateTime>? dateTime,
    ModelFieldValue<String?>? description,
    ModelFieldValue<Patient?>? patient
  }) {
    return Reminder._internal(
      id: id,
      eventType: eventType == null ? this.eventType : eventType.value,
      dateTime: dateTime == null ? this.dateTime : dateTime.value,
      description: description == null ? this.description : description.value,
      patient: patient == null ? this.patient : patient.value
    );
  }
  
  Reminder.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _eventType = json['eventType'],
      _dateTime = json['dateTime'] != null ? amplify_core.TemporalDateTime.fromString(json['dateTime']) : null,
      _description = json['description'],
      _patient = json['patient']?['serializedData'] != null
        ? Patient.fromJson(new Map<String, dynamic>.from(json['patient']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'eventType': _eventType, 'dateTime': _dateTime?.format(), 'description': _description, 'patient': _patient?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'eventType': _eventType,
    'dateTime': _dateTime,
    'description': _description,
    'patient': _patient,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ReminderModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ReminderModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final EVENTTYPE = amplify_core.QueryField(fieldName: "eventType");
  static final DATETIME = amplify_core.QueryField(fieldName: "dateTime");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final PATIENT = amplify_core.QueryField(
    fieldName: "patient",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Patient'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Reminder";
    modelSchemaDefinition.pluralName = "Reminders";
    
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
      amplify_core.ModelIndex(fields: const ["patientId"], name: "byPatient")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Reminder.EVENTTYPE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Reminder.DATETIME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Reminder.DESCRIPTION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Reminder.PATIENT,
      isRequired: false,
      targetNames: ['patientId'],
      ofModelName: 'Patient'
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

class _ReminderModelType extends amplify_core.ModelType<Reminder> {
  const _ReminderModelType();
  
  @override
  Reminder fromJson(Map<String, dynamic> jsonData) {
    return Reminder.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Reminder';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Reminder] in your schema.
 */
class ReminderModelIdentifier implements amplify_core.ModelIdentifier<Reminder> {
  final String id;

  /** Create an instance of ReminderModelIdentifier using [id] the primary key. */
  const ReminderModelIdentifier({
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
  String toString() => 'ReminderModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ReminderModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}