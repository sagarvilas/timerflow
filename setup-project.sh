#!/bin/bash

# TimeFlow Mobile App Setup Script
# This script creates the complete project structure with all files

echo "🚀 Setting up TimeFlow Mobile App..."

# Create project directory
PROJECT_NAME="TimeFlowMobile"
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

echo "📁 Creating directory structure..."

# Create all directories
mkdir -p src/{components/ui,context,screens,services,types,utils}
mkdir -p assets/sounds
mkdir -p __tests__

echo "📝 Creating configuration files..."

# Package.json
cat > package.json << 'EOF'
{
  "name": "timeflow-mobile",
  "version": "1.0.0",
  "main": "node_modules/expo/AppEntry.js",
  "scripts": {
    "start": "expo start",
    "android": "expo start --android",
    "ios": "expo start --ios",
    "web": "expo start --web",
    "build:android": "eas build --platform android",
    "build:ios": "eas build --platform ios",
    "build:all": "eas build --platform all",
    "submit:android": "eas submit --platform android",
    "submit:ios": "eas submit --platform ios",
    "update": "eas update",
    "test": "jest",
    "lint": "eslint src/ --ext .ts,.tsx",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "@expo/vector-icons": "^13.0.0",
    "@react-navigation/bottom-tabs": "^6.5.11",
    "@react-navigation/native": "^6.1.9",
    "@react-navigation/stack": "^6.3.20",
    "@react-native-async-storage/async-storage": "1.19.3",
    "date-fns": "^2.30.0",
    "expo": "~49.0.15",
    "expo-av": "~13.6.0",
    "expo-constants": "~14.4.2",
    "expo-document-picker": "~11.5.4",
    "expo-file-system": "~15.4.5",
    "expo-haptics": "~12.4.0",
    "expo-keep-awake": "~12.3.0",
    "expo-linking": "~5.0.2",
    "expo-notifications": "~0.20.1",
    "expo-screen-orientation": "~6.0.5",
    "expo-sharing": "~11.5.0",
    "expo-status-bar": "~1.6.0",
    "react": "18.2.0",
    "react-hook-form": "^7.47.0",
    "react-native": "0.72.6",
    "react-native-paper": "^5.11.3",
    "react-native-safe-area-context": "4.6.3",
    "react-native-screens": "~3.22.0",
    "react-native-vector-icons": "^10.0.2",
    "uuid": "^9.0.1"
  },
  "devDependencies": {
    "@babel/core": "^7.20.0",
    "@types/react": "~18.2.14",
    "@types/react-native": "^0.72.6",
    "@types/uuid": "^9.0.7",
    "@typescript-eslint/eslint-plugin": "^6.10.0",
    "@typescript-eslint/parser": "^6.10.0",
    "eslint": "^8.53.0",
    "eslint-config-expo": "^7.0.0",
    "jest": "^29.2.1",
    "typescript": "^5.1.3"
  },
  "jest": {
    "preset": "jest-expo",
    "transformIgnorePatterns": [
      "node_modules/(?!((jest-)?react-native|@react-native(-community)?)|expo(nent)?|@expo(nent)?/.*|@expo-google-fonts/.*|react-navigation|@react-navigation/.*|@unimodules/.*|unimodules|sentry-expo|native-base|react-native-svg)"
    ]
  },
  "private": true
}
EOF

# App.json
cat > app.json << 'EOF'
{
  "expo": {
    "name": "TimeFlow",
    "slug": "timeflow-mobile",
    "version": "1.0.0",
    "orientation": "portrait",
    "icon": "./assets/icon.png",
    "userInterfaceStyle": "automatic",
    "splash": {
      "image": "./assets/splash.png",
      "resizeMode": "contain",
      "backgroundColor": "#4A90E2"
    },
    "assetBundlePatterns": [
      "**/*"
    ],
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.yourcompany.timeflow",
      "buildNumber": "1",
      "infoPlist": {
        "UIBackgroundModes": ["audio"],
        "NSMicrophoneUsageDescription": "This app does not use the microphone.",
        "CFBundleDocumentTypes": [
          {
            "CFBundleTypeName": "TimeFlow Backup",
            "CFBundleTypeRole": "Editor",
            "LSItemContentTypes": ["public.json"],
            "LSHandlerRank": "Owner"
          }
        ]
      }
    },
    "android": {
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#4A90E2"
      },
      "package": "com.yourcompany.timeflow",
      "versionCode": 1,
      "permissions": [
        "android.permission.VIBRATE",
        "android.permission.WAKE_LOCK"
      ]
    },
    "web": {
      "favicon": "./assets/favicon.png",
      "bundler": "metro"
    },
    "plugins": [
      "expo-av",
      [
        "expo-notifications",
        {
          "icon": "./assets/notification-icon.png",
          "color": "#4A90E2",
          "sounds": [
            "./assets/sounds/bell.wav",
            "./assets/sounds/beep.wav",
            "./assets/sounds/chime.wav",
            "./assets/sounds/gong.wav"
          ]
        }
      ],
      [
        "expo-document-picker",
        {
          "iCloudContainerEnvironment": "Production"
        }
      ],
      [
        "expo-file-system",
        {
          "NSDocumentsFolderUsageDescription": "This app needs access to the documents folder to save and load timer backups."
        }
      ]
    ],
    "extra": {
      "eas": {
        "projectId": "your-project-id-here"
      }
    }
  }
}
EOF

# TypeScript config
cat > tsconfig.json << 'EOF'
{
  "extends": "expo/tsconfig.base",
  "compilerOptions": {
    "target": "es2017",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@/components/*": ["src/components/*"],
      "@/screens/*": ["src/screens/*"],
      "@/services/*": ["src/services/*"],
      "@/types/*": ["src/types/*"],
      "@/utils/*": ["src/utils/*"],
      "@/context/*": ["src/context/*"],
      "@/assets/*": ["assets/*"]
    }
  },
  "include": [
    "src/**/*",
    "App.tsx"
  ],
  "exclude": [
    "node_modules"
  ]
}
EOF

# ESLint config
cat > .eslintrc.js << 'EOF'
module.exports = {
  extends: [
    'expo',
    '@typescript-eslint/recommended',
  ],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  rules: {
    '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/explicit-module-boundary-types': 'off',
    '@typescript-eslint/no-explicit-any': 'warn',
    '@typescript-eslint/prefer-const': 'error',
    'react-hooks/exhaustive-deps': 'warn',
    'react-native/no-unused-styles': 'error',
    'react-native/split-platform-components': 'error',
    'react-native/no-inline-styles': 'warn',
    'react-native/no-color-literals': 'warn',
    'prefer-const': 'error',
    'no-var': 'error',
    'no-console': ['warn', { allow: ['warn', 'error'] }],
    'eqeqeq': 'error',
    'curly': 'error',
  },
  ignorePatterns: [
    'node_modules/',
    '.expo/',
    'dist/',
    'build/',
  ],
};
EOF

# Babel config
cat > babel.config.js << 'EOF'
module.exports = function(api) {
  api.cache(true);
  return {
    presets: ['babel-preset-expo'],
    plugins: [
      [
        'module-resolver',
        {
          root: ['./src'],
          alias: {
            '@': './src',
            '@/components': './src/components',
            '@/screens': './src/screens',
            '@/services': './src/services',
            '@/types': './src/types',
            '@/utils': './src/utils',
            '@/context': './src/context',
            '@/assets': './assets',
          },
        },
      ],
    ],
  };
};
EOF

# Metro config
cat > metro.config.js << 'EOF'
const { getDefaultConfig } = require('@expo/metro-config');

const config = getDefaultConfig(__dirname);

config.resolver.alias = {
  '@': './src',
  '@/components': './src/components',
  '@/screens': './src/screens',
  '@/services': './src/services',
  '@/types': './src/types',
  '@/utils': './src/utils',
  '@/context': './src/context',
  '@/assets': './assets',
};

module.exports = config;
EOF

# EAS config
cat > eas.json << 'EOF'
{
  "cli": {
    "version": ">= 3.0.0"
  },
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal"
    },
    "preview": {
      "distribution": "internal"
    },
    "production": {
      "autoIncrement": true
    }
  },
  "submit": {
    "production": {}
  }
}
EOF

# .gitignore
cat > .gitignore << 'EOF'
# dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Expo
.expo/
dist/
web-build/

# Native
*.orig.*
*.jks
*.p8
*.p12
*.key
*.mobileprovision

# Metro
.metro-health-check*

# debug
npm-debug.*
yarn-debug.*
yarn-error.*

# macOS
.DS_Store
*.pem

# local env files
.env*.local
.env

# typescript
*.tsbuildinfo

# testing
coverage/

# IDE
.vscode/
.idea/
*.swp
*.swo

# misc
*.log
EOF

# .env.example
cat > .env.example << 'EOF'
# Copy this to .env and fill in your values
EXPO_PROJECT_ID=your-project-id-here
API_BASE_URL=https://your-api.com
EOF

echo "🎯 Creating core source files..."

# NOTE: Due to the complexity of the source files, you'll need to copy the content 
# from the artifacts I provided earlier. This script creates the structure and 
# configuration files. For the full source code files, please refer to the 
# artifacts above and copy them into the appropriate locations.

echo "📱 Creating placeholder source files..."

# Create placeholder files that need to be filled with content from artifacts
touch App.tsx
touch src/types/index.ts
touch src/theme.ts
touch src/utils/index.ts
touch src/context/TimerContext.tsx
touch src/services/SoundService.ts
touch src/services/StorageService.ts
touch src/services/NotificationService.ts
touch src/services/BackgroundTimerService.ts
touch src/screens/TimersScreen.tsx
touch src/screens/TimerDetailScreen.tsx
touch src/screens/AddTimerScreen.tsx
touch src/screens/AddGroupScreen.tsx
touch src/screens/SettingsScreen.tsx

# Test file
cat > __tests__/App.test.tsx << 'EOF'
import React from 'react';
import renderer from 'react-test-renderer';
import App from '../App';

describe('<App />', () => {
  it('renders correctly', () => {
    const tree = renderer.create(<App />).toJSON();
    expect(tree).toBeTruthy();
  });
});
EOF

# Create placeholder sound files
echo "🎵 Creating placeholder sound files (you'll need to add actual audio files)..."
touch assets/sounds/bell.wav
touch assets/sounds/beep.wav
touch assets/sounds/chime.wav
touch assets/sounds/gong.wav

# Create placeholder image files
echo "🖼️ Creating placeholder image files (you'll need to add actual images)..."
touch assets/icon.png
touch assets/adaptive-icon.png
touch assets/splash.png
touch assets/favicon.png
touch assets/notification-icon.png

echo ""
echo "✅ Project structure created successfully!"
echo ""
echo "📋 NEXT STEPS:"
echo "1. Copy the source code content from the artifacts into the appropriate files:"
echo "   - App.tsx"
echo "   - src/types/index.ts"
echo "   - src/theme.ts"
echo "   - src/utils/index.ts"
echo "   - src/context/TimerContext.tsx"
echo "   - All service files in src/services/"
echo "   - All screen files in src/screens/"
echo ""
echo "2. Add actual asset files:"
echo "   - Sound files (.wav format) in assets/sounds/"
echo "   - Image files (.png format) in assets/"
echo ""
echo "3. Install dependencies:"
echo "   npm install"
echo ""
echo "4. Start development:"
echo "   npm start"
echo ""
echo "🎉 Your TimeFlow Mobile app is ready for development!"
EOF

# Make the script executable
chmod +x setup-project.sh