
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Validate amplifyconfig JSON structure and content', () {
    const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "MinderAPI": {
                    "endpointType": "REST",
                    "endpoint": "https://5zc4k2nzpb.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:90dfcb32-a051-4f24-b672-8731d2098a22",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_MggfUYNBv",
                        "AppClientId": "1u8ltelpe0jaddstaducd3b154",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "minderstore111914-dev",
                        "Region": "us-east-1"
                    }
                },
                "DynamoDBObjectMapper": {
                    "Default": {
                        "Region": "us-east-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "minderstore111914-dev",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            },
            "awsDynamoDbStoragePlugin": {
                "partitionKeyName": "fullName",
                "region": "us-east-1",
                "arn": "arn:aws:dynamodb:us-east-1:471112682615:table/caregiver_profile-dev",
                "streamArn": "arn:aws:dynamodb:us-east-1:471112682615:table/caregiver_profile-dev/stream/2024-03-01T17:57:27.664",
                "partitionKeyType": "S",
                "name": "caregiver_profile-dev"
            }
        }
    }
}''';

    // Parse JSON string
    final Map<String, dynamic> config = json.decode(amplifyconfig);

    // Validate top-level keys
    expect(config.containsKey('UserAgent'), true);
    expect(config.containsKey('Version'), true);
    expect(config.containsKey('api'), true);
    expect(config.containsKey('auth'), true);
    expect(config.containsKey('storage'), true);

    // Validate API plugin configuration
    final Map<String, dynamic> api = config['api'];
    expect(api['plugins']['awsAPIPlugin']['MinderAPI']['endpointType'], 'REST');
    expect(api['plugins']['awsAPIPlugin']['MinderAPI']['region'], 'us-east-1');
    // Add more validation for API plugin if needed

    // Validate Auth plugin configuration
    final Map<String, dynamic> auth = config['auth'];
    expect(auth['plugins']['awsCognitoAuthPlugin']['UserAgent'], 'aws-amplify-cli/0.1.0');
    expect(auth['plugins']['awsCognitoAuthPlugin']['CognitoUserPool']['Default']['PoolId'], 'us-east-1_MggfUYNBv');
    // Add more validation for Auth plugin if needed

    // Validate Storage plugin configuration
    final Map<String, dynamic> storage = config['storage'];
    expect(storage['plugins']['awsS3StoragePlugin']['bucket'], 'minderstore111914-dev');
    expect(storage['plugins']['awsDynamoDbStoragePlugin']['region'], 'us-east-1');
    // Add more validation for Storage plugin if needed
  });
}
