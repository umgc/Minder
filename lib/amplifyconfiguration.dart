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
                        "PoolId": "us-east-2_TlcQcDO7C", // Updated User Pool ID
                        "AppClientId": "1u8ltelpe0jaddstaducd3b154",
                        "Region": "us-east-2" // Updated Region
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
