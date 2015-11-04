FROM ndla/nginx-lua

# Delete examplefiles
RUN rm /nginx/conf.d/default.conf

COPY nginx.conf /nginx/nginx.conf
