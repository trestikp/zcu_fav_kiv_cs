import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import {HiddenAdminService} from "../../services/hidden-admin.service";
import {ToastrService} from "ngx-toastr";

@Component({
  selector: 'app-hidden-admin',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './hidden-admin.component.html',
  styleUrl: './hidden-admin.component.css'
})
export class HiddenAdminComponent {

  constructor(private hiddenAdminService: HiddenAdminService,
              private toastr: ToastrService) { }

  setAllRidesAsCompleted(): void {
    this.hiddenAdminService.setAllRidesAsCompleted().subscribe({
      next: () => {
        this.toastr.success('All rides have been set as completed.');
      },
      error: err => {
        this.toastr.error('Error while setting all rides as completed.');
      }
    });
  }

}
