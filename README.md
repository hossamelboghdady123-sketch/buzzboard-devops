# 🚀 BuzzBoard DevOps Project

A production-style DevOps project demonstrating the deployment and automation of a full-stack application on AWS EKS using Infrastructure as Code, CI/CD, GitOps, Kubernetes, and cloud-native monitoring.

## 🏗️ Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ├── GitHub Actions
    │       │
    │       ├── Build Spring Boot Backend
    │       └── Build Docker Image
    │
    ▼
Argo CD
    │
    ▼
Amazon EKS
    │
    ├── Frontend Deployment
    ├── Backend Deployment
    ├── Horizontal Pod Autoscaler
    └── AWS Load Balancer Controller
            │
            ▼
     Application Load Balancer
            │
            ├── Frontend
            └── Backend API
                    │
                    ▼
              Amazon RDS
              PostgreSQL

Monitoring:
Prometheus → Grafana
```

## 🛠️ Technologies Used

* AWS EKS
* Amazon RDS PostgreSQL
* AWS Application Load Balancer
* Terraform
* Kubernetes
* Docker
* GitHub Actions
* Argo CD
* Helm
* Prometheus
* Grafana
* Spring Boot
* Java 17
* PostgreSQL
* NGINX

## 📁 Project Structure

```text
buzzboard-devops/
├── .github/
│   └── workflows/
│       └── backend-ci.yml
│
├── backend/
│
├── frontend/
│
├── kubernetes/
│   ├── backend/
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   ├── secret.yaml
│   │   └── hpa.yaml
│   │
│   ├── frontend/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   │
│   └── ingress/
│       └── buzzboard-ingress.yaml
│
├── terraform/
│
└── README.md
```

## ☁️ Infrastructure

The AWS infrastructure is provisioned using Terraform.

The infrastructure includes:

* Amazon VPC
* Public and private subnets
* Internet Gateway
* NAT Gateway
* IAM roles and policies
* Amazon EKS cluster
* EKS managed node groups
* Amazon RDS PostgreSQL
* Security groups

## ☸️ Kubernetes Deployment

The application runs on Amazon EKS using:

* Frontend Deployment
* Backend Deployment
* Kubernetes Services
* AWS ALB Ingress
* Liveness probes
* Readiness probes
* Resource requests and limits
* Horizontal Pod Autoscaler

Backend configuration:

```text
Replicas: 2
Minimum replicas: 2
Maximum replicas: 5

CPU request: 100m
CPU limit: 500m

Memory request: 256Mi
Memory limit: 512Mi
```

## 🔄 CI/CD Pipeline

GitHub Actions is used for Continuous Integration.

The pipeline performs:

1. Checkout source code
2. Configure Java 17
3. Build the Spring Boot application
4. Package the application using Maven
5. Build the Docker image

## 🔁 GitOps with Argo CD

Argo CD continuously monitors the Kubernetes manifests stored in GitHub.

Automatic synchronization is enabled with:

* Auto Sync
* Self Heal
* Prune

This ensures that the EKS cluster automatically matches the desired state stored in GitHub.

## 📈 Monitoring

The monitoring stack is deployed using Helm and includes:

* Prometheus
* Grafana
* Alertmanager
* kube-state-metrics
* Node Exporter

Monitoring is used to observe:

* Kubernetes cluster health
* Pod status
* CPU utilization
* Memory utilization
* Node metrics

## 📸 Screenshots

### BuzzBoard Application

![BuzzBoard Application](screenshots/buzzboard-app.png)

### Argo CD

![Argo CD](screenshots/argocd-backend.png)

### GitHub Actions

![GitHub Actions](screenshots/github-actions.png)

### Kubernetes Pods

![Kubernetes Pods](screenshots/kubernetes-pods.png)

### Horizontal Pod Autoscaler

![HPA](screenshots/hpa.png)

### Grafana Dashboard

![Grafana](screenshots/grafana-dashboard.png)

## ✅ Project Status

* [x] AWS infrastructure provisioned with Terraform
* [x] EKS cluster deployed
* [x] Frontend deployed on Kubernetes
* [x] Backend deployed on Kubernetes
* [x] PostgreSQL deployed on Amazon RDS
* [x] AWS ALB Ingress configured
* [x] Backend health checks configured
* [x] HPA configured
* [x] GitHub Actions CI configured
* [x] Argo CD GitOps configured
* [x] Prometheus monitoring deployed
* [x] Grafana monitoring deployed

## 👤 Author

**Hossam Elboghdady**

 DevOps Engineer | Kubernetes | AWS | Terraform | CI/CD

