#!/bin/bash
DATABASE=gis
URL=http://download.geofabrik.de/asia/taiwan-latest.osm.bz2
curl -s $URL | bzip2 -d > taiwan.osm
osm2pgsql -m -S zh.style -d $DATABASE taiwan.osm

psql -d $DATABASE << CMD
update planet_osm_line set "name:zh" = "name" where "name:zh" is null and name is not null;
update planet_osm_point set "name:zh" = "name" where "name:zh" is null and name is not null;
update planet_osm_polygon set "name:zh" = "name" where "name:zh" is null and name is not null;
update planet_osm_roads set "name:zh" = "name" where "name:zh" is null and name is not null;
update planet_osm_line set "name:bnn" = "name:zh" where "name:bnn" is null and "name:zh" is not null;
update planet_osm_point set "name:bnn" = "name:zh" where "name:bnn" is null and "name:zh" is not null;
update planet_osm_polygon set "name:bnn" = "name:zh" where "name:bnn" is null and "name:zh" is not null;
update planet_osm_roads set "name:bnn" = "name:zh" where "name:bnn" is null and "name:zh" is not null;
CMD
