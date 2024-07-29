import { TestBed } from '@angular/core/testing';

import { MoveBikeWebSocketService } from './move-bike-web-socket.service';

describe('MoveBikeWebSocketService', () => {
  let service: MoveBikeWebSocketService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MoveBikeWebSocketService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
