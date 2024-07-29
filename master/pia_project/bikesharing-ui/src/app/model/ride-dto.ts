import {LocationDTO} from "./location-dto";
import {BikeDTO} from "./bike-dto";
import {UserDTO} from "./user-dto";

export interface RideDTO {
  id: string;
  startTime: string;
  endTime?: string;
  startLocationName: string;
  endLocationName?: string;
  startLocation: LocationDTO;
  endLocation?: LocationDTO;
  bike: BikeDTO;
  user: UserDTO;
}
