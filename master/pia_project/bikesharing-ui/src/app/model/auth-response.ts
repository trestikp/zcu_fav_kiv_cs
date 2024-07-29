import {AuthResponseUser} from "./auth-response-user";

export interface AuthResponse {
  message: string;
  token: string;
  user: AuthResponseUser;
}
