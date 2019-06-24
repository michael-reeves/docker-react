# tag the first phase "builder"
FROM node:alpine as builder  

WORKDIR '/app'

# copy in depedencies
COPY package.json .
RUN yarn install
COPY . .

# build the static assets
RUN yarn run build 


# specify second phase with 'FROM'
FROM nginx

# specify the previous phase with --from=builder
COPY --from=builder /app/build /usr/share/nginx/html

# NGINX automatically starts the webserver
