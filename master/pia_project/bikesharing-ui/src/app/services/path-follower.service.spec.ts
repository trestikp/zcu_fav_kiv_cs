import { TestBed } from '@angular/core/testing';

import { PathFollowerService } from './path-follower.service';

describe('PathFollowerService', () => {
  let service: PathFollowerService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PathFollowerService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
