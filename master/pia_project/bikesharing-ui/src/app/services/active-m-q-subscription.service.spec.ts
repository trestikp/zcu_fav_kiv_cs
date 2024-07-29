import { TestBed } from '@angular/core/testing';

import { ActiveMQSubscriptionService } from './active-m-q-subscription.service';

describe('WebSocketService', () => {
  let service: ActiveMQSubscriptionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ActiveMQSubscriptionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
