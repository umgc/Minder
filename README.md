## Minder

A memory support app for short-term memory loss individuals, using video recording and transcription for personalized memory aids. Reminds and revisit crucial moments effortlessly."

## Table of Contents
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [Development](#development)
- [License](#license)

# Getting Started

Before you can run and use this Flutter app, make sure you have the following software and tools installed.

### Prerequisites
List any software or tools that users need to install before using your app. Include links to their official documentation.

1. **Visual Studio Code (VS Code):**
   - We recommend using Visual Studio Code as the integrated development environment (IDE) for working with Flutter.
   - [Download Visual Studio Code](https://code.visualstudio.com/)

2. **Flutter SDK:**
   - The app is built using Dart with Flutter. Make sure you have Flutter SDK installed.
   - [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

3. **Dart SDK:**
   - Dart is the programming language used with Flutter. It is included with the Flutter SDK, so you don't need to install it separately.
   - [Dart Documentation](https://dart.dev/)

4. **External APIs:**
   - The app utilizes external APIs for conversation analysis (Chat GPT) and transcription (Wispher).
     - [Chat GPT Documentation](https://chatgpt.com/documentation)
     - [Wispher API Documentation](https://wispher.io/api-docs/)

5. **AWS Account:**
   - For cloud-based storage, we use AWS (Amazon Web Services). You'll need an AWS account to set up and configure cloud storage functionalities.
     - [AWS Documentation](https://aws.amazon.com/getting-started/)

5. ** AWS Amplify:**
## AWS Amplify Configuration

To enhance Minder with cloud functionalities, we use AWS Amplify. Follow these steps to configure AWS Amplify for the app:

### Setting Up AWS Amplify

      - **Install the Amplify CLI:**
         - Ensure you have Node.js installed on your machine. Then, install the AWS Amplify CLI globally using npm:
         ```bash
         npm install -g @aws-amplify/cli
         ```

      - **Configure Amplify:**
         - Run the following command and follow the prompts to configure the CLI with your AWS account:
         ```bash
         amplify configure
         ```
         - Sign into the AWS Management Console when prompted and complete the configuration steps.

      - **Initialize Amplify in your project:**
         - Navigate to your project directory and initialize Amplify:
         ```bash
         amplify init
         ```
         - Answer the questions to specify the name of your environment, your preferred text editor, and other configuration options.

      - **Add Amplify Categories:**
         - Add any required categories (e.g., auth, api, storage) to your project. For example, to add authentication, you can use:
         ```bash
         amplify add auth
         ```
         - Follow the prompts to configure each category according to your needs.

      - **Push Changes to the Cloud:**
         - Apply your changes and deploy your backend to the cloud with:
         ```bash
         amplify push
         ```

Please refer to the [AWS Amplify Documentation](https://docs.amplify.aws/) for more detailed instructions and advanced configurations.


## Installation

Follow these steps to set up and run the app:

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/umgc/minder.git
   cd minder
   
   flutter pub get

   flutter run


   

## Team Members ✨
- [@ElsaBushen](https://github.com/ElsaBushen) 
- [@LensaGemeda](https://github.com/LensaC) 
- [@JohnnGuyen](https://github.com/Johnnguyen616) 
- [@GabrielMoreno](https://github.com/MrGESM) 
- [@SayedShahMahbobi](https://github.com/Mahbobi) 
- [@KathleenHampton](https://github.com/kbrig573) 
- [@VinroyJones ](https://github.com/geajonesv) 
- [@HellenOjwang](https://github.com/Hellenoj) 


