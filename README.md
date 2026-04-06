###  Cloud-Native DevOps Pipeline on AWS EKS

##  Project Overview

This project demonstrates a **production-style end-to-end DevOps pipeline** built on AWS using Kubernetes (EKS).

Instead of just deploying an app, the focus was on:

* Handling **real-world failures**
* Debugging infrastructure and deployments
* Understanding how components behave under issues

This project simulates how actual DevOps systems are built, monitored, and fixed.

---

##  Architecture Flow

```
Developer → GitHub → Jenkins CI/CD → Docker → AWS ECR →
Terraform (Infra) → AWS EKS → Kubernetes →
ALB Ingress → Prometheus → Grafana
```

---

##  Tech Stack

* **Cloud**: AWS (EKS, EC2, ECR, IAM, ALB)
* **Containerization**: Docker
* **Orchestration**: Kubernetes
* **Infrastructure as Code**: Terraform
* **CI/CD**: Jenkins
* **Monitoring**: Prometheus + Grafana

---

##  Project Structure

```
eks-devops-project/
├── app/            # Node.js application
├── k8s/            # Kubernetes manifests
├── terraform/      # Infrastructure code
├── screenshots/    # Proof of work (logs, dashboards, infra)
└── README.md
```

---

## ⚙️ Workflow (Real Execution Flow)

1. Infrastructure provisioned using **Terraform**
2. Application containerized using **Docker**
3. Docker image pushed to **AWS ECR**
4. Kubernetes deployment & service applied
5. Application exposed using **ALB Ingress**
6. Jenkins automates CI/CD pipeline
7. Monitoring enabled via **Prometheus & Grafana**

---

##  Real-World Issues Faced & Debugging

###  1. Jenkins Plugin Failures

**Issue:**
Plugin installation failed during Jenkins setup

**Root Cause:**
Installing too many plugins at once caused dependency conflicts

**Fix:**

* Restarted Jenkins
* Installed only required plugins manually

---

###  2. Jenkins UI Broken

**Issue:**
UI not loading properly

**Root Cause:**
Browser cache + incomplete plugin load

**Fix:**

* Cleared browser cache
* Restarted Jenkins service

---

###  3. Ingress Not Working (504 Gateway Timeout)

**Issue:**
Application not accessible via Load Balancer

**Root Cause:**

* Service not properly linked
* Target group health checks failing

**Debug Steps:**

```
kubectl get pods
kubectl get svc
kubectl describe ingress
```

**Fix:**

```
kubectl delete ingress devops-ingress --force
kubectl apply -f ingress.yaml
```

---

###  4. Pods Not Updating After Deployment

**Issue:**
New image pushed but old pods still running

**Root Cause:**
Kubernetes does not auto-refresh images without trigger

**Fix:**

```
kubectl rollout restart deployment devops-app
```

---

###  5. ImagePullBackOff Error

**Issue:**
Pods failing to pull Docker image

**Root Cause:**

* Incorrect ECR image URI
* IAM permission issues

**Fix:**

* Corrected image URL
* Verified ECR access permissions

---

###  6. Jenkins Build Failures

**Issue:**
Pipeline failed during Docker build

**Root Cause:**

* Syntax errors in Dockerfile
* Dependency issues

**Fix:**

* Checked Jenkins logs
* Fixed build errors
* Re-triggered pipeline

---

##  Monitoring

* **Prometheus** used for collecting cluster metrics
* **Grafana** used for visualization

Verified:

* CPU usage
* Node memory
* Pod-level metrics

---

##  Cost Optimization

* Used **t3.micro instances**
* Avoided NAT Gateway (cost saver)
* Minimal node configuration
* Destroyed infra after testing

---

##  What I Learned

* Real Kubernetes troubleshooting (not just theory)
* AWS EKS networking & architecture
* CI/CD pipeline debugging
* Handling production-like failures
* Monitoring & observability basics

---

##  Cleanup

```
cd terraform
terraform destroy
```

---

##  Final Note

This project was not a smooth setup.

Multiple failures occurred during:

* Infrastructure provisioning
* CI/CD pipeline execution
* Kubernetes deployment

Fixing these issues provided a **real DevOps experience**, beyond tutorials.

---

## Author

**Rahul Rana**
DevOps & Cloud Engineering Aspirant

