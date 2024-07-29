import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HiddenAdminComponent } from './hidden-admin.component';

describe('HiddenAdminComponent', () => {
  let component: HiddenAdminComponent;
  let fixture: ComponentFixture<HiddenAdminComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HiddenAdminComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(HiddenAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
