import {LocationDTO} from "./location-dto";
import {StandDTO} from "./stand-dto";

export interface BikeDTO {
  id: string;
  lastServiceDate?: string | null;
  location: LocationDTO;
  stand: StandDTO;
}
