import { Injectable } from '@angular/core';
import { HttpEvent, HttpInterceptor, HttpHandler, HttpRequest, HTTP_INTERCEPTORS } from '@angular/common/http';
import { Observable } from 'rxjs';
import {SessionStorageService} from "../services/session-storage.service";

const TOKEN_HEADER_KEY = 'Authorization';       // for Spring Boot back-end

/**
 * Interceptor to add the Authorization token to the header of each request.
 */
@Injectable()
export class HttpRequestInterceptor implements HttpInterceptor {
  constructor(private storage: SessionStorageService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    let authReq = req;
    const token = this.storage.getToken();
    if (token != null) {
      authReq = req.clone({ headers: req.headers.set(TOKEN_HEADER_KEY, 'Bearer ' + token) });
    }
    return next.handle(authReq);
  }
}

export const httpInterceptorProviders = [
  { provide: HTTP_INTERCEPTORS, useClass: HttpRequestInterceptor, multi: true },
];
