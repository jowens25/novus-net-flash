# Novus Power Products Network Flash

NOVUS-NET-FLASH

Prerequisites: 

- novus product

- linux machine (tested on ubuntu 24.04)
  
- physical connection to the debug port of the product (use putty or similar)

- network connection between the product and the linux machine (make sure they are reachable, ping or similar)
  
Use this script to reflash novus systems with our novus-5.4.85-1.0 image via ethernet

Run the following: 

git clone https://github.com/jowens25/novus-net-flash.git

cd ~/novus-net-flash

./setup-server.sh

Follow instructions from the script
