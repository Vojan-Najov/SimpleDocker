# Simple Docker. Report

## Contents

1. [Ready-made docker](#part-1-ready-made docker)

## Part 1. Ready-made docker

- Take the official docker image from nginx and download it using `docker pull nginx`. \
  <img src="../misc/images/part1_01.png" alt=part1_01 width="700"/>
- Check for the docker image with `docker images`. \
  <img src="../misc/images/part1_02.png" alt=part1_02 width="700"/>
- Run docker image with docker `run -d nginx`. \
  <img src="../misc/images/part1_03.png" alt=part1_03 width="700"/>
- Check that the image is running with `docker ps`. \
  <img src="../misc/images/part1_04.png" alt=part1_04 width="700"/>
- View container information with `docker inspect nginx`. \
  <img src="../misc/images/part1_05.png" alt=part1_05 width="700"/> \
  <img src="../misc/images/part1_06.png" alt=part1_06 width="700"/> \
  <img src="../misc/images/part1_07.png" alt=part1_07 width="700"/> \
  <img src="../misc/images/part1_08.png" alt=part1_08 width="700"/>
  <img src="../misc/images/part1_09.png" alt=part1_09 width="700"/>
- From the command output define and write in the report the container size, list of mapped ports and container ip: \
  - size is 67108864; \
    <img src="../misc/images/part1_10.png" alt=part1_10 width="700"/>
  - exposed ports list is "80/tcp": {}
  - 
