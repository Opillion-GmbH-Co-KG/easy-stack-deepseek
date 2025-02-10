# EASY STACK DEEPSEEK

This stack is designed to provide a fully integrated AI solution. Ollama serves as the backend for AI model execution, Qdrant enhances search and retrieval capabilities with vector-based indexing, and Open WebUI offers a seamless interface for user interaction. Together, these components enable efficient AI-powered applications with robust search and analysis features. The `deepseek-r1:32b` model, included by default, provides high-quality text generation and reasoning capabilities, making it ideal for AI-driven workflows.

The model: deepseek-r1:32b is relatively large at 19 GB and will be downloaded during the first start of the stack. Depending on your internet connection, this may take some time. No download is necessary on subsequent starts. Please check the Docker logs to monitor the progress.

## **Stack Overview**
![Alt text](.makefile/assets/app.png?raw=true" "Open Webui")

## Used Projects
<a href="https://github.com/open-webui/open-webui">
    <img src="https://avatars.githubusercontent.com/u/158137808?s=48&v=4" width="150" alt="Open WebUI Logo">
</a>
<a href="https://raw.githubusercontent.com/qdrant/qdrant">
    <img src="https://raw.githubusercontent.com/qdrant/qdrant/master/docs/logo.svg" width="150" alt="Qdrant Logo">
</a>
<a href="https://github.com/ollama/ollama">
    <img src="https://github.com/ollama/ollama/assets/3325447/0d0b44e2-8f4a-4e99-9b52-a5c1c741c8f7" width="150" alt="Ollama Logo">
</a>
<a href="https://raw.githubusercontent.com/deepseek-ai/DeepSeek-V2">
    <img src="https://raw.githubusercontent.com/deepseek-ai/DeepSeek-V2/refs/heads/main/figures/logo.svg" width="150" alt="DeepSeek AI Logo">
</a>


## Docker Compose Setup

### **Services**

### **Ollama**
- **Image:** Custom build
- **Description:** Ollama is an AI model hosting service designed to manage and serve machine learning models efficiently. It allows for seamless deployment and interaction with AI models, enabling applications to leverage advanced AI capabilities for various tasks such as natural language processing and predictive analytics. By default, the `deepseek-r1:32b` model is installed, which is a state-of-the-art large language model optimized for reasoning, text generation, and AI-powered insights.
- **Ports:**
  - **Internal:** `${OLLAMA_INTERNAL_PORT}`
- **Name:** ollama

### **Qdrant**
- **Image:** Custom build
- **Description:** Qdrant is a high-performance vector search database optimized for handling AI-driven search queries. It efficiently processes embeddings from machine learning models, making it ideal for similarity search, recommendation systems, and AI-powered discovery applications.
- **Ports:**
  - **Internal:** `${QDRANT_INTERNAL_PORT}`
- **Name:** qdrant

### **Qdrant Frontend**
- **Image:** Custom build
- **Description:** A web-based UI for managing and interacting with Qdrant, providing an intuitive interface for vector search database operations.
- **Ports:**
  - **External:** `${QDRANT_FRONTEND_EXTERNAL_PORT} -> ${QDRANT_FRONTEND_INTERNAL_PORT}`
- **Name:** qdrant-frontend

### **Open WebUI**
- **Image:** Custom build
- **Description:** Open WebUI provides a user-friendly web interface for interacting with AI models hosted on Ollama. It allows users to query models, visualize results, and manage AI-based tasks in an intuitive and accessible way.
- **Ports:**
  - **External:** `${OPEN_CHAT_UI_EXTERNAL_PORT} -> ${OPEN_CHAT_UI_INTERNAL_PORT}`
- **Name:** open-webui

### **Licenses**
- **DeepSeek-R1:** [MIT License](https://github.com/deepseek-ai/DeepSeek-R1/blob/main/LICENSE)
- **Ollama:** [Apache 2.0 License](https://github.com/jmorganca/ollama/blob/main/LICENSE)
- **Qdrant:** [Apache 2.0 License](https://github.com/qdrant/qdrant/blob/master/LICENSE)
- **Qdrant WebUi:** [Apache 2.0 License](https://github.com/qdrant/qdrant-web-ui/blob/master/LICENSE)
- **Open WebUI:** [MIT License](https://github.com/open-webui/open-webui/blob/main/LICENSE)

#### Caution! Caution! This stack is intended for development use only and is not configured for production. Please make sure to change all passwords immediately. You can override the values from the .env.dist file with a custom .env file. For production use, please refer to the "Easy-Stack-Prod" stack - comming soon.

## Installation and Starting the Application
To install and start the application, follow these steps:

### Prerequisites
- Docker and Docker Compose must be installed on the system.

#### Before you run this project, ensure the following are installed on your host system:

- Git
- Docker
- Docker Compose
- Make

#### Build this stack


Clone this Project

```sh
git clone git@github.com:Opillion-GmbH-Co-KG/easy-stack-deepseek.git

cd ./easy-stack-deepseek

 ```

To start and install this stack:

```sh
make start
 ```
or

```sh
make restart
```

## This Stack is based on Easy Stack Mini

[![Easy Stack Mini - DALL-E Image](.makefile/assets/easy-stack-mini.jpg?raw=true)](https://github.com/Opillion-GmbH-Co-KG/easy-stack-mini)


