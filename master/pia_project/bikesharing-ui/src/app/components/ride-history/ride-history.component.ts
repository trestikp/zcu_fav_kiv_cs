import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import {RideService} from "../../services/ride.service";
import {MatTableModule} from "@angular/material/table";
import {ToastrService} from "ngx-toastr";
import {RideDTO} from "../../model/ride-dto";

/**
 * Component requests all past rides for the user and displays them in a table.
 */
@Component({
  selector: 'app-ride-history',
  standalone: true,
  imports: [CommonModule, MatTableModule],
  templateUrl: './ride-history.component.html',
  styleUrl: './ride-history.component.css'
})
export class RideHistoryComponent {
  hasData = true;
  failedLoad = false;
  rides: RideDTO[] = [];
  displayedColumns = ['index', 'startTime', 'endTime', 'startLocationName', 'endLocationName', 'bikeId'];

  constructor(private rideService: RideService,
              private toastr: ToastrService) { }

  ngOnInit(): void {
    this.rideService.getAllRides().subscribe({
      next: (data) => {
        // no idea how to handle 204, but 204 goes here and data is "null"
        this.rides = data;
        this.hasData = this.rides?.length > 0;
        this.failedLoad = false;

        // convert time string to dates, so it can be formatted
        this.rides?.map((ride: RideDTO) => {
          // no idea what time format should be used
          ride.startTime = new Date(ride.startTime).toUTCString();
          ride.endTime = new Date(ride.endTime ?? "").toUTCString();
        });
      },
      error: (err) => {
        this.failedLoad = true;
        this.toastr.error("Failed to retrieve rides.", "Rides error");
      }
    });
  }
}
