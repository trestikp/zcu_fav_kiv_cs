import {LocationDTO} from "./location-dto";

export interface StandDTO {
  id: string;
  name: string;
  location: LocationDTO;
  availableBikes: number;

}
