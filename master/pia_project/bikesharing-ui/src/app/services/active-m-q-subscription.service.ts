import {Injectable} from '@angular/core';
import {Client} from '@stomp/stompjs';
import {Subject} from "rxjs";
import {environment} from "../../environments/environment";

/**
 * Service to subscribe to ActiveMQ topics.
 */
@Injectable({
  providedIn: 'root'
})
export class ActiveMQSubscriptionService {
  private bikeLocationSubject = new Subject<any>();
  private bikeRemovalSubject = new Subject<any>();


  constructor() {
    this.initializeWebSocketConnection();
  }

  /**
   * Initializes the WebSocket connection to the ActiveMQ broker.
   * @private
   */
  private initializeWebSocketConnection(): void {
    const client = new Client({
      brokerURL: environment.activeMQBrokerWsUrl ?? 'ws://localhost:61614/ws',
      onConnect: () => {
        client.subscribe('/topic/kiv.pia.bikesharing.bikes.location', message =>
          this.bikeLocationSubject.next(message.body)
        );
        client.subscribe('/topic/kiv.pia.bikesharing.bikes.removal', message =>
          this.bikeRemovalSubject.next(message.body)
        );
      },
    });
    client.activate();
  }

  /**
   * Returns the Subject to subscribe to for bike location updates.
   */
  getBikeLocationUpdates(): Subject<any> {
    return this.bikeLocationSubject;
  }

  /**
   * Returns the Subject to subscribe to for bike removal updates.
   */
  getBikeRemovalUpdates(): Subject<any> {
    return this.bikeRemovalSubject;
  }
}
