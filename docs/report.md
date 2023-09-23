# Simple Docker. Report

## Contents

1. [Ready-made docker](#part-1-ready-made-docker)
2. [Operations with container](#part-2-operations-with-container)
3. [Mini web server](#part-3-mini-web-server)
4. [Your own docker](#part-4-your-own-docker)
5. [Dockle](#part-5-dockle)
6. [Basic Docker Compose](#part-6-basic-docker-compose)

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
- Create a nginx.conf file on a local machine. \
  We use redirection of the standard stream to a file nginx.conf: \
  `docker exec -it nginx_container sh -c "cat /etc/nginx/nginx.conf" >nginx.conf`
  <img src="../misc/images/part2_02.png" alt=part2_02 width="700"/>
- Configure it on the /status path to return the nginx server status page. \
  let's change the configuration: \
  <img src="../misc/images/part2_03.png" alt=part2_03 width="700"/>
- Copy the created nginx.conf file inside the docker image using the docker cp command: \
  `docker cp nginx.conf nginx_container:/etc/nginx` \
  <img src="../misc/images/part2_04.png" alt=part2_04 width="700"/>
- Restart nginx inside the docker image with exec: \
  `docker exec -it nginx_container sh -c "nginx -s reload"` \
  <img src="../misc/images/part2_05.png" alt=part2_05 width="700"/>
- Check that localhost:80/status returns the nginx server status page: \
  <img src="../misc/images/part2_06.png" alt=part2_06 width="700"/> \
  <img src="../misc/images/part2_07.png" alt=part2_07 width="700"/>
- Export the container to a container.tar file with the export command \
  `docker export --output="container.tar" nginx_container` \
  <img src="../misc/images/part2_08.png" alt=part2_08 width="700"/>
- Stop the container: \
  `docker stop nginx_container` \
  <img src="../misc/images/part2_09.png" alt=part2_09 width="700"/>
- Delete the image with docker rmi [image_id|repository]without removing the container first: \
  `docker rmi -f nginx` \
  <img src="../misc/images/part2_10.png" alt=part2_10 width="700"/>
- Delete stopped container: \
  `docker container rm nginx_container` \
  <img src="../misc/images/part2_11.png" alt=part2_11 width="700"/>
- Import the container back using the import command: \
  `docker import -c "ENTRYPOINT [\"/docker-entrypoint.sh\", \"/usr/sbin/nginx\", \"-g\", \"daemon off;\"]" container.tar nginx` \
  <img src="../misc/images/part2_12.png" alt=part2_12 width="700"/>
- Run the imported container: \
  `docker run -d -p 80:80 --name nginx_container nginx` \
  <img src="../misc/images/part2_13.png" alt=part2_13 width="700"/>
- Check that localhost:80/status returns the nginx server status page: \
  <img src="../misc/images/part2_14.png" alt=part2_14 width="700"/> \
  <img src="../misc/images/part2_15.png" alt=part2_15 width="700"/>

## Part 3. Mini web server

- First install gcc, libfcgi, spawn-fcgi, nginx on virtual machine: \
  `$> sudo apt install gcc` \
  `$> sudo apt install libfcgi-dev` \
  `$> sudo apt install spawn-fcgi` \
  `$> sudo apt install nginx`
- Write a mini server in C and FastCgi that will return a simple page saying Hello World! \
  <img src="../misc/images/part3_01.png" alt=part3_01 width="700"/>
- Run the written mini server via spawn-fcgi on port 8080: \
  `$> gcc server/hello_world.c -o server/hello_world -lfcgi` \
  `$> spawn-fcgi -p 8080 server/hello_world` \
  <img src="../misc/images/part3_02.png" alt=part3_02 width="700"/>
- Write your own nginx.conf that will proxy all requests from port 81 to 127.0.0.1:8080 \
  <img src="../misc/images/part3_03.png" alt=part3_03 width="700"/> \
  then `$>sudo cp nginx/ngnix.conf /etc/nginx/conf.d` \
  then `$>sudo nginx -t` \
  then `$>sudo nginx -s reload` \
  <img src="../misc/images/part3_04.png" alt=part3_04 width="700"/>
- Check that browser on localhost:81 returns the page you wrote \
  <img src="../misc/images/part3_05.png" alt=part3_05 width="700"/>
  
## Part 4. Your own docker

- Write your own docker image that: 
  1) builds mini server sources on FastCgi 
  2) runs it on port 8080 
  3) copies inside the image written ./nginx/nginx.conf 
  4) runs nginx 
  <img src="../misc/images/part4_01.png" alt=part4_01 width="700"/>
- Build the written docker image with docker build, specifying the name and tag: \
  `docker build -t hello_world:latest . ` \
  <img src="../misc/images/part4_02.png" alt=part4_02 width="700"/>
- Check with docker images that everything is built correctly \
  <img src="../misc/images/part4_03.png" alt=part4_03 width="700"/>
- Run the built docker image by mapping port 81 to 80 on the local machine and mapping the ./nginx folder inside the container \
  `docker run -d -p 80:81 -v ./nginx:/etc/nginx/conf.d --name hello hello_world:latest` \
  <img src="../misc/images/part4_04.png" alt=part4_04 width="700"/>
- Check that the page of the written mini server is available on localhost:80 \
  <img src="../misc/images/part4_05.png" alt=part4_05 width="700"/>
- Add proxying of /status page in ./nginx/nginx.conf to return the nginx server status \
  <img src="../misc/images/part4_06.png" alt=part4_06 width="700"/>
- Restart docker image; \
  Check that localhost:80/status now returns a page with nginx status: \
  <img src="../misc/images/part4_07.png" alt=part4_07 width="700"/>

## Part 5. Dockle

- Check the image from the previous task with dockle [image_id|repository] \
  <img src="../misc/images/part5_01.png" alt=part5_01 width="700"/>
- Fix the image so that there are no errors or warnings when checking with dockle: \
  <img src="../misc/images/part5_02.png" alt=part5_02 width="700"/> \
  <img src="../misc/images/part5_03.png" alt=part5_03 width="700"/>
  
## Part 6. Basic Docker Compose

- Write a docker-compose.yml file, using which:
  1) Start the docker container from Part 5;
  2) Start the docker container with nginx which will proxy all requests \
     from port 8080 to port 81 of the first container
  <img src="../misc/images/part6_01.png" alt=part6_01 width="700"/>
  <img src="../misc/images/part6_00.png" alt=part6_00 width="700"/>
- Stop all running containers \
  <img src="../misc/images/part6_02.png" alt=part6_02 width="700"/>
- Build and run the project with the `docker-compose build` and `docker-compose up` commands: \
  <img src="../misc/images/part6_03.png" alt=part6_03 width="700"/> \
  <img src="../misc/images/part6_04.png" alt=part6_04 width="700"/>
- Check that the browser returns the page you wrote on localhost:80 as before: \
  <img src="../misc/images/part6_05.png" alt=part6_05 width="700"/> \
  <img src="../misc/images/part6_06.png" alt=part6_06 width="700"/> \
  <img src="../misc/images/part6_07.png" alt=part6_07 width="700"/>
  
 




  


  
