import { Audio } from 'expo-av';

export const Sounds = {
  Beep: require('../../assets/sounds/beep.wav'),
  Bell: require('../../assets/sounds/bell.wav'),
  Chime: require('../../assets/sounds/chime.wav'),
  Gong: require('../../assets/sounds/gong.wav'),
};

export const SoundService = {
  playSound: async (sound: keyof typeof Sounds): Promise<void> => {
    const { sound: soundObject } = await Audio.Sound.createAsync(Sounds[sound]);
    await soundObject.playAsync();
  },
};
