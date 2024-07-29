export const environment = {
  production: true,
  backendUrl: 'http://localhost:8080',
  backendUrlWs: 'ws://localhost:8080', // url of backend websocket
  authorizationUri: 'https://github.com/login/oauth/authorize', // github authorization url
  redirectUri: 'http://localhost:4200/github-login', // github redirect url (must match github app url)
  clientId: 'dcddae03ad53f02c1d90', // github app client id
  ORSToken: '5b3ce3597851110001cf62488be2e1e2c7f84c1987837f02310b0e2d', // openrouteservice token (for path finding)
  rideIntervalInMs: 2000, // interval for ride client ride update (this is client side ride simulation)
  rideDistancePerIntervalInM: 500, // distance to travel per interval (this is client side ride simulation)
  rideBackendUpdateIntervalInMs: 3000, // interval for frequency of sending bike location (from running simulation) to backend
  activeMQBrokerWsUrl: 'ws://localhost:61614', // activeMQ broker websocket url

  // enables admin functionality (admin panel) - this provides special functions, that bypass logic checks
  // (for example - set all user's rides as completed. If a user disconnects or something, the ride simulations ends
  //  and the ride is in inconsistent state. This is considered OK, because the user should then contact administrator,
  //  however a function to enable the user again without manipulating the DB directly is desired)
  adminEnabled: false,
};
