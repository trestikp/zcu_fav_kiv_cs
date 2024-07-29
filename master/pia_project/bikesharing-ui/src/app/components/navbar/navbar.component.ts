import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SessionStorageService } from "../../services/session-storage.service";
import { Router } from "@angular/router";
import {environment} from "../../../environments/environment";

/**
 * Component for displaying the navbar. Navbar also contains buttons for login, registration and logout.
 */
@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {
  private adminEnabled: boolean = environment.adminEnabled;

  constructor(private storage: SessionStorageService,
              private router: Router) { }


  /**
   * User to display admin panel in nav. This is mostly for "fixing"/ development purposes.
   */
  isAdminEnabled(): boolean {
    return this.adminEnabled;
  }

  /**
   * Checks if the client is authenticated (has a token).
   */
  hasToken(): boolean {
    return this.storage.getToken() !== null && this.storage.getToken()?.trim() !== '';
  }

  /**
   * Gets the username of the currently logged in user.
   */
  getUsername(): string {
    // if some error with getting username occurs, '' will look like "User logged in"
    return this.storage.getUser()?.username ?? '';
  }

  /**
   * Logout button handler.
   */
  logout(): void {
    this.storage.signOut();
    this.router.navigate(['/']).then(() => window.location.reload());
  }

  /**
   * Returns user's roles.
   */
  getRoles(): string[] {
    return this.storage.getUser()?.roles ?? [];
  }
}
