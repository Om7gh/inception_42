build:
		docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
		docker-compose -f ./srcs/docker-compose.yml down
clean: 	down
		docker image prune -a || true
		docker volume rm -f mariadb wordpress || true
		sudo rm -rf ../../data/wordpress/* || true
		sudo rm -rf ../../data/mariadb/* || true

re : clean build
