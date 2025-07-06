import * as Notifications from 'expo-notifications';

Notifications.setNotificationHandler({
  handleNotification: async () => ({
    shouldShowAlert: true,
    shouldPlaySound: false,
    shouldSetBadge: false,
  }),
});

export const NotificationService = {
  scheduleNotification: async (title: string, body: string, seconds: number): Promise<string> => {
    const identifier = await Notifications.scheduleNotificationAsync({
      content: {
        title,
        body,
      },
      trigger: { seconds },
    });
    return identifier;
  },

  cancelNotification: async (identifier: string): Promise<void> => {
    await Notifications.cancelScheduledNotificationAsync(identifier);
  },
};
