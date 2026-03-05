FROM node:18

WORKDIR /app

# copy dependency files
COPY package*.json ./

# install dependencies
RUN npm install

# copy application code
COPY . .

EXPOSE 3000

CMD ["node", "server.js"]