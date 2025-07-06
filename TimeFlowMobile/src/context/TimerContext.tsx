import React, { createContext, useState, useContext, useEffect } from 'react';
import { Timer, TimerGroup } from '../types';
import { StorageService } from '../services/StorageService';

interface TimerContextData {
  timerGroups: TimerGroup[];
  addTimerGroup: (group: TimerGroup) => void;
  addTimer: (groupId: string, timer: Timer) => void;
}

const TimerContext = createContext<TimerContextData>({} as TimerContextData);

export const TimerProvider: React.FC<{children: React.ReactNode}> = ({ children }) => {
  const [timerGroups, setTimerGroups] = useState<TimerGroup[]>([]);

  useEffect(() => {
    const loadGroups = async () => {
      const groups = await StorageService.loadTimerGroups();
      setTimerGroups(groups);
    };
    loadGroups();
  }, []);

  useEffect(() => {
    StorageService.saveTimerGroups(timerGroups);
  }, [timerGroups]);

  const addTimerGroup = (group: TimerGroup) => {
    const newGroups = [...timerGroups, group];
    setTimerGroups(newGroups);
  };

  const addTimer = (groupId: string, timer: Timer) => {
    const updatedGroups = timerGroups.map(group => {
      if (group.id === groupId) {
        return {
          ...group,
          timers: [...group.timers, timer],
        };
      }
      return group;
    });
    setTimerGroups(updatedGroups);
  };

  return (
    <TimerContext.Provider value={{ timerGroups, addTimerGroup, addTimer }}>
      {children}
    </TimerContext.Provider>
  );
};

export const useTimer = () => useContext(TimerContext);
