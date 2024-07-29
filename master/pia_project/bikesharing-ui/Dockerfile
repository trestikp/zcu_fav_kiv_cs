#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# README IMPORTANT!
#
# npm need lots of file descriptors. Run build of this image with atleast: --ulimit=2048:2048
#
# Due to some JS libraries being broken after build and nginx deployement, the deployment is done via the Angular CLI.
# This is not a proper way to deploy an Angular app! Due to lack of time, lack of knowledge and this being a school
# project this solution is considered good enough.
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# Stage 1: Build Angular Application
FROM node:20 AS builder

WORKDIR /app

COPY . .

# Install dependencies and build the Angular app
RUN npm install

# During real deployment, npm run build --prod would be used and install of @angular/cli would be removed
RUN npm install -g @angular/cli@17
#RUN npm run build --prod

CMD ng serve --host 0.0.0.0 --configuration=production

#
# This deploys the angular app the proper way. However, due to some JS libraries being broken the application
# will not work properly. Broken libraries are: leaflet-extramerkers, leaflet.animatedMarker. No markers
# for stand and bikes will show on the map without those.
#
## Stage 2: Serve Angular app using Nginx
#FROM nginx:stable-alpine
#
## Copy the built Angular app from the builder stage to the nginx container
#COPY --from=builder /app/dist/bikesharing-ui/* /usr/share/nginx/html/
#COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
#
## Expose port 80 for Nginx
#EXPOSE 80
#
## Start Nginx when the container runs
#CMD ["nginx", "-g", "daemon off;"]
