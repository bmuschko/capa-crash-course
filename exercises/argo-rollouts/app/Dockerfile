FROM node:21.7.1-alpine3.18
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]