# set the base image to create the image for react app
FROM node:20.9

# set the working directory to /app
RUN mkdir -p /usr/src/next-app && chown -R node:node /usr/src/next-app

# copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# install dependencies
RUN npm install

# copy the rest of the files to the working directory
COPY --chown=node:node . .

RUN npm run build

# expose port 3000 to tell Docker that the container listens on the specified network ports at runtime
EXPOSE 3000

# command to run the app
CMD npm start