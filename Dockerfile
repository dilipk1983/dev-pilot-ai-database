FROM postgres:16 AS base

# 2. Copy files to the container
# Note: Postgres automatically runs scripts in this folder, but since you use 
# an entrypoint.sh script, we keep your layout intact.
COPY lib /docker-entrypoint-initdb.d/lib
COPY releases /docker-entrypoint-initdb.d/releases
COPY changelog.xml /docker-entrypoint-initdb.d/
COPY liquibase.properties /docker-entrypoint-initdb.d/


FROM base AS final


USER root

ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:21 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY entrypoint.sh /usr/local/bin/custom-entrypoint.sh

RUN chmod +x /docker-entrypoint-initdb.d/lib/liquibase/liquibase
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

EXPOSE 5432

ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]