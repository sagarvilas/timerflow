import React from 'react';
import { View, Text, FlatList, TouchableOpacity } from 'react-native';
import { Button, Card, Title } from 'react-native-paper';
import { useTimer } from '../context/TimerContext';
import { TimerGroup } from '../types';

const TimersScreen = ({ navigation }) => {
  const { timerGroups } = useTimer();

  const renderTimerGroup = ({ item }: { item: TimerGroup }) => (
    <Card style={{ margin: 10 }}>
      <Card.Content>
        <Title>{item.name}</Title>
        <FlatList
          data={item.timers}
          keyExtractor={(timer) => timer.id}
          renderItem={({ item: timer }) => (
            <TouchableOpacity onPress={() => navigation.navigate('TimerDetail', { timer })}>
              <Text>{timer.name} - {timer.duration}s</Text>
            </TouchableOpacity>
          )}
        />
      </Card.Content>
      <Card.Actions>
        <Button onPress={() => navigation.navigate('AddTimer', { groupId: item.id })}>
          Add Timer
        </Button>
      </Card.Actions>
    </Card>
  );

  return (
    <View style={{ flex: 1, padding: 10 }}>
      <FlatList
        data={timerGroups}
        keyExtractor={(group) => group.id}
        renderItem={renderTimerGroup}
        ListEmptyComponent={<Text>No timers yet. Add a group!</Text>}
      />
      <Button mode="contained" onPress={() => navigation.navigate('AddGroup')}>
        Add Timer Group
      </Button>
    </View>
  );
};

export default TimersScreen;
