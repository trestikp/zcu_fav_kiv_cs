import { TestBed } from '@angular/core/testing';

import { HiddenAdminService } from './hidden-admin.service';

describe('HiddenAdminService', () => {
  let service: HiddenAdminService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HiddenAdminService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
