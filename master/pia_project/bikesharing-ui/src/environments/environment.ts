// see environment.prod.ts for notes
export const environment = {
  production: false,
  backendUrl: 'http://localhost:8080',
  backendUrlWs: 'ws://localhost:8080',
  authorizationUri: 'https://github.com/login/oauth/authorize',
  redirectUri: 'http://localhost:4200/github-login',
  clientId: 'dcddae03ad53f02c1d90',
  ORSToken: '5b3ce3597851110001cf62488be2e1e2c7f84c1987837f02310b0e2d',
  rideIntervalInMs: 2000,
  rideDistancePerIntervalInM: 500,
  rideBackendUpdateIntervalInMs: 5000,
  activeMQBrokerWsUrl: 'ws://localhost:61614',
  adminEnabled: true,
};
