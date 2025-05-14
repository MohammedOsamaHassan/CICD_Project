# CICDProject
# 🕒 Analog Clock CI/CD Project

This project demonstrates a complete CI/CD pipeline to deploy a simple Analog Clock web application using:

- **Terraform** for infrastructure provisioning (Jenkins server, Kubernetes cluster)
- **Jenkins** for Continuous Integration and Deployment
- **Docker** for containerization
- **Docker Hub** as the container registry
- **Kubernetes** (Master & Worker nodes) for deployment and orchestration

---

## 📸 Architecture Diagram

![CI/CD Architecture](diagram.png)

---

## 🌍 Live Demo

- **URL**: [http://44.199.241.78:30007](http://44.199.241.78:30007)

---

## 🔧 Features

- Infrastructure as Code (IaC) using Terraform  
- Jenkins automates:
  - Pulling source code from GitHub  
  - Building Docker images  
  - Pushing to Docker Hub  
  - Deploying to Kubernetes  
- Dockerized frontend  
- Kubernetes Deployment and NodePort Service  

---

## 📁 Folder Structure

```
analog-clock-cicd/
│
├── app/                  # Analog Clock web application source code
│   ├── index.html
│   └── clock.js
│
├── docker/
│   └── Dockerfile        # Dockerfile for building the app image
│
├── jenkins/
│   └── Jenkinsfile       # Jenkins pipeline script
│
├── k8s/
│   ├── deployment.yaml   # K8s Deployment manifest
│   └── service.yaml      # K8s Service manifest
│
├── terraform/
│   ├── main.tf           # Main Terraform config
│   ├── network.tf        # VPC and networking
│   ├── jenkins.tf        # Jenkins EC2 provisioning
│   └── kubernetes.tf     # K8s infra setup
│
├── diagram.png           # CI/CD architecture image
├── Result.png            # Web App screenshot
└── README.md             # Project documentation
```

---

## ⚙️ Setup & Deployment Steps

### Step 1: Provision Infrastructure (Terraform)

```bash
cd terraform
terraform init
terraform apply
```

This creates:
- VPC  
- Public/private subnets  
- Internet Gateway  
- Security groups  
- EC2 instance (Jenkins)  
- Kubernetes cluster (Master & Worker nodes)  

---

### Step 2: Set Up Jenkins

- Access Jenkins via public IP  
- Install Plugins:
  - GitHub  
  - Docker Pipeline  
  - Kubernetes CLI  
- Add credentials for:
  - GitHub repo access  
  - Docker Hub push  

---

### Step 3: Configure Jenkins Pipeline

Use the `Jenkinsfile` under `/jenkins` to set up the pipeline with the following stages:

- Checkout from GitHub  
- Build Docker image  
- Push to Docker Hub  
- Deploy on Kubernetes  

---

### Step 4: Docker Commands

```bash
docker build -t analog-clock .
docker tag analog-clock your-dockerhub-username/analog-clock
docker push your-dockerhub-username/analog-clock
```

---

### Step 5: Deploy to Kubernetes

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

Access the app via:

```
http://<EC2-IP>:<NodePort>
```

---

## 🖼️ Screenshots

### Web Application Interface

![App Result](Result.png)

---

## 💻 Technologies Used

- **AWS EC2, VPC**  
- **Terraform**  
- **Jenkins**  
- **Docker & Docker Hub**  
- **Kubernetes**  
- **GitHub**  

---

## 👨‍💻 Author

**Your Name**  
System Administrator & DevOps Trainee @ ITI

---

## 📜 License

This project is licensed under the [MIT License](LICENSE)
