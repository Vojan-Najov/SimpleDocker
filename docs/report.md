# Simple Docker. Report

## Contents

1. [Ready-made docker](#part-1-ready-made-docker)
2. [Operations with container](#part-2-operations-with-container)

## Part 1. Ready-made docker

- Take the official docker image from nginx and download it using `docker pull nginx`. \
  <img src="../misc/images/part1_01.png" alt=part1_01 width="700"/>
- Check for the docker image with `docker images`. \
  <img src="../misc/images/part1_02.png" alt=part1_02 width="700"/>
- Run docker image with docker `run -d nginx`. \
  <img src="../misc/images/part1_03.png" alt=part1_03 width="700"/>
- Check that the image is running with `docker ps`. \
  <img src="../misc/images/part1_04.png" alt=part1_04 width="700"/>
- View container information with `docker inspect 6ec26c60f4f8`. \
  <img src="../misc/images/part1_05.png" alt=part1_05 width="700"/> \
  <img src="../misc/images/part1_06.png" alt=part1_06 width="700"/> \
  <img src="../misc/images/part1_07.png" alt=part1_07 width="700"/> \
  <img src="../misc/images/part1_08.png" alt=part1_08 width="700"/>
  <img src="../misc/images/part1_09.png" alt=part1_09 width="700"/>
- From the command output define and write in the report the container size, list of mapped ports and container ip:
  - size is `67108864`; \
    <img src="../misc/images/part1_10.png" alt=part1_10 width="600"/>
  - mapped ports list is `"80/tcp": null`; \
    <img src="../misc/images/part1_11.png" alt=part1_11 width="600"/>
  - ip is `172.17.0.2`; \
    <img src="../misc/images/part1_12.png" alt=part1_12 width="600"/>
- Stop docker image with docker stop 6ec26c60f4f8. \
  <img src="../misc/images/part1_13.png" alt=part1_13 width="700"/>
- Check that the image has stopped with `docker ps`. \
  <img src="../misc/images/part1_14.png" alt=part1_14 width="700"/>
- Run docker with ports 80 and 443 in container, mapped to the same ports on the local machine, \
  using command `docker run -d -p 127.0.0.1:80:80 -p 127.0.0.1:443:443` \
  <img src="../misc/images/part1_15.png" alt=part1_15 width="700"/>
- Check that the nginx start page is available in the browser at `localhost:80`. \
  <img src="../misc/images/part1_16.png" alt=part1_16 width="700"/>
  - Pre-install xinit, openbox, firefox on a virtual machine.
  - Then open the window manager with the `startx` command, right-click open `firefox`.
- Restart docker container with `docker restart [container_id|container_name]`. \
  Then check in any way that the container is running. \
  <img src="../misc/images/part1_17.png" alt=part1_17 width="700"/>

## Part 2. Operations with container

- Read the nginx.conf configuration file inside the docker container with the exec command. \
  Run docker with name nginx_container  with ports 80 and 443 in container using command: \
  `docker run -d -p 127.0.0.1:80:80 -p 127.0.0.1:443:443 --name nginx_container nginx`\
  Then read config using command: \
  `docker exec -it nginx_container sh -c "cat /etc/nginx/nginx.conf"` \
  <img src="../misc/images/part2_01.png" alt=part2_01 width="700"/>
  
