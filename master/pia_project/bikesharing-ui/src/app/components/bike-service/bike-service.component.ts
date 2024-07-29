import {Component} from '@angular/core';
import {CommonModule} from '@angular/common';
import {MatTableModule} from "@angular/material/table";
import {ToastrService} from "ngx-toastr";
import {BikeService} from "../../services/bike.service";
import {BikeDTO} from "../../model/bike-dto";

/**
 * Component for displaying bikes due for service.
 */
@Component({
  selector: 'app-bike-service',
  standalone: true,
  imports: [CommonModule, MatTableModule],
  templateUrl: './bike-service.component.html',
  styleUrl: './bike-service.component.css'
})
export class BikeServiceComponent {
  hasData = true;
  failedLoad = false;
  bikes: BikeDTO[] = [];
  displayedColumns = ['index', 'bikeId', 'standName', 'lastServiceDate', 'action'];

  constructor(private bikeService: BikeService,
              private toastr: ToastrService) { }

  ngOnInit(): void {
    this.bikeService.getBikesDueForService().subscribe({
      next: (data) => {
        this.bikes = data;
        this.hasData = this.bikes.length > 0;
        this.failedLoad = false;

        // convert time string to dates, so it can be formatted
        this.bikes.map((bike: BikeDTO) => {
          // no idea what time format should be used
          bike.lastServiceDate = new Date(bike.lastServiceDate ?? "").toUTCString();
        });
      },
      error: (err) => {
        this.failedLoad = true;
        this.toastr.error("Failed to retrieve bikes due for service.", "Bikes error");
      }
    });
  }

  /**
   * Request marking a bike as serviced and based on response finish the action.
   * @param bike api bike object
   */
  markBikeServiced(bike: BikeDTO) {
    this.bikeService.postBikeServiced(bike.id).subscribe({
      next: (data) => {
        this.toastr.success(`Bike ${bike.id} serviced.`, "Bike serviced");

        // this causes removes the bike from observed data source -> updating the page
        this.bikes = this.bikes.filter((b: BikeDTO) => b.id !== bike.id);
        this.hasData = this.bikes.length > 0;
      },
      error: (err) => {
        this.toastr.error(`Failed to mark bike ${bike.id} as serviced.`, "Bike service error");
      }
    });
  }
}
