export interface Timer {
  id: string;
  name: string;
  duration: number; // in seconds
}

export interface TimerGroup {
  id: string;
  name:string;
  timers: Timer[];
}
