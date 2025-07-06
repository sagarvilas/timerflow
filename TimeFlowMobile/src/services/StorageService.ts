import AsyncStorage from '@react-native-async-storage/async-storage';
import { TimerGroup } from '../types';

const STORAGE_KEY = 'timerGroups';

export const StorageService = {
  saveTimerGroups: async (groups: TimerGroup[]): Promise<void> => {
    try {
      const jsonValue = JSON.stringify(groups);
      await AsyncStorage.setItem(STORAGE_KEY, jsonValue);
    } catch (e) {
      console.error('Failed to save timer groups.', e);
    }
  },

  loadTimerGroups: async (): Promise<TimerGroup[]> => {
    try {
      const jsonValue = await AsyncStorage.getItem(STORAGE_KEY);
      return jsonValue != null ? JSON.parse(jsonValue) : [];
    } catch (e) {
      console.error('Failed to load timer groups.', e);
      return [];
    }
  },
};
