#!/bin/bash
/opt/pharo/pharo \
	/opt/bookstore/Pharo.image \
	start-book-store \
	--port=44444 \
	--bind-address=0.0.0.0 \
	--db-database="${DATABASE_NAME}" \
	--db-host="${DATABASE_HOSTNAME}" \
	--db-password="${DATABASE_PASSWORD}" \
	--db-port="${DATABASE_PORT:-3306}" \
	--db-username="${DATABASE_USERNAME}"
