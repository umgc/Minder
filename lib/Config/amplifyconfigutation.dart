const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "minder": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://jxwmyxbwyzhf3om73eout3udsq.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS"
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
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://jxwmyxbwyzhf3om73eout3udsq.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "minder_AMAZON_COGNITO_USER_POOLS"
                    }
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
