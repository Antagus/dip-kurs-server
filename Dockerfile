FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
COPY .env . 

RUN npm run build
EXPOSE ${PORT}

CMD ["npm", "start"]
