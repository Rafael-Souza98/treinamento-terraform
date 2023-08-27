
locals {

  servidores = {
    web = {
      package_name = "httpd"
      service_name = "httpd"
    },
    db = {
      package_name = "mariadb-server"
      service_name = "mysqld"
    },
    web1 = {
      package_name = "nginx"
      service_name = "nginx"
    },
  }

  ingress_ports = {
    web = [
      {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        source    = "0.0.0.0/0"
      },
      {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        source    = "0.0.0.0/0"
      },
      {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"
        source    = "0.0.0.0/0"
      }
    ],
    db = [
      # mysql
      {
        from_port = 3306
        to_port   = 3306
        protocol  = "tcp"
        source    = "0.0.0.0/0"
      },
      {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        source    = "0.0.0.0/0"
      }
    ]
  }
}
