import { Injectable } from '@angular/core';
import {Client} from "@stomp/stompjs";
import {environment} from "../../environments/environment";

/**
 * Service for sending bike location update through WebSocket
 */
@Injectable({
  providedIn: 'root'
})
export class MoveBikeWebSocketService {
  private backendUrlWs = environment.backendUrlWs ?? "ws://localhost:8080";
  client: Client | undefined

  constructor() {
    this.initializeWebSocketConnection();
  }

  /**
   * Prepares the websocket
   * @private
   */
  private initializeWebSocketConnection(): void {
    this.client = new Client({
      brokerURL: `${this.backendUrlWs}/bikeMovement`,
      onConnect: () => {
        // console.log('Established connection to websocket for updating bike location');
      }
    });

    this.client.activate();
  }

  /**
   * Sends bike location update
   * @param message BikeLocationWsMessage as JSON string
   */
  sendMoveBikeMessage(message: string): void {
    this.client?.publish({destination: '/app/moveBike', body: message});
  }
}
