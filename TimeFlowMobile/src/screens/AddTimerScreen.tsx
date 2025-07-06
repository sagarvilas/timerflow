import React, { useState } from 'react';
import { View } from 'react-native';
import { Button, TextInput } from 'react-native-paper';
import { useTimer } from '../context/TimerContext';
import 'react-native-get-random-values';
import { v4 as uuidv4 } from 'uuid';

const AddTimerScreen = ({ route, navigation }) => {
  const { groupId } = route.params;
  const [name, setName] = useState('');
  const [duration, setDuration] = useState('');
  const { addTimer } = useTimer();

  const handleAddTimer = () => {
    if (name.trim() === '' || duration.trim() === '') return;
    addTimer(groupId, { id: uuidv4(), name, duration: parseInt(duration, 10) });
    navigation.goBack();
  };

  return (
    <View style={{ flex: 1, padding: 20 }}>
      <TextInput
        label="Timer Name"
        value={name}
        onChangeText={setName}
        mode="outlined"
      />
      <TextInput
        label="Duration (seconds)"
        value={duration}
        onChangeText={setDuration}
        keyboardType="numeric"
        mode="outlined"
        style={{ marginTop: 10 }}
      />
      <Button mode="contained" onPress={handleAddTimer} style={{ marginTop: 20 }}>
        Add Timer
      </Button>
    </View>
  );
};

export default AddTimerScreen;
