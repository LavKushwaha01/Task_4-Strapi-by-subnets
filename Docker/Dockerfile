FROM node:20-alpine

WORKDIR /app

RUN npm install -g create-strapi-app

RUN npx create-strapi@latest my-app --quickstart

WORKDIR /app/my-app

# Build admin panel for production
RUN npm run build

EXPOSE 1337

CMD ["npm", "start"]
