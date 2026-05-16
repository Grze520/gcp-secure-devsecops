# 1. Definiujemy dedykowaną, odizolowaną sieć VPC (brak domyślnych podatnych reguł)
resource "google_compute_network" "secure_vpc" {
  name                    = "secure-devops-vpc"
  auto_create_subnetworks = false
}

# 2. Definiujemy podsieć w bezpiecznym regionie europejskim
resource "google_compute_subnetwork" "secure_subnet" {
  name          = "secure-subnet-europe"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west3" # Frankfurt
  network       = google_compute_network.secure_vpc.id
}

# 3. Reguła Firewall - Wpuszczamy tylko ruch sieciowy na port HTTP (80)
resource "google_compute_firewall" "allow_http" {
  name    = "secure-allow-http"
  network = google_compute_network.secure_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # Ruch dozwolony z każdego źródła, ale aplikowany tylko do maszyn z konkretnym tagiem
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["secure-web-server"]
}

# 4. Utwardzona Maszyna Wirtualna (Compute Engine)
resource "google_compute_instance" "web_server" {
  name         = "hardened-web-server"
  machine_type = "e2-medium"
  zone         = "europe-west3-c"

  tags = ["secure-web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.secure_subnet.id
    access_config {} # Nadaje tymczasowe publiczne IP do testów curl
  }

  # Cybersec Hardening: Blokada klasycznego SSH na rzecz bezpiecznego OS Login z audit-logami
  metadata = {
    block-project-ssh-keys = "true"
    enable-oslogin         = "TRUE"
  }

  # Skrypt startowy - instaluje Dockera i odpala bezpieczny kontener
  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    
    # Uruchomienie aplikacji na porcie 80
    sudo docker run -d -p 80:80 --name secure-app nginx:alpine
  EOT
}