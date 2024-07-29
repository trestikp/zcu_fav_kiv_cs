import {Component} from '@angular/core';
import {CommonModule} from '@angular/common';
import {MatTableModule} from "@angular/material/table";

@Component({
  selector: 'app-about',
  standalone: true,
  imports: [CommonModule, MatTableModule],
  templateUrl: './about.component.html',
  styleUrl: './about.component.css'
})
export class AboutComponent {
  constructor() {
  }

  ngOnInit(): void {
  }
}
