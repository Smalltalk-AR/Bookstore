FROM basmalltalk/pharo:7.0-image as imagebuilder

USER pharo
WORKDIR /opt/pharo
COPY . /source

# Stage 1, load the project on a clean pharo image
RUN chown -R pharo:pharo /opt/pharo
RUN pharo Pharo.image metacello install 'gitlocal:///source' 'BaselineOfBookstore'

# Stage 2, start from a clean image
FROM basmalltalk/pharo:7.0

USER root
WORKDIR /opt/bookstore

# Copy image and changes from previous stage
COPY --from=imagebuilder \
    /opt/pharo/Pharo.image \
    /opt/pharo/Pharo.changes \
    /opt/pharo/*.sources \
    ./

RUN mkdir logs
RUN chown -R pharo:users /opt/bookstore
RUN chmod g=u -R /opt/bookstore

USER pharo
EXPOSE 8080

ENTRYPOINT [ "pharo", "Pharo.image" ]
CMD	[ "eval", "--no-quit", "Bookstore new start"  ]
