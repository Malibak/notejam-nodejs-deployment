FROM node:12

# Create app dir:
WORKDIR /usr/src/app

# Bundle app source:
COPY . .

# Install app dependencies:
RUN npm install

# Initialize db:
RUN node db.js

# Expose and run app:
EXPOSE 3000
CMD [ "node", "bin/www" ]
