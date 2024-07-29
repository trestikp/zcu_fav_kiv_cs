import {Routes} from '@angular/router';
import {OsmViewComponent} from "./components/osm-view/osm-view.component";
import {PageNotFoundComponent} from "./components/page-not-found/page-not-found.component";
import {LoginComponent} from "./components/login/login.component";
import {RegisterComponent} from "./components/register/register.component";
import {RideHistoryComponent} from "./components/ride-history/ride-history.component";
import {BikeServiceComponent} from "./components/bike-service/bike-service.component";
import {AboutComponent} from "./components/about/about.component";
import {GithubLoginComponent} from "./components/github-login/github-login.component";
import {HiddenAdminComponent} from "./components/hidden-admin/hidden-admin.component";

export const routes: Routes = [
  { path: '', component: OsmViewComponent },
  { path: 'login', component: LoginComponent },
  { path: 'github-login', component: GithubLoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'ride_history', component: RideHistoryComponent },
  { path: 'bike_service', component: BikeServiceComponent },
  { path: 'about', component: AboutComponent },
  { path: 'hidden_admin', component: HiddenAdminComponent },
  { path: '**', component: PageNotFoundComponent }
];
