# Novus Power Products Network Flash

NOVUS-NET-FLASH

Description:
In order to reflash a novus product we need to setup a machine to serve our image files and set our product to boot from those served files.

The script included here installs the programs needed for serving and pulls down our image and unpacks it to a directory.

That directory is then served and you can even access the files on other machines by using "tftp localhost" then "get Image.gz" as an example. 

Then to set our product to netboot we need to interrupt the normal boot sequence by pressing any key while attached to the debug port then configuring the environment.

The environment instuctions are in the script output. You will need to know the ip address of your host (linux machine serving the files).

Prerequisites: 

- novus product

- linux machine (tested on ubuntu 24.04)
  
- physical connection to the debug port of the product (use putty or similar)

- network connection between the product and the linux machine (make sure they are reachable, ping or similar)
  
Use this script to reflash novus systems with our novus-5.4.85-1.0 image via ethernet

Run the following on the linux (host) machine: 
```
git clone https://github.com/jowens25/novus-net-flash.git

cd ~/novus-net-flash

./setup-server.sh
```
Follow instructions in the script

Troubleshooting:

- Watch the debug console for timeouts and host selection (usually a network or image issue) -> re-run setup script -> re-run product environment setup steps.
