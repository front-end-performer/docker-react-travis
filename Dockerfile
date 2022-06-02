# as builder Phase
FROM node:16-alpine as builder
WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx
# /app/build <-- we need only all stuf from it
# we want to copy from builder phase. 
# /usr/share/ngnix/html <-- ngnix will use that staic files 
COPY --from=builder /app/build /usr/share/nginx/html
