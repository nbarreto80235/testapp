# use node image as base image
FROM node:14.21.3-alpine3.17

# set working directory
WORKDIR /app

# copy all files from current directory to working directory
COPY . .

# install dependencies
RUN npm install

# build app for production with minification
RUN npm run build

# use nginx image as base image
FROM nginx:1.21.3-alpine

# copy build output to nginx html directory
COPY --from=0 /app/dist/web-potenciostate /usr/share/nginx/html

# expose port 80
#http
EXPOSE 80 
#https
EXPOSE 443

# run nginx
CMD ["nginx", "-g", "daemon off;"]