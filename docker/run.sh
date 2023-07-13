```bash
# create container based on a pytorch docker img
USER_ID=$(id -u)
GRP=$(id -g -n)
GRP_ID=$(id -g)

IMG=pytorch/pytorch:1.6.0-cuda10.1-cudnn7-devel
CONTAINER_NAME=resa
docker run -it \
    --gpus all \
        -d \
        --privileged \
        --name $CONTAINER_NAME \
        -e DOCKER_USER=$USER \
        -e USER=$USER \
        -e DOCKER_USER_ID=$USER_ID \
        -e DOCKER_GRP=$GRP \
        -e DOCKER_GRP_ID=$GRP_ID \
        -e DISPLAY=unix$DISPLAY \
        -v /etc/localtime:/etc/localtime:ro \
        -v /mnt/xt/8T/:/mnt/xt/8T/ \
        --device /dev/dri \
        --shm-size 10240M \
        $IMG \
        /bin/bash 
```

```bash
# into container
xhost +local
docker exec -it resa bash
```


```bash
# install dependency
apt-get update
apt-get install -y libopencv-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*


# 
cd /mnt/xt/8T/CODES/CV/resa
pip install -U pip
sed "s/sklearn/scikit-learn/g" requirement.txt  | xargs pip install
pip install yapf
```
