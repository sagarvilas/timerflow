import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { PaperProvider } from 'react-native-paper';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { theme } from './src/theme';
import TimersScreen from './src/screens/TimersScreen';
import AddGroupScreen from './src/screens/AddGroupScreen';
import AddTimerScreen from './src/screens/AddTimerScreen';
import TimerDetailScreen from './src/screens/TimerDetailScreen';
import SettingsScreen from './src/screens/SettingsScreen';
import { TimerProvider } from './src/context/TimerContext';

const Stack = createStackNavigator();
const Tab = createBottomTabNavigator();

function MainTabs() {
  return (
    <Tab.Navigator>
      <Tab.Screen
        name="Timers"
        component={TimersScreen}
        options={{
          tabBarIcon: ({ color, size }) => (
            <MaterialCommunityIcons name="timer" color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Settings"
        component={SettingsScreen}
        options={{
          tabBarIcon: ({ color, size }) => (
            <MaterialCommunityIcons name="cog" color={color} size={size} />
          ),
        }}
      />
    </Tab.Navigator>
  );
}

export default function App() {
  return (
    <PaperProvider theme={theme}>
      <TimerProvider>
        <NavigationContainer>
          <Stack.Navigator>
            <Stack.Screen name="Main" component={MainTabs} options={{ headerShown: false }} />
            <Stack.Screen name="AddGroup" component={AddGroupScreen} />
            <Stack.Screen name="AddTimer" component={AddTimerScreen} />
            <Stack.Screen name="TimerDetail" component={TimerDetailScreen} />
          </Stack.Navigator>
        </NavigationContainer>
      </TimerProvider>
    </PaperProvider>
  );
}
