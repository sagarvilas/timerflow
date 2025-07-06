import React, { useState } from 'react';
import { View } from 'react-native';
import { Button, TextInput } from 'react-native-paper';
import { useTimer } from '../context/TimerContext';
import 'react-native-get-random-values';
import { v4 as uuidv4 } from 'uuid';

const AddGroupScreen = ({ navigation }) => {
  const [name, setName] = useState('');
  const { addTimerGroup } = useTimer();

  const handleAddGroup = () => {
    if (name.trim() === '') return;
    addTimerGroup({ id: uuidv4(), name, timers: [] });
    navigation.goBack();
  };

  return (
    <View style={{ flex: 1, padding: 20 }}>
      <TextInput
        label="Group Name"
        value={name}
        onChangeText={setName}
        mode="outlined"
      />
      <Button mode="contained" onPress={handleAddGroup} style={{ marginTop: 20 }}>
        Add Group
      </Button>
    </View>
  );
};

export default AddGroupScreen;
