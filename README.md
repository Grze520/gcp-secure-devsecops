# Secure DevSecOps Pipeline on Google Cloud Platform (GCP)

## 🚀 Project Overview
This project demonstrates a production-ready, highly secure DevSecOps pipeline that automates infrastructure deployment on Google Cloud Platform using **Terraform** and **GitHub Actions**. 
The entire setup is built following **Zero Trust** architecture and modern cloud security patterns.

## 🔒 Security Architecture Features
* **Keyless Authentication (OIDC):** Utilizes Google Cloud Workload Identity Federation instead of static, high-risk service account JSON keys. Identity is verified dynamically via GitHub's OIDC tokens.
* **Network Isolation & IAP:** The infrastructure is deployed within a custom, secure VPC. Public SSH access (port 22) is completely disabled. Management is done securely via **Identity-Aware Proxy (IAP)**.
* **Strict Attribute Conditions:** GCP Workload Identity Provider is configured to only accept incoming tokens originating strictly from this specific repository and the `main` branch.
* **Containerized Deployment:** The web application runs inside a lightweight, hardened Docker container (`nginx:alpine`).

## 🛠️ Tech Stack
* **Cloud:** Google Cloud Platform (Compute Engine, VPC Network, IAM, IAP)
* **Infrastructure as Code:** Terraform
* **CI/CD & Automation:** GitHub Actions
* **Containerization:** Docker

## 📈 Pipeline Workflow
1. **Security Auditing:** Static code analysis of Terraform scripts.
2. **Secure Terraform Deploy:** Keyless authentication via OIDC -> Automated setup of VPC, Firewalls, and VM.
3. **App Bootstrap:** Deployment of a hardened Docker container serving the application.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🚀 Przegląd projektu
Projekt przedstawia gotowy do wdrożenia produkcyjnego, wysoce bezpieczny potok automatyzacji infrastruktury (DevSecOps Pipeline) w chmurze Google Cloud Platform, 
wykorzystujący narzędzia **Terraform** oraz **GitHub Actions**. Całość została zaprojektowana zgodnie z architekturą **Zero Trust** oraz nowoczesnymi wzorcami bezpieczeństwa chmurowego.

### 🔒 Funkcje architektury bezpieczeństwa
* **Autoryzacja bezkluczowa (Keyless Auth / OIDC):** Projekt całkowicie eliminuje potrzebę stosowania statycznych, podatnych na wycieki kluczy JSON dla kont usługowych.
  Tożsamość potoku GitHub Actions jest weryfikowana dynamicznie przy użyciu tokenów kryptograficznych standardu OIDC przez usługę **GCP Workload Identity Federation**.
* **Izolacja sieciowa i IAP:** Infrastruktura została osadzona w dedykowanej, bezpiecznej sieci VPC. Publiczny dostęp przez port SSH (22) został całkowicie zablokowany.
  Bezpieczne zarządzanie maszynami wirtualnymi odbywa się za pomocą tunelowania proxy – **Identity-Aware Proxy (IAP)**.
* **Restrykcyjne warunki atrybutów:** Dostawca tożsamości (Workload Identity Provider) w GCP został skonfigurowany w taki sposób, aby akceptować wyłącznie żądania pochodzące bezpośrednio z tego konkretnego
  repozytorium oraz gałęzi (brancha) `main`.
* **Konteneryzacja aplikacji:** Aplikacja webowa została uruchomiona wewnątrz zoptymalizowanego, bezpiecznego kontenera Docker (`nginx:alpine`).

### 🛠️ Stos technologiczny
* **Chmura obliczeniowa:** Google Cloud Platform (Compute Engine, VPC Network, IAM, IAP)
* **Infrastruktura jako Kod (IaC):** Terraform
* **Automatyzacja i CI/CD:** GitHub Actions
* **Konteneryzacja:** Docker

### 📈 Przebieg potoku (Pipeline)
1. **Security Auditing:** Statyczna analiza kodu skryptów Terraform pod kątem podatności.
2. **Secure Terraform Deploy:** Autoryzacja bezkluczowa przez OIDC -> Automatyczne postawienie sieci VPC, reguł zapory sieciowej oraz maszyn VM.
3. **App Bootstrap:** Uruchomienie i konfiguracja bezpiecznego kontenera Docker obsługującego aplikację.
