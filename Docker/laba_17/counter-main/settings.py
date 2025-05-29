import os

# Server settings
SERVER_HOST = os.environ.get("SERVER_HOST", "0.0.0.0")
SERVER_PORT = os.environ.get("SERVER_PORT", 80)

# Redis settings
REDIS_HOST = os.environ.get("REDIS_HOST", "redis")
REDIS_PORT = os.environ.get("REDIS_PORT", 6379)
REDIS_PWD = os.environ.get("REDIS_PWD", "qwerty")
