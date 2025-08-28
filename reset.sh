echo "Stopping and removing Docker containers : docker compose down" && docker compose down
echo "Removing all Docker volumes : docker system prune -f" && docker system prune -f
echo "Removing IRIS volumes "  && rm -rf ./volumes
echo "Removing images" && docker rmi supply-chain-warehouse-employees-1-iris:latest 
echo "Rebuilding Docker images : docker compose build --no-cache" && docker compose build --no-cache
echo "Starting Docker containers : docker compose up -d" && docker compose up -d