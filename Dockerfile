FROM node:latest
WORKDIR /usr/src/app
COPY package.json .
RUN npm install
COPY . ./

ENV PORT=3000
ENV SECRET=Rahasia
ENV GMAIL_USERNAME=example@gmail.com
ENV GMAIL_PASSWORD=passwordnya123beneran
ENV DB_USERNAME=root
ENV DB_PASSWORD=password
ENV DB_HOST=172.18.0.2
ENV DB_NAME=backend_wms
RUN npx sequelize-cli db:migrate
COPY --chown=node:node . .

EXPOSE 3000

CMD [ "node", "app.js" ]