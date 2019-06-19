#This is a two build phase Dockerfile.  
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .  
# the below notes were from the dev build..we see now why we did that
# (set up Docker volumes via command line to get source code copied)
# (the copy could be removed because docker compose took care of it. but we're
# leaving it in because this could become a production build etc. and would need the copy command)

RUN npm run build
# this will create numerous directories but all we care about is /app/build  <- it's just an npm thing:w




#the from statement indicates that the previous FROM is done.  nginx automatically will start
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
# copies from the previous alpine build directory /app/build to
# this new image build  to /usr/share/nginx/html  (this directory is from the nginx documentation) dir

