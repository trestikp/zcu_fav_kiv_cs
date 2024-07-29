export interface BikeLocationWsMessage {
  jwtToken: string;
  bikeId: string;
  latitude: number;
  longitude: number;
}
