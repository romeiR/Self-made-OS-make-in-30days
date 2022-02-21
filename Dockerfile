FROM ubuntu:20.04
RUN apt update
RUN apt upgrade -y
RUN apt install git -y
RUN apt install nano
RUN apt install dosfstools
RUN apt install ansible -y
WORKDIR /root
RUN git clone https://github.com/uchan-nos/mikanos-build.git osbook
WORKDIR /root/osbook/devenv
RUN ansible-playbook -K -i ansible_inventory ansible_provision.yml
WORKDIR /root
RUN git clone https://github.com/uchan-nos/mikanos.git
WORKDIR /root/mikanos
RUN git checkout osbook_day02a
WORKDIR /root/edk2
RUN ln -s ../mikanos/MikanLoaderPkg ./
WORKDIR /root/edk2/Conf
RUN rm -rf target.txt
RUN touch target.txt
ADD target.txt /root/edk2/Conf/target.txt
WORKDIR /root
RUN mkdir -p mnt
RUN qemu-img create -f raw disk.img 200M
RUN mkfs.fat -n "MIKAN OS" -s 2 -f 2 -R 32 -F 32 disk.img
VOLUME /disk.img
WORKDIR /root/mnt/EFI/BOOT
WORKDIR /root
ADD run_qemu.sh /root
RUN chmod 777 run_qemu.sh
RUN chmod 777 run_qemu.sh