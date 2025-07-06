import React, { useState, useEffect } from 'react';
import { View, Text } from 'react-native';
import { Button, Title } from 'react-native-paper';
import { useKeepAwake } from 'expo-keep-awake';
import { Audio } from 'expo-av';

const TimerDetailScreen = ({ route }) => {
  const { timer } = route.params;
  const [remainingTime, setRemainingTime] = useState(timer.duration);
  const [isActive, setIsActive] = useState(false);
  const [sound, setSound] = useState<Audio.Sound>();

  useKeepAwake();

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (isActive && remainingTime > 0) {
      interval = setInterval(() => {
        setRemainingTime(time => time - 1);
      }, 1000);
    } else if (remainingTime === 0) {
      playSound();
    }
    return () => clearInterval(interval);
  }, [isActive, remainingTime]);

  async function playSound() {
    const { sound } = await Audio.Sound.createAsync(
       require('../../assets/sounds/bell.wav')
    );
    setSound(sound);
    await sound.playAsync(); 
  }

  useEffect(() => {
    return sound
      ? () => {
          sound.unloadAsync(); 
        }
      : undefined;
  }, [sound]);

  const toggleTimer = () => {
    setIsActive(!isActive);
  };

  const formatTime = (time: number) => {
    const minutes = Math.floor(time / 60);
    const seconds = time % 60;
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  };

  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Title>{timer.name}</Title>
      <Text style={{ fontSize: 80, marginVertical: 20 }}>{formatTime(remainingTime)}</Text>
      <Button mode="contained" onPress={toggleTimer}>
        {isActive ? 'Pause' : 'Start'}
      </Button>
    </View>
  );
};

export default TimerDetailScreen;
